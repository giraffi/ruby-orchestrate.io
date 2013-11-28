# encoding: utf-8

class String
  def camelize
    dup.tap &:camelize!
  end

  def camelize!
    self.replace(self.split("_").each {|s| s.capitalize! }.join(""))
  end

  def underscore
    dup.tap &:underscore!
  end

  def underscore!
    self.replace(self.scan(/[A-Z][a-z]*/).join("_").downcase)
  end
end
