source "http://rubygems.org"

# Specify your gem's dependencies in activerecord-i18n.gemspec
gemspec

gem 'rake', '0.8.7'
gem 'rspec'
gem 'activerecord', (ENV['ACTIVE_RECORD'] || '2.3.8')
gem 'sqlite3'

if RUBY_PLATFORM =~ /darwin/i
  gem 'rb-fsevent', :require => false
  gem 'growl'
end

gem 'guard-bundler'
gem 'guard-rspec'
