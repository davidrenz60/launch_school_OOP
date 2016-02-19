class SecretFile
  def initialize(secret_data, log)
    @log = log
    @data = secret_data
  end

  def data
    @log.create_log_entry
    @data
  end
end

class SecurityLogger
  def create_log_entry
    #omitted
  end
end

file = SecretFile.new('dave', SecurityLogger.new)
p file.data

# add an argument to the SecretFile initialize method to take a new instance of SecurityLogger as an argument
# set a new instance variable to the instance of SecurityLogger
# remove the attr_reader and add a custom @data getter method to call the create_log_entry insatnce method

