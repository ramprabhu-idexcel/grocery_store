require 'spec_helper'

describe Product do
  include_context 'grocery_store shared let statements'
  context 'collect product details' do
    it 'return products count' do
      expect(Product.all.count).to eql(26)
    end

    it 'raise an error for duplicate item' do
      Product.new(name: 'Item A', unit_price: 112.04, qty: 1000, discount: 0.45)
      expect(ExceptionNotifier.all.count).to be > 1
    end
  end
end
