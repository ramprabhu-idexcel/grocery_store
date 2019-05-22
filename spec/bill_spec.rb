require 'spec_helper'

describe Bill do
  include_context 'grocery_store shared let statements'
  let!(:bill_summary) { BillSummary.new('Item B', customer_lists[1], 10).generate }
  let!(:clean_bill_summary_stocks) { BillSummary.stocks = [] }
  let!(:bill) { Bill.new(customer_lists[1], bill_summary).generate }
  context 'collect bill details' do
    it 'should check bill no' do
      expect(bill.bill_no).not_to be_nil
    end

    it 'should check bill date' do
      expect(bill.bill_date).not_to be_nil
    end

    it 'should check voucher no' do
      expect(bill.voucher_no).not_to be_nil
    end

    it 'should check bill summary' do
      expect(bill.bill_summary).to eq(bill_summary)
    end

    it 'should check total_bill_price' do
      expect(bill.total_bill_price).not_to be_nil
    end
  end
end
