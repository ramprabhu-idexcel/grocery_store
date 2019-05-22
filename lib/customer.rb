require 'date'

# Customer details collection
class Customer
  attr_reader :name, :dob, :mobile_no, :store_employee
  def initialize(**detail)
    @name = detail[:name]
    @mobile_no = detail[:mobile_no]
    @dob = DateTime.parse(detail[:dob], '%d/%m/%Y').to_date
    @store_employee = detail[:store_employee] == 'Yes'
  end

  def eligible_for_discount?
    senior_citizen? || store_employee
  end

  private

  def senior_citizen?
    age >= 60
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - (now.month > dob.month || (now.month == dob.month && now.day >= dob.day) ? 0 : 1)
  end
end
