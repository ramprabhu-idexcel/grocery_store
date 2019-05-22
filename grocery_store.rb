Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/lib/reports/*.rb'].each { |file| require file }

require 'table_print'
require 'singleton'

# Grocery store module
class GroceryStore
  include Singleton
  include Reports::InventoryList
  include Reports::CustomerList
  include Reports::InvoiceList

  attr_reader :products_csv, :customers_csv, :customers_products_csv

  def initialize
    @products_csv = File.read('sample-inputs/products.csv')
    @customers_csv = File.read('sample-inputs/customers.csv')
    @customers_products_csv = File.read('sample-inputs/customer_products.csv')
  end

  def perform_actions
    import_stocks
    view_stocks
    import_customers
    view_customers
    import_customer_products
    generate_invoices
    view_invoices
    view_sold_items
    total_sales_during_day
    view_remaining_stocks
  end
end

GroceryStore.instance.perform_actions
