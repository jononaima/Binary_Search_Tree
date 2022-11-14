class Node
    attr_accessor :data, :leftNode, :rightNode
    def initialize(data)
        self.data = data
        self.leftNode = nil
        self.rightNode = nil
    end
end

class Tree < Node
    attr_accessor :root, :data
    def initialize(arr)
        @data = arr.sort.uniq
        @root = build_tree(data)
    end

    # take an array, remove duplicates and turn it into
    # balance binary tree
    def build_tree(arr)
        return nil if arr.empty?
        mid = arr.length/2
        value = arr[mid]
        left = arr.take(mid)
        right = arr.drop(mid+1)
        root_nd = Node.new(arr[mid])

        root_nd.leftNode = build_tree(left)
        root_nd.rightNode = build_tree(right)

        root_nd
    end
    # inserts value/node to the binary tree
    def insert(val)
        node = root
        return nil if node.data == val
        until node.data.nil?
            if val > node.data
                if node.rightNode.nil?
                    node.rightNode = Node.new(val)
                    return nil
                end
                node = node.rightNode
            else
                if node.leftNode.nil?
                    node.leftNode = Node.new(val)
                    return nil
                end
                node = node.leftNode
            end
        end
    end

    # delete value/node
    def delete(val)
        node = root
        prev_node = nil
        return nil if node.data.nil?
        # Deleting mid section
        until node.nil?
            if node.data == val && node.leftNode.nil? && node.rightNode.nil?
                node.data = nil
                return nil
            elsif node.data == val && !node.leftNode.nil? && !node.rightNode.nil?
                delete_node = node
                sub_node = nil
                node = node.rightNode
                until node.nil?
                    sub_node = node
                    node = node.leftNode
                end
                delete_node.data = sub_node.data
                sub_node.data = nil
                return nil
            elsif node.data == val
                delete_node = node
                prev_node = node
                # puts val
                # puts node.data
                # node.data = node.rightNode.data
                # node.rightNode = nil
                until node.nil?
                    prev_node = node
                    if !node.rightNode.nil?
                        node = node.rightNode
                    else
                        node = node.leftNode
                    end
                end
                delete_node.data = prev_node.data
                prev_node.data = nil
                return nil
            end
            prev_node = node
            # move to the next node if nod does not match
            if node.data < val
                node = node.rightNode
            else
                node = node.leftNode
            end 
        end
    end

    # returns the node with the given value
    def find(val)
        node = root
        until node.data == val
            if val > node.data
                node = node.rightNode
            else
                node = node.leftNode
            end
            if node.nil?
                return "No such data"
            end
        end
        return node.data
    end

    # Level order traversal where the BST data is travesresed in breadth-frist
    # level order

    def level_order
        i = 0
        queue = [root]
        arr = []
        while queue[i]
          arr.push(queue[i].data)
          queue.push(queue[i].leftNode) if queue[i].leftNode
          queue.push(queue[i].rightNode) if queue[i].rightNode
          i += 1
        end
        arr
    end

    # the following three methods traverse the tree in depth-first order
    def pre_order(node=@root, arr = [])
        if !node.nil?
            arr << node.data

            pre_order(node.leftNode, arr)
            pre_order(node.rightNode, arr)
        end
        arr
    end

    def in_order(node=@root, arr = [])
        if !node.nil?
            in_order(node.leftNode, arr)
            arr << node.data
            in_order(node.rightNode, arr)
        end
        arr
    end

    def post_order(node=@root, arr = [])
        if !node.nil?
            post_order(node.leftNode, arr)
            post_order(node.rightNode, arr)
            arr << node.data
        end
        arr
    end
    # Height of tree
    def height(node = root, counter = -1)
        return counter if node.nil?
    
        counter += 1
        leftHeight = height(node.leftNode, counter)
        rightHeight = height(node.rightNode, counter)
        if leftHeight > rightHeight
            return leftHeight
        else
            return rightHeight
        end
    end

    # Returns binary tree depths
    def depth(node, cur_node = root, depth_counter = -1)
        return "No such node" if cur_node.nil?
    
        depth_counter += 1

        comparison = cur_node.data <=> node
    
        case comparison
        when -1
          depth(node, cur_node.rightNode, depth_counter)
        when 0
          depth_counter
        when 1
          depth(node, cur_node.leftNode, depth_counter)
        end
    end
    # checks whether Binary Tree is balanced or not
    def balanced?
        (height(root.leftNode) - height(root.rightNode)).abs <= 1
    end
    # rebalances the tree
    def rebalance
        self.root = build_tree(in_order)
    end


    # to visualize binary search tree, method by a student on Discord (The Odin Project)

    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.rightNode, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.rightNode
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.leftNode, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.leftNode
    end
end




# arr = [1, 7, 4, 23, 8, 9, 11, 4, 3, 5, 7, 9, 67, 6345, 324, 1976]
# bst = Tree.new(arr)
# # bst.pretty_print
# puts bst.insert(12)
# bst.insert(13)
# bst.pretty_print

# # #delete
# # bst.delete(11)
# # bst.pretty_print

# #find method
# puts bst.find(1976)

# puts "level_order"
# puts bst.level_order.join(" | ")

# puts "pre_order"
# puts bst.pre_order.join(" |")

# puts "in_order"
# puts bst.in_order.join(" |")

# puts "post_order"
# puts bst.post_order.join(" |")

# puts "height"
# puts bst.height


 # driver script assignment
arr = [1, 2, 3, 4, 5, 1976, 200, 1899, 2000]
arr = Array.new(15) { rand(1..100) }
bst = Tree.new(arr)

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.level_order.join(' ')

puts 'Preorder traversal: '
puts bst.pre_order.join(' ')

puts 'Inorder traversal: '
puts bst.in_order.join(' ')

puts 'Postorder traversal: '
puts bst.post_order.join(' ')

10.times do
    a = rand(100..150)
    bst.insert(a)
    puts "Inserted #{a} to tree."
end

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Rebalancig tree...'
bst.rebalance

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.level_order.join(' ')

puts 'Preorder traversal: '
puts bst.pre_order.join(' ')

puts 'Inorder traversal: '
puts bst.in_order.join(' ')

puts 'Postorder traversal: '
puts bst.post_order.join(' ')

puts "Height"
puts bst.height
puts bst.in_order.join(' ')

puts bst.depth(1976)