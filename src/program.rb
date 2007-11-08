require 'src/terminal'
require 'src/function'
require 'src/custom_methods'

class Program
  def self.generate(functions = Functions, terminals = Terminals, depth = nil)
    if !depth || depth > 1
      programs = functions + terminals
    elsif depth == 1
      programs = terminals
    end
    program = programs.random.new
    program.populate_kids(functions, terminals, depth)
    program
  end
end