class WebhookController < ApplicationController
  def transactions
    plaid_account = PlaidAccount.find(params[:id])

    situation_before = SpendingCalculator.situation_this_month(plaid_account.user)
    plaid_account.pull_transactions
    situation_after = SpendingCalculator.situation_this_month(plaid_account.user)

    if situation_after.received > situation_before.received
      plaid_account.user.send_positive_push_notification(situation_after.received - situation_before.received)
    elsif situation_after.spent > situation_before.spent
      plaid_account.user.send_negative_push_notification(situation_after.spent - situation_before.spent)
    end
  end

  def show
    plaid_account = PlaidAccount.find(params[:id])
    json = Plaid.call.get_request("connect", plaid_account.access_token, { pending: true })
    render json: json
  end
end
