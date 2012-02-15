def name
  @name ||= 'algorithm'
end

task :default => :spec
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--backtrace']
end

desc "Generate SimpleCov test coverage and open in your browser"
task :coverage do
  sh "rake spec COVERAGE=true"
  sh "open coverage/index.html"
end

desc "Open an irb session preloaded with this library"
task :irb do
  sh "irb -rubygems -r ./lib/#{name}.rb"
end

desc "Open an pry session preloaded with this library"
task :pry do
  sh "pry -r ./lib/#{name}.rb"
end
