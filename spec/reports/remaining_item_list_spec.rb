require 'spec_helper'

describe Reports::RemainingItemList do
  include_context 'grocery_store shared let statements'
  let!(:bill_summary) { BillSummary.new('Item A', customer_lists[0], 10).generate }
  let!(:clean_bill_summary_stocks) { BillSummary.stocks = [] }
  let!(:sold_item_list) { Reports::SoldItemList.new(bill_summary).generate }
  let!(:remaining_inventory_list) { described_class.new(Product.all, sold_item_list).view }
  context 'collect remaining item details in inventory' do
    it 'should check remaining item list count' do
      expect(remaining_inventory_list.count).to eq(26)
    end

    it 'should check qty of remaining item A' do
      expect(remaining_inventory_list.find { |item| item.name == 'Item A' }.qty).to eq(990.0)
    end
  end
end
