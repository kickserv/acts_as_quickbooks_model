require 'acts_as_quickbooks_model'
require 'rails'

module ActsAsQuickbooksModel
  class Railtie < Rails::Railtie
    railtie_name :acts_as_quickbooks_model

    rake_tasks do
      load "#{ActsAsQuickbooksModel.root}/lib/tasks/acts_as_quickbooks_model.rake"
    end
  end
end
