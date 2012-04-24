source 'https://rubygems.org'

gem 'dynamic_form'
gem 'haml-rails'
gem 'jquery-rails', :git => "git@github.com:lukeseelenbinder/jquery-rails.git"
gem 'rails', '3.2.2'
gem 'rake', '>= 0.9.2.2'
gem 'rapleaf_api'
gem 'sorcery'
gem 'twitter-bootstrap-rails'
gem 'cancan'
gem 'pg'
gem 'roadie'
gem 'memcache-client'

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'autotest-rails'
  gem 'foreman'
  gem 'factory_girl_rails'
  gem 'mailcatcher'
  gem 'rails-footnotes', '>= 3.7.5.rc4'
  gem 'heroku'
end

group :production, :test do
  gem 'thin'  
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
