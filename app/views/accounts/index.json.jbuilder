json.array!(@plaid_accounts) do |plaid_account|
  json.(plaid_account, :id, :institution)
  json.accounts plaid_account.bank_accounts do |account|
    json.(account, :name, :account_number, :available, :balance, :considered)
  end
end

