class Transaction < ActiveRecord::Base

  belongs_to :bank_account

  def date_str
   self.date.strftime("%a #{self.date.day.ordinalize}")
  end
end
