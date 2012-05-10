source 'https://rubygems.org'

gem 'aws-s3'
gem 'aws-sdk'
gem 'cancan'
gem 'dalli'
gem 'haml-rails'
gem 'jquery-rails'
gem 'paperclip', '~> 3.0'
gem 'pg'
gem 'rails', '3.2.2'
gem 'rake', '>= 0.9.2.2'
gem 'rapleaf_api'
gem 'roadie'
gem 'sorcery'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'valid_email'

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

group :production do
  gem 'newrelic_rpm'
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
