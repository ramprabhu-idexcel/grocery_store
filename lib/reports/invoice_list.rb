module Reports
  # Invoice list details
  module InvoiceList
    def customer_products
      @customer_products ||= []
    end

    def import_customer_products
      CsvParser.new(customers_products_csv).render.each { |row| customer_products << row }
    end

    def generate_invoices
      customer_lists.each do |customer|
        item_lists = customer_products.select { |product| product[:customer] == customer.name }
        item_lists.each do |item|
          BillSummary.new(item[:name], customer, item[:qty]).generate
        end
      end
      Bill.invoices = invoices
    end

    def view_invoices
      puts ''
      invoices.each_with_index do |invoice, index|
        puts "_________________________________Tax Invoice (#{index + 1})__________________________________"
        puts "CustomerName: #{invoice.customer_name}         MobileNo: #{invoice.customer_mobile}", ''
        puts "Bill No: #{invoice.bill_no}   Bill Date: #{invoice.bill_date}", ''
        tp invoice.bill_summary, :item_name, :qty, :mrp, :discount_per, :discount_per, :net_amount
        puts ''
        puts "Total Bill Price: #{invoice.total_bill_price}"
        puts '___________________________________________________________________________________', ''
      end
    end

    def invoices
      @invoices ||= customer_lists.each_with_object([]) do |customer, invoice_list|
        invoice_list << Bill.new(customer, bill_summary(customer)).generate
      end
    end

    def bill_summary(customer)
      BillSummary.all.select { |summary| summary[:customer_name] == customer.name && summary[:customer_mobile_no] == customer.mobile_no }
    end
  end
end
