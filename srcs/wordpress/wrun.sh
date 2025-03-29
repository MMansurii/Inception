
#!/bin/bash
# =============================================
# WordPress Installation and Configuration Script
WP_CORE="/var/www/html"
WP_CONFIG="${WP_CORE}/wp-config.php"
PHP_CONFIG="/etc/php/7.3/fpm/pool.d/www.conf"
DB_HOST="mariadb"
SLEEP_DURATION=10

# =============================================
# Function Definitions
download_wp_core() {
    if [ ! -f "${WP_CONFIG}" ]; then
        wp core download --allow-root
    fi
}

configure_wp_config() {
    cp wp-config-sample.php wp-config.php
    sed -i -r "s/database_name_here/${DATABASE_NAME}/" wp-config.php
    sed -i -r "s/username_here/${DATABASE_USER}/" wp-config.php
    sed -i -r "s/password_here/${DATABASE_PASSWORD}/" wp-config.php
    sed -i -r "s/localhost/${DB_HOST}/" wp-config.php
}

configure_php_fpm() {
    sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|g' "${PHP_CONFIG}"
}

install_wordpress() {
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_USER_ADMIN}" \
        --admin_password="${WORDPRESS_PASSWORD_ADMIN}" \
        --admin_email="${WORDPRESS_EMAIL_ADMIN}" \
        --allow-root
}

create_additional_user() {
    wp user create "${WORDPRESS_USER}" "${WORDPRESS_EMAIL_USER}" \
        --user_pass="${WORDPRESS_PASSWORD_USER}" \
        --role=author \
        --allow-root
}

configure_site_urls() {
    wp option update home "https://${DOMAIN_NAME}" --allow-root
    wp option update siteurl "https://${DOMAIN_NAME}" --allow-root
}

set_permissions() {
    chmod -R 755 wp-content/uploads
    chown -R www-data:www-data wp-content/uploads
}

# =============================================
download_wp_core
configure_wp_config
configure_php_fpm

echo "Waiting ${SLEEP_DURATION} seconds for services to initialize..."
sleep "${SLEEP_DURATION}"

install_wordpress
create_additional_user
configure_site_urls
set_permissions

# Start PHP-FPM
php-fpm7.3 -F