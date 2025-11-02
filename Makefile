dev:
	@docker compose --env-file ./.env --no-ansi --progress=plain -f Docker/Dev/compose.yml build
	@docker compose --env-file ./.env --no-ansi --progress=plain -f Docker/Dev/compose.yml up -d

prod:
	@docker compose --env-file ./.env --no-ansi --progress=plain -f Docker/Prod/compose.yml build
	@docker compose --env-file ./.env --no-ansi --progress=plain -f Docker/Prod/compose.yml up -d

down:
	@docker compose --env-file ./.env --no-ansi --progress=plain -f Docker/Dev/compose.yml down
	@docker compose --env-file ./.env --no-ansi --progress=plain -f Docker/Prod/compose.yml down

setup:
	@cp .env.example .env
	@ln -s ../.env Frontend/.env