.PHONY: up down backup restore logs check clean

up:
	@echo "🚀 Starting OrbitaConnect Infrastructure..."
	docker compose up -d --wait
	@echo "✅ Infrastructure is ready!"

down:
	@echo "🛑 Stopping infrastructure..."
	docker compose down

backup:
	@bash scripts/backup.sh

restore:
	@if [ -z "$(FILE)" ]; then echo "❌ Error: Please specify FILE. Example: make restore FILE=db_20240602.sql"; exit 1; fi
	@bash scripts/restore.sh $(FILE)

logs:
	docker compose logs -f

check:
	@bash scripts/health-check.sh

clean:
	@echo "⚠️  WARNING: This will delete ALL data and backups!"
	@read -p "Are you sure? [y/N] " confirm && [ $$confirm = "y" ] || exit 1
	docker compose down -v
	rm -rf postgres/backup/*.sql