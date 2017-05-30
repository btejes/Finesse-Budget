class AccountsController < ApplicationController
  before_filter :set_default_response_format

  def index
    @plaid_accounts = current_user.plaid_accounts
  end

  def create
    public_token = params[:public_token]

    result = Plaid.call.exchange(public_token)

    plaid_account = PlaidAccount.new
    plaid_account.public_token = public_token
    plaid_account.access_token = result[:access_token]
    plaid_account.user = current_user
    plaid_account.institution = params[:institution]
    plaid_account.save!

    plaid_account.pull_transactions

    options = { webhook:  "https://#{ENV['HOST']}/webhook/#{plaid_account.id}/transactions" }
    Plaid.call.patch_request("connect", plaid_account.access_token, options)
  end

  def set_default_response_format
    request.format = :json
  end

  def destroy
    plaid_account = PlaidAccount.find(params[:id])
    if plaid_account.user == current_user
      plaid_account.destroy
    end
  end

  def update
    plaid_account = PlaidAccount.find(params[:id])
    plaid_account.pull_transactions
  end
end
