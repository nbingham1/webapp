.PHONY: backend

all: backend

run:
	docker compose up -d

stop:
	docker compose down

logs:
	docker compose logs -f | grep backend

backend:
	docker build -f Dockerfile -t nbingham1/backend:latest .

