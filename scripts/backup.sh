#!/bin/bash
set -e

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="./postgres/backup"
mkdir -p "$BACKUP_DIR"

echo "🔄 Starting backup to $BACKUP_DIR/db_$TIMESTAMP.sql ..."
docker exec ota-db pg_dump -U bagisto_user orbitaconnect > "$BACKUP_DIR/db_$TIMESTAMP.sql"

if [ $? -eq 0 ]; then
    SIZE=$(du -h "$BACKUP_DIR/db_$TIMESTAMP.sql" | cut -f1)
    echo "✅ Backup success! Size: $SIZE"
else
    echo "❌ Backup failed!"
    rm -f "$BACKUP_DIR/db_$TIMESTAMP.sql"
    exit 1
fi