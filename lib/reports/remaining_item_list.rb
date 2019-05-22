module Reports
  # Remaining inventory lists
  class RemainingItemList
    attr_reader :total_items, :sold_items, :inventory_item

    RemainingItemListInfo = Struct.new(:name, :description, :qty, :discount, :unit_price)

    def initialize(total_items, sold_items)
      @total_items = total_items
      @sold_items = sold_items
    end

    def view
      total_items.each_with_object([]) do |inventory_item, remaining_items|
        @inventory_item = inventory_item
        remaining_items << load_items
      end
    end

    private

    def load_items
      RemainingItemListInfo.new(inventory_item.name,
                                inventory_item.description,
                                calculate_qty,
                                inventory_item.discount,
                                inventory_item.unit_price)
    end

    def find_by_sold_item
      sold_items.find { |item| item.item_name == inventory_item.name }
    end

    def calculate_qty
      inventory_item.qty - find_by_sold_item&.qty.to_f
    end
  end
end
