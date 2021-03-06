# frozen_string_literal: true

# Implements the standard mergesort algorithm
class QuickSort
  def self.sort(array)
    if array.length <= 1
      # Base case 1: there's 0 or 1 elements in the array
      # It's already sorted, so return
      array
    elsif array.length == 2
      # Base case 2: there are 2 elements in the array
      # Sort them and return
      if array[0] >= array[1]
        [array[1], array[0]]
      else
        [array[0], array[1]]
      end
    else
      # otherwise, split the array in two, sort each half (recursively)
      # and then merge them
      pivot_index = rand(0..array.length - 1)
      pivot_value = array[pivot_index]
      left = []
      right = []
      array.each do |item|
        if item <= pivot_value
          left << item
        elsif item > pivot_value
          right << item
        end
      end

      [*sort(left), *sort(right)]
    end
  end

  # Zips the two arrays
  def self.zip_arrays(left, right)
    l_index = 0
    r_index = 0
    array = []

    # Iterate over them together until we reach the end of one of them
    while l_index < left.length && r_index < right.length
      if left[l_index] <= right[r_index]
        array << left[l_index]
        l_index += 1
      else
        array << right[r_index]
        r_index += 1
      end
    end

    # Then append whatever's left of the other one
    array.push(*left[l_index, left.length]) if l_index < left.length
    array.push(*right[r_index, right.length]) if r_index < right.length

    array
  end
end
