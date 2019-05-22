module Reports
  # Inventory list details
  module InventoryList
    ROUND_PRECISION = 2
    def import_stocks
      CsvParser.new(products_csv).render.each { |row| Product.new(row) }
    end

    def view_stocks
      puts "____________________Total Inventory Lists (#{Product.all.count})__________________"
      tp Product.all, :name, :description, :qty, :discount, :unit_price
    end

    def view_sold_items
      puts "____________________Sold Items Lists (#{sold_items.count})__________________"
      tp sold_items, :item_name, :qty, :sales_price
    end

    def sold_items
      @sold_items ||= Reports::SoldItemList.new(BillSummary.all).generate
    end

    def total_sales_during_day
      puts ''
      puts "____________________Total sales during the day (#{DateTime.now.strftime('%d/%m/%Y')})__________________"
      tp Bill.invoices, :bill_no, :total_bill_price
      puts ''
      puts "    Total Sales Today = #{total_sales_for_the_day}"
      puts '____________________________________________________________________________', ''
    end

    def view_remaining_stocks
      puts ''
      puts '____________________Remaining Inventory Lists__________________'
      tp Reports::RemainingItemList.new(Product.all, sold_items).view, :name, :qty, :discount, :unit_price
    end

    def total_sales_for_the_day
      Bill.invoices.map(&:total_bill_price).compact.sum.round(ROUND_PRECISION)
    end
  end
end
