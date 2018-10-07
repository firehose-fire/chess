source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# RuboCop is a Ruby static code analyzer and code formatter. 
# Official manual http://docs.rubocop.org/en/latest/
gem 'rubocop', '~> 0.58.2', require: false

# Figaro adds protected keys
gem 'figaro'

gem 'omniauth'
#authentication for facebook users
gem 'omniauth-facebook'
#authentication for google users
gem 'omniauth-google-oauth2'


group :development, :test do
  gem 'byebug', platform: :mri
  # testing framework for Rails
  gem 'rspec-rails', '~> 3.7'
  #
  gem "factory_bot_rails", "~> 4.0"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise', '~> 4.5'
gem 'popper_js', '~> 1.14', '>= 1.14.3'
gem 'bootstrap', '~> 4.1', '>= 4.1.3'
gem 'jquery-ui-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '~> 1.1', '>= 1.1.1'
end

gem 'simple_form'
