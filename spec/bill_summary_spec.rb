require 'spec_helper'

describe BillSummary do
  include_context 'grocery_store shared let statements'
  let!(:bill_summary) { BillSummary.new('Item A', customer_lists[0], 10).generate.first }
  let!(:clean_bill_summary_stocks) { BillSummary.stocks = [] }
  context 'collect bill summary details' do
    it 'should check item name' do
      expect(bill_summary.item_name).to eq('Item A')
    end

    it 'should check mrp' do
      expect(bill_summary.mrp).to eq(1120.4)
    end

    it 'should check qty' do
      expect(bill_summary.qty).to eq(10)
    end

    it 'should check customer mobile no' do
      expect(bill_summary.customer_mobile_no).to eq(customer_lists[0].mobile_no)
    end

    it 'should check customer name' do
      expect(bill_summary.customer_name).to eq(customer_lists[0].name)
    end
  end
end
