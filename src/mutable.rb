require 'src/custom_methods'

module Mutable
  # depends upon a #to_a and #populate_kids
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
end