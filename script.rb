# frozen_string_literal: true
require 'pry-byebug'
# Node class
class Node
  def initialize(value = nil, left_child = nil, right_child = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end
  attr_accessor :value, :left_child, :right_child
end

# Tree class
# build_tree method algorithm:
# 1: Initialize start = 0, end = length of the array – 1
# 2: mid = (start+end)/2
# 3: Create a tree node with mid as root (lets call it A).
# 4: Recursively do following steps:
# 5: Calculate mid of left subarray and make it root of left subtree of A.
# 6: Calculate mid of right subarray and make it root of right subtree of A
class Tree
  def initialize(array = [])
    @array = array
    @root = nil
  end

  def root(root)
    @root = root
  end

  def build_tree(array=[], start_arr=0, end_arr=0, count=0)
    return nil if start_arr > end_arr 
    array = @array.uniq.sort if count == 0
    count += 1
    start_arr = 0
    end_arr = array.length - 1
    mid_arr = (start_arr + end_arr) / 2
    root = Node.new(array[mid_arr])
    root.left_child = build_tree(array[start_arr.. mid_arr-1], start_arr, mid_arr-1, count)
    root.right_child = build_tree(array[mid_arr+1.. end_arr], mid_arr+1, end_arr, count)
    root(root)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
# insert method 
# i want to take the root and do a depth first search compare current_root and value
# if current_root > value then value compare to the left child
  def insert(value, root=nil, count=0, inserted=false)
    root = @root if count == 0 
    count += 1
    return nil if inserted
    inserted = false
    if root.value > value
      root = root.left_child
      if root.left_child == nil
        root.left_child = Node.new(value)
        inserted = true
      end
    else
      root = root.right_child
      if root.right_child == nil
        root.right_child = Node.new(value)
        inserted = true
      end
    end
    insert(value, root, count, inserted)
  end
end

my_tree = Tree.new([1,2,3,4,5,6,7,8,9,10])

my_tree.build_tree



my_tree.insert(11)

my_tree.pretty_print

