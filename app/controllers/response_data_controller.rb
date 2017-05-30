class ResponseDataController < ApplicationController
  before_filter :set_default_response_format

  def sync
    plaid_accounts = current_user.plaid_accounts

    plaid_accounts.each do |plaid_account|
      plaid_account.pull_transactions
    end
  end

  def show
    plaid_accounts = current_user.plaid_accounts

    transactions = []

    plaid_accounts.each do |plaid_account|
      bank_accounts = BankAccount.where(considered: true).where(plaid_account: plaid_account)

      bank_accounts.each do |bank_account|
        transactions += bank_account.transactions.where("date >= ?", 11.months.ago.beginning_of_month).where.not(ignore: true).all.to_a
      end
    end

    transactions = transactions.sort_by {|t| [t[:date], t[:created_at]]}.reverse

    @response_data = ResponseData.new

    transactions.each do |txn|
      txn.amount = txn.amount * - 1
      @response_data.get_month_data(txn.month, txn.year).add_transaction(txn)
    end
  end

  def set_default_response_format
    request.format = :json
  end
end
