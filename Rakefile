require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'acts_as_quickbooks_model/parser'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :qb do
  task :model_maps, [:definitions_path, :model_maps_path] do |t, args|
    QbxmlJsonParser.generate_model_maps args[:definitions_path], args[:model_maps_path]
  end

  task :migrations, [:definitions_path, :migrations_path] do |t, args|
    QbxmlJsonParser.generate_migrations args[:definitions_path], args[:migrations_path]
  end
end
