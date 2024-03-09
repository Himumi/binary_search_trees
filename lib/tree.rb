require './lib/merge_sort'
require './lib/node'

class Tree
  include MergeSort
  attr_accessor :root

  def initialize; end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def print_trees(node = @root, trees = [])
    return if node.nil?

    trees << node.data
    print_trees(node.left, trees)
    print_trees(node.right, trees)
    trees
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

    value < root.data ? root.left = insert(value, root.left) : root.right = insert(value, root.right)
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

    root.right if root.left.nil?
    root.left if root.right.nil?

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

  def find(value, root = @root)
    return nil if root.nil?
    return root if root.data == value

    value < root.data ? find(value, root.left) : find(value, root.right)
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
    block.call(node.data) if block_given?
    inorder(node.right, &block)
  end

  def preorder(node = @root, &block)
    return if node.nil?

    block.call(node.data) if block_given?
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    block.call(node.data) if block_given?
  end

  def balanced?(node = @root)
    lnodes = total_nodes(node.left)
    rnodes = total_nodes(node.right)

    lnodes < rnodes ? (rnodes - lnodes) <= 1 : (lnodes - rnodes) <= 1
  end

  def rebalance
    data = []
    inorder { |item| data << item }

    build_tree(data)
  end

  def height(value, node = find(value))
    return 0 if node.nil?

    lnode = height(value, node.left)
    rnode = height(value, node.right)

    lnode > rnode ? (lnode + 1) : (rnode + 1)
  end

  def depth(value, node = @root)
    return 0 if node.data == value

    value < node.data ? depth(value, node.left) + 1 : depth(value, node.right) + 1
  end

  protected
  def sorted?(arr)
    uniq = arr.uniq
    return uniq if uniq == uniq.sort

    mergesort(arr)
  end
  
  def total_nodes(node)
    return 0 if node.nil?

    (total_nodes(node.left) + total_nodes(node.right)) + 1
  end
end