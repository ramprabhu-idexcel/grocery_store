require 'spec_helper'

describe CsvParser do
  let!(:customers_csv) { File.read('sample-inputs/customers.csv') }
  let!(:csv_parser) { CsvParser.new(customers_csv).render }
  context 'collect csv parser details' do
    it 'should parse csv content' do
      expect(csv_parser.count).to eq(4)
    end

    it 'should list customer names' do
      expect(csv_parser.map { |customer| customer[:name] }).to eq(['Customer A', 'Customer B', 'Customer C', 'Customer D'])
    end
  end
end
