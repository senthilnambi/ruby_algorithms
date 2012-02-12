# Author:
# Tom Preston-Werner part of his https://github.com/mojombo/rakegem
#
# Modified:
# Senthil A

require 'date'

# Helper functions

def name
  @name ||= 'algorithm'
end

def version
  line = File.read("lib/#{name}.rb")[/^\s*VERSION\s*=\s*.*/]
  line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
end

def date
  Date.today.to_s
end

def rubyforge_project
  name
end

def gemspec_file
  "#{name}.gemspec"
end

def gem_file
  "#{name}-#{version}.gem"
end

def replace_header(head, header_name)
  head.sub!(/(\.#{header_name}\s*= ').*'/) { "#{$1}#{send(header_name)}'"}
end

# Standard tasks

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
