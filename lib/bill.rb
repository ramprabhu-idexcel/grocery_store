require 'date'

# Invoice generation
class Bill
  attr_reader :customer, :bill_summary
  ROUND_PRECISION = 2
  @invoices = []

  BillInfo = Struct.new(:bill_no,
                        :bill_date,
                        :voucher_no,
                        :customer_name,
                        :customer_mobile,
                        :bill_summary,
                        :total_bill_price)

  def initialize(customer, bill_summary = [])
    @customer = customer
    @bill_summary = bill_summary
  end

  def generate
    BillInfo.new(bill_no,
                 bill_date,
                 voucher_no,
                 customer_name,
                 customer_mobile,
                 bill_summary,
                 total_bill_price)
  end

  class << self
    attr_accessor :invoices

    def all
      @invoices
    end
  end

  private

  def bill_no
    rand.to_s[2..11] + '-' + rand.to_s[2..11]
  end

  def bill_date
    DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  end

  def voucher_no
    rand.to_s[2..5] + '-' + rand.to_s[5..8]
  end

  def customer_name
    customer.name
  end

  def customer_mobile
    customer.mobile_no
  end

  def total_bill_price
    bill_summary.map(&:net_amount).compact.sum.round(ROUND_PRECISION)
  end
end
