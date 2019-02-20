class Market
  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end

  def sorted_item_list
    list = @vendors.map do |vendor|
      vendor.inventory.keys
    end
    list.flatten.sort.uniq
  end

  def total_inventory
    holder_hash = {}
     @vendors.each do |vendor|
       holder_hash.merge!(vendor.inventory) do |keys, old_vals, new_vals|
         old_vals + new_vals
       end
     end
     holder_hash
  end

  def sell(item, quantity)
    #I know you can't do some of the operations
    # in this method but this is the logic flow
    # I would use and sort out given the time
    @vendors.each do |vendor|
      until quantity == 0
        if sorted_item_list.include?(item) == false
          return false
        elsif quantity > total_inventory[item]
          return false
        elsif vendor.inventory[item] >= quantity
          vendor.inventory[item] - quantity
          return true
        else vendor.inventory[item] < quantity
          already_subtracted = 0
          until vendor.inventory[item] == 0
            vendor.inventory[item] -= 1
            already_subtracted += 1
          end
          quantity = quantity - already_subtracted
        end
      end
    end
  end
end
