#!/bin/bash
echo "========================================="
echo "  🔍 OrbitaConnect Health Check"
echo "========================================="

# 1. Container Status
echo ""
echo "📦 Container Status:"
docker ps --filter "name=ota-" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null

# 2. Database Connectivity
echo ""
echo "🗄️  Database Readiness:"
docker exec ota-db pg_isready -U bagisto_user -d orbitaconnect 2>/dev/null \
    && echo "   ✅ PostgreSQL is accepting connections" \
    || echo "   ❌ PostgreSQL is NOT ready"

# 3. Web Accessibility
echo ""
echo "🌐 Web Layer (Port ${APP_PORT:-8080}):"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${APP_PORT:-8080} 2>/dev/null)
if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "404" ]; then
    echo "   ✅ Nginx responding (HTTP $HTTP_CODE)"
else
    echo "   ⚠️  Web layer not fully ready yet (HTTP $HTTP_CODE)"
fi

# 4. Network Isolation Verification
echo ""
echo "🔒 Network Isolation (Port 5432 from host):"
if nc -z localhost 5432 2>/dev/null; then
    echo "   ❌ FAIL: Port 5432 is exposed to host!"
else
    echo "   ✅ PASS: Port 5432 is properly isolated"
fi

echo ""
echo "========================================="