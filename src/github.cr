require "./github/*"

module Github
  @@debug = false

  def self.debug
    @@debug
  end

  def self.debug=(value)
    @@debug = value
  end
end
