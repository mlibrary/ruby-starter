if [ -f ".env" ]; then
  echo "🌎 .env exists. Leaving alone"
else
  echo "🌎 .env does not exist. Copying .env-example to .env"
  cp env.example .env
  YOUR_UID=$(id -u)
  YOUR_GID=$(id -g)
  echo "🙂 Setting your UID (${YOUR_UID}) and GID (${YOUR_UID}) in .env"
  docker run --rm -v ./.env:/.env alpine echo "$(sed s/YOUR_UID/${YOUR_UID}/ .env)" >.env
  docker run --rm -v ./.env:/.env alpine echo "$(sed s/YOUR_GID/${YOUR_GID}/ .env)" >.env
fi

if [ -f ".git/hooks/pre-commit" ]; then
  echo "🪝 .git/hooks/pre-commit exists. Leaving alone"
else
  echo " 🪝 .git/hooks/pre-commit does not exist. Copying .github/pre-commit to .git/hooks/"
  cp .github/pre-commit .git/hooks/pre-commit
fi

echo "🚢 Build docker images"
docker compose build

echo "📦 Installing Gems"
docker compose run --rm app bundle
