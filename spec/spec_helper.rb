if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

alias doing lambda
