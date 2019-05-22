module Reports
  # Sold Item details
  class SoldItemList
    attr_reader :bill_summary, :sold_items, :summary_info
    ROUND_PRECISION = 2

    SoldItemListInfo = Struct.new(:item_name, :qty, :sales_price)

    def initialize(bill_summary)
      @bill_summary = bill_summary.group_by(&:item_name)
      @sold_items = []
    end

    def generate
      bill_summary.each_pair do |item_name, summary_info|
        @summary_info = summary_info
        sold_items << SoldItemListInfo.new(item_name, total_item_qty, total_item_price)
      end
      sold_items
    end

    private

    def total_item_qty
      summary_info.map(&:qty).compact.sum
    end

    def total_item_price
      summary_info.map(&:net_amount).compact.sum.round(ROUND_PRECISION)
    end
  end
end
