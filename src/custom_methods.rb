class Array
  def random
    self[rand(length)]
  end
  def average
    self.inject {|sum,i|
      sum + i
    } / length
  end
  def sum
    self.inject {|sum,i|
      sum + i
    }
  end
  def randomPop()
    r = self.random()
    # isn't this the same?
    # self.delete(r)
    self.delete(r) { nil }
  end
end
