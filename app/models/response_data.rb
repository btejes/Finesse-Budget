class ResponseData

  attr_accessor :months

  def initialize
    @months_hash = {}

    # makes sure the current month exists
    get_month_data(Time.zone.today.month, Time.zone.today.year)
  end

  def get_month_data(month, year)
    key = "#{month}#{year}"
    unless @months_hash[key]
      @months_hash[key] = MonthData.new(month, year)
    end

    @months_hash[key]
  end

  def months
    @months_hash.values.reverse
  end
end
