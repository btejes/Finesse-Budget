class PlaidAccount < ActiveRecord::Base

  has_many :bank_accounts, dependent: :destroy
  belongs_to :user

  def pull_transactions
    result = Plaid.call.get_request("connect", access_token, { pending: true })

    accounts_hash = generate_bank_account_cache(result[:accounts])

    response_ref_ids = []

    sorted_transactions = result[:transactions].sort_by { |txn| txn[:pending] }.reverse

    sorted_transactions.each do |txn|
      response_ref_ids << txn["_id"]
      if txn["pending"]
        create_or_update_transaction_if_not_repeated(accounts_hash, txn)
      else
        create_or_update_transaction(accounts_hash, txn)
      end
    end

    cleanup_after_sync(accounts_hash, response_ref_ids)
  end

  def destroy
    super
    Plaid.customer.delete_account(access_token)
  end

  private

  def generate_bank_account_cache(accounts_json)
    bank_account_hash = {}

    accounts_json.each do |account|
      bank_account_hash[account["_id"]] = get_or_create_bank_account(account)
    end

    bank_account_hash
  end

  def cleanup_after_sync(accounts_hash, response_ref_ids)
    # removing transactions that don't exist anymore
    Transaction.where(bank_account_id: accounts_hash.values.map(&:id)).
                where.not(ref_id: response_ref_ids).delete_all

    user.tag_transfers
  end

  def create_or_update_transaction_if_not_repeated(accounts_hash, trans)
    # if a settled transaction for the same account, date, description and amount exists, ignore it
    unless Transaction.where(bank_account: accounts_hash[trans["_account"]], pending: false,
        date: trans["date"], amount: trans["amount"], description: trans["name"].capitalize).exists?
      create_or_update_transaction(accounts_hash, trans)
    end
  end

  def create_or_update_transaction(accounts_hash, trans)
    txn = Transaction.find_by(ref_id: trans["_id"])

    txn ||= Transaction.find_by(ref_id: trans["_pendingTransaction"])

    if txn
      txn.description = trans["name"].capitalize
      txn.pending = trans["pending"]

      txn.amount = trans["amount"]
      txn.save
    else
      # if this is replacing a pending_transaction, we want to update the old one for ordering
      if trans["_pendingTransaction"]
        txn = Transaction.find_by(ref_id: trans["_pendingTransaction"])
      end

      txn ||= Transaction.new
      txn.description = trans["name"].capitalize

      txn.amount = trans["amount"]
      txn.date = trans["date"]
      txn.pending = trans["pending"]
      txn.ref_id = trans["_id"]
      txn.month = txn.date.month
      txn.year = txn.date.year
      txn.bank_account = accounts_hash[trans["_account"]]
      txn.ignore = !txn.bank_account.considered
      txn.save
    end
  end

  def get_or_create_bank_account(account)
    bank_account = BankAccount.find_by(ref_id: account["_id"])

    if bank_account
      bank_account.available = account["balance"]["available"]
      if bank_account.account_type == "credit"
        bank_account.balance = -1 * account["balance"]["current"]
      else
        bank_account.balance = account["balance"]["current"]
      end
      bank_account.save!
    else
      bank_account = BankAccount.new
      bank_account.plaid_account = self
      bank_account.account_number = account["meta"]["number"]
      bank_account.name = account["meta"]["name"]
      bank_account.ref_id = account["_id"]
      bank_account.considered = true
      bank_account.account_type = account["type"]
      bank_account.account_subtype = account.try(:[], "subtype")
      bank_account.available = account["balance"]["available"]
      if bank_account.account_type == "credit"
        bank_account.balance = -1 * account["balance"]["current"]
      else
        bank_account.balance = account["balance"]["current"]
      end
      bank_account.save!
    end

    bank_account
  end
end
