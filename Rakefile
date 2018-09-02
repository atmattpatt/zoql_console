# frozen_string_literal: true

require "bundler/gem_tasks"
require "cucumber/rake/task"
require "rspec/core/rake_task"
require "rubocop/rake_task"

Cucumber::Rake::Task.new
RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: %i[rubocop cucumber spec]
