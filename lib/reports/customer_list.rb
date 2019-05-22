module Reports
  # Collect customer details
  module CustomerList
    def customer_lists
      @customer_lists ||= []
    end

    def import_customers
      CsvParser.new(customers_csv).render.each { |row| customer_lists << Customer.new(row) }
    end

    def view_customers
      puts ''
      puts "____________________Total Customer Lists (#{customer_lists.count})_________________________"
      tp customer_lists, :name, :dob, :mobile_no, :store_employee
    end
  end
end
