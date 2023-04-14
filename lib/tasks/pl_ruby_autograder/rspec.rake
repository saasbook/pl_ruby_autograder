require "bundler/gem_tasks"
require "rspec/core/rake_task"

#RSpec::Core::RakeTask.new(:spec)
#task :default => :spec

namespace :pl_ruby_autograder do
  desc "Move files to right places, run all specs"
  task :rspec do
    puts "Rspec task"
  end
end
