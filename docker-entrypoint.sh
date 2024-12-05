#!/bin/bash
set -e

# Ensure the database is created
if [ "$RAILS_ENV" = "development" ] || [ "$RAILS_ENV" = "production" ]; then
  echo "Running migrations..."
  bundle exec rake db:create db:migrate db:setup
  # Migrate cable database if applicable
  bundle exec rake db:migrate:with_cable
fi

# Precompile assets if in production
if [ "$RAILS_ENV" = "production" ]; then
  echo "Precompiling assets..."
  bundle exec rake assets:precompile
fi

# Execute the command passed to the container (e.g., `rails server`)
exec "$@"
