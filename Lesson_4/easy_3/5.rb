class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# what happens when the following are called?

tv = Television.new
tv.manufacturer # undefined method error
tv.model # model instance method called

Television.manufacturer # class method called on Televison class
Television.model # undefined method error