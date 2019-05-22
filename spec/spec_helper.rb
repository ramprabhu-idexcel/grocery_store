Dir['./lib/*.rb'].sort.each { |f| require f }
Dir['./lib/reports/*.rb'].sort.each { |file| require file }
require 'rspec/core'
require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

RSpec.shared_context 'grocery_store shared let statements' do |_path|
  let!(:clean_items) { Product.items = [] }
  let!(:products_csv) { File.read('sample-inputs/products.csv') }
  let!(:products) { CsvParser.new(products_csv).render.each { |row| Product.new(row) } }
  let!(:customers_csv) { File.read('sample-inputs/customers.csv') }
  let!(:customer_lists) { [] }
  let!(:customers) do
    CsvParser.new(customers_csv).render.each { |row| customer_lists << Customer.new(row) }
  end
  let!(:customers_products_csv) { File.read('sample-inputs/customer_products.csv') }
  let!(:customer_products_lists) { [] }
  let!(:import_customers_products) do
    CsvParser.new(customers_products_csv).render.each { |row| customer_products_lists << row }
  end
end
