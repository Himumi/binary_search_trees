require './lib/tree'

trees = Tree.new
arr = (300..500).to_a.sample(50)
trees.build_tree(arr)

trees.pretty_print
puts "Is tree balanced? : #{trees.balanced?}"
arr2 = (1..800).to_a.sample(50)
arr2.each { |item| trees.insert(item) }
trees.pretty_print
puts "Is tree balanced? : #{trees.balanced?}"
trees.rebalance
trees.pretty_print
puts "Is this trees balanced? : #{trees.balanced?}"