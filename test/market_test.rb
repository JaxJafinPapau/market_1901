require 'minitest/autorun'
require 'minitest/pride'
require './lib/market'
require './lib/vendor'

class MarketTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3 = Vendor.new("Palisade Peach Shack")
    @vendor_3.stock("Peaches", 65)
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_a_name
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_starts_with_no_vendors
    assert_equal [], @market.vendors
  end

  def test_market_can_add_vendors
    @market.add_vendor(@vendor_1)
    assert_instance_of Vendor, @market.vendors[0]
  end

  def test_market_can_find_vendor_names
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, @market.vendor_names
  end

  def test_market_can_find_vendors_that_sell_item
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    assert_instance_of Vendor, @market.vendors_that_sell("Peaches")[0]
    assert_equal "Palisade Peach Shack", @market.vendors_that_sell("Peaches")[1].name
  end

  def test_market_can_give_sorted_item_list
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    assert_equal expected, @market.sorted_item_list
  end

  def test_market_can_give_total_inventory
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}
    assert_equal expected, @market.total_inventory
  end

  # def test_market_can_sell_items
  #   @market.add_vendor(@vendor_1)
  #   @market.add_vendor(@vendor_2)
  #   @market.add_vendor(@vendor_3)
  #   assert_equal false, @market.sell("Peaches", 200)
  #   assert_equal false, @market.sell("Onions", 5)
  #   assert_equal true, @market.sell("Banana Nice Cream", 5)
  #   assert_equal 45, @market.total_inventory["Banana Nice Cream"]
  #   assert_equal true, @market.sell("Peaches", 40)
  #   assert_equal 0, @market.vendors[0].check_stock("Peaches")
  #   assert_equal 60, @market.vendors[2].check_stock("Peaches")
  # end
end
