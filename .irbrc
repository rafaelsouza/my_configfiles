require "awesome_print"
AwesomePrint.irb!
if defined?(Rails::Console)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

