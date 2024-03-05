require './lib/merge_sort'

class Node
  attr_accessor :left, :right
  attr_reader :data
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  include MergeSort

  def initialize
    @root
  end

  def sorted?(arr)
    uniq = arr.uniq
    return uniq if uniq == uniq.sort

    self.mergesort(uniq)
  end

  def build_tree(arr)
    return nil if arr.empty?
    arr = sorted?(arr)

    mid = (arr.length/2).round

    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid+1..-1])

    @root = root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def print_trees(node = @root, trees = [])
    return nil if node.nil?

    trees << node.data
    print_trees(node.left, trees)
    print_trees(node.right, trees)
    trees
  end
end

trees = Tree.new

trees.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

trees.pretty_print

p trees.print_trees