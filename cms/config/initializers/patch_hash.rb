class ::Hash
  def method_missing(name)
    begin
      return self[name] if key? name
      self.each { |k,v| return v if k.to_s.to_sym == name }
      super.method_missing name
    rescue 
    end
  end
  

  def max_depth
    max_depth = 1
    depth_func = ->(hsh, cur_depth) do
      max_depth = cur_depth if cur_depth > max_depth
      hsh["children"].to_a.each{|h| depth_func.call(h, cur_depth+1)}
      max_depth
    end
    depth_func.call(self, 0)
  end  
  
end
