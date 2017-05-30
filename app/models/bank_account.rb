class BankAccount < ActiveRecord::Base

  TYPE_CREDIT = "credit"
  TYPE_DEPOSITORY = "depository"
  TYPE_BROKERAGE = "brokerage"

  SUBTYPE_CHECKING = "checking"
  SUBTYPE_SAVINGS = "savings"


  has_many :transactions, dependent: :destroy
  belongs_to :plaid_account

  def checking?
    depository? && account_subtype == SUBTYPE_CHECKING
  end

  def depository?
    account_type == TYPE_DEPOSITORY
  end
end
