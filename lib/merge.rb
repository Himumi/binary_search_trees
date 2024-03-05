module MergeSort
  def mergesort(numbers)
    return numbers if numbers.length <= 1
    half_of_numbers = (numbers.length/2).round
    left = numbers.take(half_of_numbers)
    right = numbers.drop(half_of_numbers)
  
    sorted_left = mergesort(left)
    sorted_right = mergesort(right)
  
    merge(sorted_left, sorted_right)
  end
  
  def merge(left, right)
    result = []
    until left.length == 0 || right.length == 0
      result << (left.first <= right.first ? left.shift : right.shift)
    end
    result + left + right
  end
end


# p sort([1,6,3,8,22,3,11,24,54,68,79,80,98,65,46,76,53])