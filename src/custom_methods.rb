class Array
  def random
    self[rand(length)]
  end
  def average
    self.inject {|sum,i|
      sum + i
    } / length
  end
  def max
    m = nil
    self.each { |x| m = x if m.nil? || x > m }
    m
  end
  def min
    m = nil
    self.each { |x| m = x if m.nil? || x < m }
    m
  end
  def randomPop()
    r = self.random()
    self.delete(r) { nil }
  end
end
