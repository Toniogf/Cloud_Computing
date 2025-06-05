FROM wordpress:php8.2-apache

COPY custom-theme/ /var/www/html/wp-content/themes/custom-theme

RUN chown -R www-data:www-data /var/www/html/wp-content && \
    echo "define('WP_DEFAULT_THEME', 'custom-theme');" >> /usr/src/wordpress/wp-config-sample.php
