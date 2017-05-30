class SpendingCalculator
  def self.situation_this_month(user)
    transactions = []
    user.plaid_accounts.each do |plaid_account|
      bank_accounts = BankAccount.where(considered: true).where(plaid_account: plaid_account)

      bank_accounts.each do |bank_account|
        transactions += bank_account.transactions.where("date >= ?", Time.zone.now.beginning_of_month).where.not(ignore: true).all.to_a
      end
    end

    response_data = ResponseData.new

    transactions.each do |txn|
      txn.amount = txn.amount * - 1
      response_data.get_month_data(txn.month, txn.year).add_transaction(txn)
    end

    response_data.months.first
  end
end