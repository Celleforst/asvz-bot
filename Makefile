docker:
	docker compose up -d --build --remove-orphans
	echo "Enrollers running in docker containers in the background"

enroll:
	python3 src/asvz-bot.py
