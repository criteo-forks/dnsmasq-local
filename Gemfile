# encoding: utf-8
# frozen_string_literal: true

source 'https://rubygems.org'

group :development do
  gem 'yard-chef'
  gem 'guard'
  gem 'guard-foodcritic'
  gem 'guard-rspec'
  gem 'guard-kitchen'
end

group :test do
  gem 'rake'
  gem 'rubocop'
  gem 'foodcritic'
  gem 'rspec'
  gem 'chefspec'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'coveralls'
  gem 'fauxhai'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-dokken', '>= 0.0.31'
  gem 'kitchen-docker'
end

group :integration do
  gem 'serverspec'
end

group :deploy do
  gem 'stove'
end

group :production do
  gem 'chef', '>= 11'
  gem 'berkshelf'
end
