class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory.keys.include?(item)
      @inventory[item]
    else
      0
    end
  end

  def stock(item, quantity)
    holder_hash = {item => quantity}
    @inventory.merge!(holder_hash) do |key, old_val, new_val|
      old_val + new_val
    end
  end
end
