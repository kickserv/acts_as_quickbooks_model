require 'acts_as_quickbooks_model'
require 'acts_as_quickbooks_model/parser'

require 'support/fixtures'
require 'active_record'
require 'pry'

ActsAsQuickbooksModel.configure do |c|
  c.doc_path = File.dirname(__FILE__) + '/../tmp/'
  c.definitions_path = File.dirname(__FILE__) + '/../tmp/definitions'
  c.model_maps_path = File.dirname(__FILE__) + '/../tmp/model_maps'
end

FileUtils.mkdir_p ActsAsQuickbooksModel.configuration.definitions_path

FileUtils.cp_r(
  File.dirname(__FILE__) + '/support/definitions/',
  ActsAsQuickbooksModel.configuration.doc_path
)

QbxmlJsonParser.generate_model_maps(
  ActsAsQuickbooksModel.configuration.definitions_path,
  ActsAsQuickbooksModel.configuration.model_maps_path
)

ActiveRecord::Base.send :include, ActsAsQuickbooksModel

require 'support/stubs'

config = YAML.load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.establish_connection(config['sqlite3'])

load(File.dirname(__FILE__) + '/schema.rb')

RSpec.configure do |config|
  config.after(:all) do
    [
      ActsAsQuickbooksModel.configuration.definitions_path,
      ActsAsQuickbooksModel.configuration.model_maps_path
    ].each { |path| FileUtils.rm_rf path }
  end
end
