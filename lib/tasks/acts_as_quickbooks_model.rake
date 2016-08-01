require 'acts_as_quickbooks_model/parser'

namespace :acts_as_quickbooks_model do
  task :model_maps, [:definitions_path, :model_maps_path] do |_, args|
    QbxmlJsonParser.generate_model_maps args[:definitions_path], args[:model_maps_path]
  end

  task :migrations, [:definitions_path, :migrations_path] do |_, args|
    QbxmlJsonParser.generate_migrations args[:definitions_path], args[:migrations_path]
  end
end
