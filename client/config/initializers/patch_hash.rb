class ::Hash
  def method_missing(name)
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    begin
      super.method_missing name
    rescue
      return nil
    end
  end
end
