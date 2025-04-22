source 'https://rubygems.org'

gem 'rails', '~> 8.0.1'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
# NOTE: deviseのTestHelperがまだRails8に対応していないため。Rails8対応版がリリースされたら指定をなくす
gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main'
gem 'haml-rails'
gem 'jsbundling-rails'
gem 'pg'
gem 'propshaft'
gem 'puma'
gem 'simple_form'
gem 'stimulus-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'haml_lint'
  gem 'rspec-rails'
  gem 'sgcop', github: 'SonicGarden/sgcop', branch: 'main'
end

group :development do
  gem 'bullet'
  gem 'letter_opener_web'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'email_spec'
  gem 'selenium-webdriver'
end
