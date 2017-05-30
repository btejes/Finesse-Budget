class MonthData

  attr_accessor :transactions, :spent, :received, :available, :month, :year, :days_left,
      :days_completed, :status, :expected_received, :expected_available

  def initialize(month, year)
    @transactions = []
    @month = month
    @year = year
    @available = 0
    @received = 0
    @spent = 0
    @expected_received = 0
    @expected_available = 0

    fill_days
  end

  def add_transaction(transaction)
    @transactions << transaction

    unless transaction.transfer_transaction_id
      if transaction.amount < 0
        @spent -= transaction.amount
      elsif transaction.bank_account.depository?
        @received += transaction.amount
      end

      @available = @received - @spent
      @expected_available = @expected_received - @spent
    end
  end

  private

  def fill_days
    if Date.today.month != @month || Date.today.year != @year
      @days_completed = (Date.new(@year, @month, 1).next_month - 1.day).day
      @days_left = 0
    else
      @days_completed = (Date.today - Date.today.at_beginning_of_month).to_i
      @days_left = (Date.today.at_beginning_of_month.next_month - Date.today).to_i
    end
  end
end
