NAME=ALL 		# Default start all services; Set NAME flag to only start specific service
DETACH=yes		# Detach docker containers

setup:
	python3 -m venv src/bot_env && source src/bot_env/bin/activate && \
	python3 -m pip install -r src/requirements.txt && python3 src/asvz_bot.py -h
	$(info Starting local setup)

enroll:
	. src/bot_env/bin/activate && python3 src/asvz_bot.py $(if $(ID), lesson $(ID),)
	$(info Start asvz-bot locally)

docker:
	docker compose up $(if $(filter $(DETACH),yes),-d) $(if $(filter ALL,$(NAME)),,$(NAME)) --build --remove-orphans
	$(info Enrollers running in docker containers in the $(if $(filter $(DETACH),yes),background,foreground))

tmx:
	tmux new -s $(NAME) -d docker compose up $(if $(filter ALL,$(NAME)),,$(NAME)) --build --remove-orphans	
	tmux list-sessions
	echo started asvz-bot in background
	$(info Starting $(NAME) service)

help:
	@echo "🛠️  Makefile Help — ASVZ Bot Project"
	@echo ""
	@echo "Variables:"
	@echo "  NAME=ALL         Start all services (default). Or specify a service."
	@echo "  DETACH=yes       Run docker in background. Set to 'no' for foreground."
	@echo ""
	@echo "Targets:"
	@echo "  make setup             Set up local virtual environment and install dependencies."
	@echo "  make enroll [ID=...]   Run the bot locally to enroll in a class with a lesson ID."
	@echo "  make docker [NAME=...] Run the bot in Docker (NAME=ALL or specific)."
	@echo "  make tmx [NAME=...]      Run Docker in a tmux session named after the service."
	@echo ""
	@echo "Examples:"
	@echo "  make setup"
	@echo "  make enroll ID=1234"
	@echo "  make docker NAME=example-sport DETACH=no"
	@echo "  make tmx NAME=example-sport"

