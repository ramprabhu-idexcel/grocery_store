# bill summary details collection
class BillSummary
  attr_reader :item_name, :qty, :customer
  @stocks = []
  ROUND_PRECISION = 2

  BillSummaryInfo = Struct.new(:item_name,
                               :qty,
                               :mrp,
                               :discount_per,
                               :discount_amt,
                               :net_amount,
                               :customer_name,
                               :customer_mobile_no)

  def initialize(item_name, customer, qty = 1)
    @item_name = item_name
    @qty = qty.to_i
    @customer = customer
  end

  def generate
    raise ExceptionNotifier.new('Item already exist !!', 'duplicate item') if duplicate_stock?
    self.class.stocks << generate_summary
  rescue StandardError => e
    puts e.message
  end

  class << self
    attr_accessor :stocks

    def all
      @stocks
    end
  end

  private

  def generate_summary
    BillSummaryInfo.new(item_name,
                        qty,
                        mrp,
                        discount_per,
                        discount_amt,
                        net_amount,
                        customer.name,
                        customer.mobile_no)
  end

  def item_info
    @item_info ||= Product.all.find { |item| item.name.downcase ==  item_name.downcase }
  end

  def duplicate_stock?
    BillSummary.all.find { |bill_summary| bill_summary.item_name == item_name && bill_summary.customer_name == customer.name }
  end

  def mrp
    @mrp ||= (item_info.unit_price * qty).round(ROUND_PRECISION)
  end

  def discount_per
    @discount_per ||= customer.eligible_for_discount? ? item_info.discount : 'None'
  end

  def discount_amt
    return apply_offer if discount_per != 'None'
    0.0
  end

  def net_amount
    (discount_amt == 0.0 ? mrp : discount_amt).round(ROUND_PRECISION)
  end

  def apply_offer
    mrp - (mrp * item_info.discount / 100)
  end
end
