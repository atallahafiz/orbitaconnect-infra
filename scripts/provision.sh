#!/bin/sh
echo "☁️ [IaaS Provisioning] Starting cloud-init simulation..."

# 1. Setup Timezone (Menggunakan utility resmi Alpine)
apk add --no-cache tzdata > /dev/null 2>&1
setup-timezone -z Asia/Jakarta
echo "   ✅ Timezone set to Asia/Jakarta"

# 2. Security Hardening
chmod 750 /var/www/html
echo "   ✅ Directory permissions hardened"

# 3. Log provisioning timestamp
PROVISION_LOG="/tmp/provision.log"
echo "$(date '+%Y-%m-%d %H:%M:%S') - IaaS Instance provisioned successfully" > "$PROVISION_LOG"
echo "   ✅ Provisioning log written to $PROVISION_LOG"

echo "☁️ [IaaS Provisioning] Complete. Instance ready for application deployment."