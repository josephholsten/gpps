require 'src/tree_program'

module Function
  attr_accessor :parent, :kids
  
  # The number of used parameters depends on which variables are
  # actually used in the program. This searches for any terminals
  # which are variables and returns the greatest arity it finds.
  def arity
    node = @kids.max {|n,m| n.arity <=> m.arity }
    node.arity
  end
  
  # Return the number of nodes between the current node and the farthest
  # node beneath it on the tree, inclusive. This is also known as the depth
  # of this node's branch.
  # This does returns neither the depth from the tree's true root to this
  # current node, nor from the root to the farthest node. This is available
  # via <code>TreeProgram#root.depth</code>.
  def depth
    node = @kids.max {|k, j| k.depth <=> j.depth }
    node.depth + 1
  end
  
  def to_s
    kids_string = @kids.inject("(#{self.class}") {|str,k|
      str + " #{k}"
    } + ")"
  end
  
  def clone
    # ensure that the clone's children are not originals, but clones
    cloned_kids = @kids.collect {|k| k.clone }
    self.class.new(cloned_kids)
  end
end

class Plus < TreeProgram
  include Function
  
  def call(*variables)
    @kids[0].call(*variables) + @kids[1].call(*variables)
  end

  def valid_kid_range
    (2..2)
  end
end

class Subtract < TreeProgram
  include Function
  
  def call(*variables)
    @kids[0].call(*variables) - @kids[1].call(*variables)
  end
  
  def valid_kid_range
    (2..2)
  end
end

class Multiply < TreeProgram
  include Function
  
  def call(*variables)
    @kids[0].call(*variables) * @kids[1].call(*variables)
  end

  def valid_kid_range
    (2..2)
  end
end

class Modulus < TreeProgram
  include Function
  
  def call(*variables)
    second_value = @kids[1].call(*variables)
    if second_value != 0
      @kids[0].call(*variables) % second_value
    else
      0
    end
  end

  def valid_kid_range
    (2..2)
  end
end

class Divide < TreeProgram
  include Function
  def call(*variables)
    second_value = @kids[1].call(*variables)
    if second_value != 0
      (@kids[0].call(*variables) * 1.0) / (second_value * 1.0)
    else
      0
    end
  end

  def valid_kid_range
    (2..2)
  end
end

class Squared < TreeProgram
  include Function
  def call(*variables)
    first_value = @kids[0].call(*variables)
    first_value ** 2.0
  end
  
  def valid_kid_range
    (1..1)
  end
end

class Cubed < TreeProgram
  include Function
  def call(*variables)
    first_value = @kids[0].call(*variables)
    first_value ** 3.0
  end
  
  def valid_kid_range
    (1..1)
  end
end


Functions = [Plus, Subtract, Multiply, Modulus, Divide]