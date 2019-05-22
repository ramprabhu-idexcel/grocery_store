# Collect product details
class Product
  attr_reader :name, :description, :unit_price, :qty, :discount
  @items = []

  def initialize(**detail)
    @name = detail[:name]
    @description = detail[:description]
    @unit_price = detail[:unit_price].to_f || 0
    @discount = detail[:discount].to_f || 'None'
    @qty = detail[:qty].to_i
    insert_valid_item
  end

  class << self
    attr_accessor :items

    def all
      @items
    end
  end

  private

  def insert_valid_item
    raise ExceptionNotifier.new(self, 'Item already exist !!') if duplicate_item?
    self.class.items << self
  rescue StandardError => e
    puts e.message
  end

  def duplicate_item?
    Product.all.find { |item| item.name == name }
  end
end
