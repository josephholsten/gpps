require 'src/custom_methods'

class TreeProgram
  # Creates an executable program with an array of programs as inputs. If
  # there are not enough input programs provided at initialization, more can
  # be generated with TreeProgram#populate_children. If there are more input
  # programs than may be valid for this program, excess input programs will
  # be ignored.
  def initialize(programs = [])
    @parent = nil
    self.kids = []
    programs.each do |program|
      break if self.kids.length == valid_kid_range.last
      program.parent = self
      self.kids.push program
    end
  end
  
  #--
  # Common ruby idioms for Proc compatibility, equivalence, conversion, etc
  #++
  
  # Defers to the subclass implementation of #call().
  def [](*params)
    call(*params)
  end
  
  # Taking an object, return true if its string representation is the same
  # as that of the current node.
  def ==(obj)
    self.to_s == obj.to_s
  end
  
  # Return a list with the current node, followed by each child node and its
  # children in prefix orientation. A node with no children will return a
  # list containing only the current node.
  def to_a
    ret = [self]
    if self.kids
      self.kids.each do |kid|
        kid.to_a.each {|node|
          ret.push node
        }
      end
    end
    ret
  end

  # Returns the number of nodes beneath the current node, including itself.
  def size
    self.to_a.size
  end
  
  # Return true if the current node has no parent node above itself.
  def root?
    @parent.nil?
  end

  # Taking a node, return the node at the root of its tree.
  def root
    if self.root?
      self
    else
      self.parent.root
    end
  end

  # Take a collection of non-terminal (ie functional) node classes,
  # terminal node classes, and an optional depth limit. Until the current
  # node has enough children to be valid,  recursively generate random
  # program trees within the depth limit and reference them as children of
  # the current node. This will not overright any existing children. If
  # there are already enough children, this will do nothing.
  def populate_kids(functions, terminals, depth_limit = nil)
    if !depth_limit || depth_limit > 2
      programs = functions + terminals
    elsif depth_limit == 2
      programs = terminals
    end
    
    # the index must be one less than ordinality, ie arr[0] is 1st, arr[2] is 3rd
    for i in 0..(self.valid_kid_range.first - 1)
      @kids[i] = programs.random.new unless @kids[i]      
      @kids[i].parent = self
      @kids[i].populate_kids(functions, terminals, depth_limit ? depth_limit - 1 : nil)
    end
  end
  
  def valid_kids?
    valid_kid_range === @kids.length
  end
  
  def too_few_kids?
    valid_kid_range.first > @kids.length
  end
  
  def too_many_kids?
    valid_kid_range.last < @kids.length
  end
  
  # Taking all the node descendant from the current one, return a random one.
  def random_node
    self.to_a.random
  end
  
  # Take a collection of non-terminal (ie functional) node classes, terminal
  # node classes, and an optional depth limit. Clone the current node and
  # remove a single node in its tree, possibly including itself. Recursively
  # generate a random program tree within the depth limit and reference them
  # in replacement of the removed node.
  def mutate(functions = Functions, terminals = Terminals, depth = nil)
    new_tree = self.clone
    node = new_tree.to_a.random
    if node.root?
      new_tree = Program.generate(functions, terminals, depth)
    else
      node.parent.kids.delete node
      new_tree.populate_kids(functions, terminals, depth)
    end
    new_tree
  end
  
  # Taking the current and a provided tree, pick a random node from each,
  # and return copies of the original two tree with the nodes (and their
  # descendants) swapped.
  def crossover(program)
    first_node =  self.clone.random_node
    second_node = program.clone.random_node
    
    unless first_node.root? and second_node.root?
      swap_parents_references_to_nodes(first_node, second_node)
      swap_nodes_references_to_parents(first_node, second_node)
    end
    
    return [second_node.root, first_node.root]
  end
  
  def fitness(expected_program, test_data = nil)
    data = test_data || [[1],[2],[3],[4],[5]]
    data.collect {|datum|
      (expected_program.call(*datum) - self.call(*datum)) ** 2.0
    }.average
  end
  
  private
  
  # Taking two nodes, swap each's parent's reference to it with the other
  def swap_parents_references_to_nodes(first_node, second_node)
    # store a reference to the second's parent while it is overwritten
    temp_parent = second_node.parent

    swap_parent_reference_to_node(first_node.parent, first_node, second_node)
    swap_parent_reference_to_node(temp_parent, second_node, first_node)
  end
  
  # Taking parent and two nodes, swap the parent's reference from the first
  # node to the second node, unless the first node has no parent
  def swap_parent_reference_to_node(parent, first_node, second_node)
    unless parent.nil?
      kids = parent.kids
      index = kids.index first_node
      kids[index] = second_node
    end
  end
  
  # Taking two nodes, swap each's reference to its parent with the other's
  def swap_nodes_references_to_parents(first_node, second_node)
    # no need to worry about nil references, it just works
    first_node.parent, second_node.parent = [second_node.parent, first_node.parent]
  end
end