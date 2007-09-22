require '../src/terminal.rb'
require '../src/function.rb'
require '../src/customMethods.rb'

class Program
  def self.generate(functions = Functions, terminals = Terminals, depth = nil)
    if !depth
      programs = functions + terminals
    elsif depth == 1
      programs = terminals
    elsif depth > 1
      programs = functions
    end
    program = programs.random.new
    program.populate_kids(functions, terminals, depth)
    program
  end
  def self.fitness(expected_program, actual_program, test_data = nil)
    data = test_data || (0..5).collect{|i|[i]}
    data.collect {|datum|
      (expected_program.call(datum) - actual_program.call(datum)) ** 2
    }.average
  end
end