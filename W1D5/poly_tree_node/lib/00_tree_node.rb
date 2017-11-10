class PolyTreeNode
  attr_reader :value, :parent, :children
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent= (node)
    remove_self_from_parents_children
    
    @parent = node
    if !node.nil?
      node.children << self unless node.children.include?(self)
    end
  end
  
  def remove_self_from_parents_children
    self.parent.children.delete(self) unless self.parent.nil?
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    if child_node.parent.nil?
      raise "This node does not have a parent"
    else
      child_node.parent = nil
    end
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    
    node = nil
    
    self.children.each do |child|
      node = child.dfs(target_value)
      break unless node.nil?
    end 
    
    node
  end   
  
  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each do |child|
        queue << child
      end 
    end
    
    nil 
  end 
end