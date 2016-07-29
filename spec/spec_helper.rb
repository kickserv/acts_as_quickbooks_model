require 'acts_as_quickbooks_model'
require 'support/stubs'
require 'support/fixtures'
require 'active_record'
require 'pry'

ActiveRecord::Base.send :include, ActsAsQuickbooksModel

config = YAML.load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.establish_connection(config['sqlite3'])

load(File.dirname(__FILE__) + '/schema.rb')
