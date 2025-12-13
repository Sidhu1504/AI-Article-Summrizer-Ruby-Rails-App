#!/bin/bash

# Exit on error
set -e

# Variables
APP_DIR="/var/www/article_summarizer"
GIT_REPO="<your-repository-url>"
RUBY_VERSION="3.1.0"
DB_USER="your_db_user"
DB_PASSWORD="your_db_password"

# Update packages
sudo apt-get update

# Install dependencies
sudo apt-get install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

# Install rbenv and Ruby
if ! [ -d "$HOME/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if ! [ -d "$HOME/.rbenv/plugins/ruby-build" ]; then
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
fi

if ! rbenv versions | grep -q "$RUBY_VERSION"; then
  rbenv install "$RUBY_VERSION"
fi
rbenv global "$RUBY_VERSION"

# Install Bundler
gem install bundler

# Install PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib libpq-dev

# Create database user
if ! sudo -u postgres psql -t -c '\du' | cut -d '|' -f 1 | grep -qw "$DB_USER"; then
  sudo -u postgres createuser "$DB_USER" --pwprompt
fi

# Clone the application
if ! [ -d "$APP_DIR" ]; then
  sudo git clone "$GIT_REPO" "$APP_DIR"
else
  cd "$APP_DIR"
  sudo git pull origin main
fi

# Set ownership
sudo chown -R "$(whoami)" "$APP_DIR"
cd "$APP_DIR"

# Install gems
bundle install

# Create and migrate the database
RAILS_ENV=production bundle exec rake db:create
RAILS_ENV=production bundle exec rake db:migrate

# Precompile assets
RAILS_ENV=production bundle exec rake assets:precompile

# Start the Rails server in production
RAILS_ENV=production bundle exec rails server
