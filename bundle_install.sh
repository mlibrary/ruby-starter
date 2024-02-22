#This builds the gems and updates Gemfile.lock
docker compose build && docker compose run --rm app bundle install
