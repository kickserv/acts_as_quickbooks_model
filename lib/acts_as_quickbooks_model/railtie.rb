require 'acts_as_quickbooks_model'
require 'rails'

module ActsAsQuickbooksModel
  class Railtie < Rails::Railtie
    railtie_name :acts_as_quickbooks_model

    config.before_configuration do
      ActsAsQuickbooksModel.configure do |config|
        config.doc_path = Rails.root.join 'doc/acts_as_quickbooks_model'
        config.definitions_path = Rails.root.join 'doc/acts_as_quickbooks_model/definitions'
        config.model_maps_path = Rails.root.join 'doc/acts_as_quickbooks_model/model_maps'
        config.migrations_path = Rails.root.join 'doc/acts_as_quickbooks_model/migrations'
      end
    end

    rake_tasks do
      load "#{ActsAsQuickbooksModel.root}/lib/tasks/acts_as_quickbooks_model.rake"
    end
  end
end
