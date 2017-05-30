require "net/http"
require "uri"
require "action_view"

class User < ActiveRecord::Base

  include ActionView::Helpers::NumberHelper

  has_many :plaid_accounts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def send_positive_push_notification(amount_delta)
    message = "You received some money: #{ number_to_currency(amount_delta) }"
    send_push_notification(message)
  end

  def send_negative_push_notification(amount_delta)
    message = "You spent more #{ number_to_currency(amount_delta) }, totalling #{ number_to_currency(SpendingCalculator.situation_this_month(self).spent) } this month with #{ days_until_end_of_month } days to go."
    send_push_notification(message)
  end

  def days_until_end_of_month
    (Date.today.at_beginning_of_month.next_month - Date.today).to_i
  end

  def tag_transfers
    plaid_accout_ids = PlaidAccount.where(user_id: id).pluck(:id)
    bank_account_ids = BankAccount.where(plaid_account_id: plaid_accout_ids).pluck(:id)
    deposit_transactions = Transaction.where(bank_account_id: bank_account_ids).
                                       where("amount < 0").
                                       where(transfer_transaction_id: nil)

    deposit_transactions.each do |txn|
      opposite_transactions = Transaction.where(bank_account_id: bank_account_ids).
                                          where(amount: txn.amount * -1).
                                          where(transfer_transaction_id: nil)

      closest_transaction = nil
      closest_time_difference = 5
      opposite_transactions.each do |opposite_transaction|
        if closest_time_difference > (opposite_transaction.date - txn.date).to_i.abs
          closest_time_difference = (opposite_transaction.date - txn.date).abs
          closest_transaction = opposite_transaction
        end
      end

      if closest_transaction
        closest_transaction.transfer_transaction_id = txn.id
        txn.transfer_transaction_id = closest_transaction.id

        if txn.ignore || closest_transaction.ignore
          txn.ignore = true
          closest_transaction.ignore = true
        end

        closest_transaction.save!
        txn.save!
      end
    end
  end

  private

  def send_push_notification(message)
    if push_token
      json = {
        tokens: [push_token],
        profile: "main",
        notification: {
          message: message,
          android: {
            collapseKey: "transactions",
            delayWhileIdle: false,
            payload: { }
          }
        }
      }

      HTTParty.post("https://api.ionic.io/push/notifications",
        headers: { "Authorization" => "Bearer #{ENV['IONIC_PUSH_KEY']}", "Content-Type" => "application/json" },
        body: JSON.generate(json)
      )
    end
  end
end
