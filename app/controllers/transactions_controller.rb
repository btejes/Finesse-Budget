class TransactionsController < ApplicationController
  before_filter :set_default_response_format

  def set_default_response_format
    request.format = :json
  end

  def update
    transaction = Transaction.find(params[:id])

    raise "Unauthorized" unless current_user == transaction.bank_account.plaid_account.user

    transaction.ignore = params[:ignore]
    transaction.save!
  end
end
