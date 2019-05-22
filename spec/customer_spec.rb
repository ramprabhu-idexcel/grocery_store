require 'spec_helper'

describe Customer do
  let!(:customer) { Customer.new(name: 'Customer A', dob: '14/01/1989', mobile_no: '9600890754') }
  context 'collect customer details' do
    it 'check customer age' do
      expect(customer.send(:age)).to eql(30)
    end

    it 'check customer is eligible for discount or not' do
      expect(customer.eligible_for_discount?).to eq(false)
    end

    it 'check customer is senior citizen or not' do
      expect(customer.send(:senior_citizen?)).to eq(false)
    end

    it 'check customer is store employee or not' do
      expect(customer.store_employee).to eq(false)
    end
  end
end
