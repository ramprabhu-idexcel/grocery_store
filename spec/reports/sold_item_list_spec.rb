require 'spec_helper'

describe Reports::SoldItemList do
  include_context 'grocery_store shared let statements'
  let!(:bill_summary) { BillSummary.new('Item C', customer_lists[0], 10).generate }
  let!(:clean_bill_summary_stocks) { BillSummary.stocks = [] }
  let!(:sold_item_list) { described_class.new(bill_summary).generate.first }
  context 'collect sold item details' do
    it 'should check sold item name' do
      expect(sold_item_list.item_name).to eq('Item C')
    end

    it 'should check sold item quantity' do
      expect(sold_item_list.qty).to eq(10)
    end

    it 'should check total sales price' do
      expect(sold_item_list.sales_price).to eq(6752.6)
    end
  end
end
