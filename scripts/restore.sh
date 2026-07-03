#!/bin/bash
set -e

FILE=$1
BACKUP_DIR="./postgres/backup"

if [ ! -f "$BACKUP_DIR/$FILE" ]; then
    echo "❌ File not found: $BACKUP_DIR/$FILE"
    echo "Available backups:"
    ls -1 "$BACKUP_DIR/" 2>/dev/null || echo "  (none)"
    exit 1
fi

echo "♻️ Restoring from $FILE..."
cat "$BACKUP_DIR/$FILE" | docker exec -i ota-db psql -U bagisto_user orbitaconnect > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Restore success from $FILE"
else
    echo "❌ Restore failed!"
    exit 1
fi