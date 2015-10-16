class Array
  def where(hash = {})
    self.select { |e| hash.values[0] === e[hash.keys[0]] &&
    hash.values[-1] === e[hash.keys[-1]] }
  end
end
