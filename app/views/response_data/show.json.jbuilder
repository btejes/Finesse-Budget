json.array!(@response_data.months) do |month|
  json.(month, :spent, :received, :available, :month, :year, :days_left, :days_completed, :status, :expected_received, :expected_available)
  json.transactions month.transactions do |transaction|
    json.(transaction, :id, :description, :date_str, :amount, :month, :year, :pending, :transfer_transaction_id)
  end
end

