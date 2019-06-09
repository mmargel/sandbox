# frozen_string_literal: true
require_relative "../../data_structures/hash_table"
require "test/unit"

class TestHashTable < Test::Unit::TestCase
  def setup
    @hash = HashTable.new
  end

  # insert
  def test_insert_nil_key
    assert_raise(ArgumentError) { @hash[nil] = 4 }
  end

  def test_insert_nil_value
    assert_equal(nil, @hash[4] = nil)
  end

  def test_insert_valid
    assert_equal(4, @hash[:a] = 4)
    assert_equal(2020, @hash[:a] = 2020)
    assert_equal("car", @hash[:b] = "car")
  end

  # delete
  def test_delete_empty
    assert_raise(ArgumentError) { @hash.delete(nil) }
  end

  def test_delete_missing
    assert_equal(2020, @hash[:a] = 2020)
    assert_equal("car", @hash[:b] = "car")
    assert_raise(ArgumentError) { @hash.delete('boat') }
  end

  def test_delete_present
    @hash[:a] = 2020
    @hash[:b] = "car"
    assert_equal("car", @hash.delete(:b))
  end

  # get
  def test_get_empty
    assert_nil(@hash[:a])
  end

  def test_get_missing
    @hash[:a] = 2020
    @hash[:b] = "car"
    assert_nil(@hash[:c])
  end

  def test_get_present
    @hash[:a] = 2020
    @hash[:b] = "car"
    assert_equal('car', @hash[:b])
  end

  def test_get_overwritten
    @hash[:a] = 2020
    @hash[:a] = "car"
    assert_equal('car', @hash[:a])
  end
end
