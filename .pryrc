require 'awesome_print' rescue false

if defined?(Rails::Console)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end