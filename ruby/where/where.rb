class Array
  def where(hash = {})
    self.select { |element| element[hash.keys[0]] == hash.values[0] }
  end
end
