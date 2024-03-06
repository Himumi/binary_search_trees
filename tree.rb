require './lib/merge_sort'

class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def to_s
    "#{@data}"
  end
end

class Tree
  include MergeSort
  attr_accessor :root

  def initialize; end

  def sorted?(arr)
    uniq = arr.uniq
    return uniq if uniq == uniq.sort

    @sorted_numbers = mergesort(uniq)
  end

  def build_tree(arr)
    return nil if arr.empty?

    arr = sorted?(arr)

    mid = (arr.length / 2).round

    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..-1])

    @root = root
  end

  def insert(value, root = @root)
    return root = Node.new(value) if root.nil?

    if value < root.data
      root.left = insert(value, root.left)
    elsif value > root.data
      root.right = insert(value, root.right)
    end

    root
  end

  def delete(value, root = @root)
    return root if root.nil?

    if root.data < value
      root.right = delete(value, root.right)
      return root
    elsif root.data > value
      root.left = delete(value, root.left)
      return root
    end

    if root.left.nil?
      root.right

    elsif root.right.nil?
      root.left

    else
      parent_root = root
      next_root = root.right
      until next_root.left.nil?
        parent_root = next_root
        next_root = next_root.left
      end

      root.data = next_root.data

      if parent_root != root
        parent_root.left = next_root.right
      else
        parent_root.right = next_root.right
      end

      root
    end
  end

  def find(value, root = @root)
    return root if root.data == value

    if value < root.data
      find(value, root.left)
    elsif value > root.data
      find(value, root.right)
    end
  end

  def level_order(result = [], queue = [@root])
    return if @root.nil?

    until queue.empty?
      curr = queue.shift
      yield curr if block_given?
      result << curr.data

      queue << curr.left if curr.left
      queue << curr.right if curr.right
    end
    result
  end

  def inorder(node = @root, &block)
    return if node.nil?

    inorder(node.left, &block)
    block.call(node) if block_given?
    inorder(node.right, &block)
  end

  def preorder(node = @root, &block)
    return if node.nil?

    block.call(node) if block_given?
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    block.call(node) if block_given?
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

trees.pretty_print

trees.pretty_print
p trees.root.data
puts trees.height(6345)

# p trees.postorder_arr
