require 'spec_helper'

describe ExceptionNotifier do
  let!(:customer) { Customer.new(name: 'Customer A', dob: '14/01/1989', mobile_no: '9600890754') }
  let!(:exception_notifier) { described_class.new(customer, 'duplicate customer!!!') }
  context 'raise an exception' do
    it 'check exception message and object' do
      expect(exception_notifier.message).to eq('duplicate customer!!!')
    end
  end
end
