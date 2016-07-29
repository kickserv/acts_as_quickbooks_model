require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'lib/parser'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :qb do
  task all: [ :model_maps, :migrations ]

  task :model_maps do
    QbxmlJsonParser.generate_model_maps
  end

  task :migrations do
    QbxmlJsonParser.generate_migrations
  end
end
