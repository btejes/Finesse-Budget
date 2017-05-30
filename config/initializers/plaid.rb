Plaid.config do |config|
  config.customer_id = ENV['PLAID_CUSTOMER_ID']
  config.secret = ENV['PLAID_CUSTOMER_SECRET']
  config.production = ENV['PLAID_PRODUCTION_MODE'] == 'true'
end
