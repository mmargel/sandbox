# frozen_string_literal: true
require_relative "../../data_structures/set"
require "test/unit"

class TestSet < Test::Unit::TestCase
  def setup
    @set = Set.new
  end

  # insert
  def test_insert_nil
    assert_raise(ArgumentError) { @set.insert(nil) }
  end

  def test_insert_valid
    assert_equal(4, @set.insert(4))
    assert_equal(2020, @set.insert(2020))
    assert_equal("car", @set.insert("car"))
  end

  # delete
  def test_delete_empty
    assert_raise(ArgumentError) { @set.insert(nil) }
  end

  def test_delete_missing
    assert_equal(2020, @set.insert(2020))
    assert_equal("car", @set.insert("car"))
    assert_nil(@set.delete("boat"))
  end

  def test_delete_present
    @set.insert(2020)
    @set.insert("car")
    assert_equal("car", @set.delete("car"))
  end

  # search
  def test_search_empty
    assert_raise(ArgumentError) { @set.insert(nil) }
  end

  def test_get_missing
    @set.insert(2020)
    @set.insert("car")
    assert_nil(@set.get("boat"))
  end

  def test_search_present
    @set.insert(2020)
    @set.insert("car")
    assert_equal('car', @set.get("car"))
  end

  # to_array
  def test_to_array_empty
    assert_equal([], @set.to_array)
  end

  def test_to_array_one
    @set.insert(2020)
    assert_equal([2020], @set.to_array)
  end

  def test_to_array_many
    @set.insert(2020)
    @set.insert("car")
    @set.insert(4.0)
    array = @set.to_array
    assert(array.find(2020))
    assert(array.find('car'))
    assert(array.find(4.0))
    assert_nil(array.find { |x| x == 'boat' })
  end
end
