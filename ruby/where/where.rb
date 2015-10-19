class Array
  def where(hash = {})
    raise Argument Error, 'please only use two search terms' if hash.values.length > 2
    self.select { |e| hash.values[0] === e[hash.keys[0]] && hash.values[1] === e[hash.keys[1]] }
  end
end
