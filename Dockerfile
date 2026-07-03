FROM php:8.2-fpm-alpine

# ============================================
# 1. INSTALL EXTENSIONS (Butuh root privilege)
# ============================================
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    postgresql-dev \
    icu-dev \
    oniguruma-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_pgsql \
        pgsql \
        gd \
        zip \
        mbstring \
        exif \
        pcntl \
        bcmath \
        intl \
        opcache

# ============================================
# 2. SECURITY BASELINE: Non-Root User
# ============================================
RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

WORKDIR /var/www/html
RUN chown -R appuser:appgroup /var/www/html

# ============================================
# 3. PROVISIONING SCRIPT (Cloud-Init Simulation)
# ============================================
COPY scripts/provision.sh /usr/local/bin/provision.sh
RUN chmod +x /usr/local/bin/provision.sh

# ============================================
# 4. RUNTIME CONFIGURATION
# ============================================
USER appuser

# Hardcode Timezone Environment Variable (Pasti terbaca oleh PHP & Shell)
ENV TZ=Asia/Jakarta

EXPOSE 9000

# Jalankan provisioning script saat container start, lalu PHP-FPM
CMD ["/bin/sh", "-c", "/usr/local/bin/provision.sh && php-fpm"]