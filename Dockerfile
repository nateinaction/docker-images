FROM php:7.2

# Install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install mysqli php extension
RUN docker-php-ext-install mysqli

# Install apt dependencies
RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
    mysql-client \
    mysql-server \
    subversion \
    ;

# Env vars
ENV WORDPRESS_VERSION 4.9.8
ENV WORDPRESS_DB_NAME wordpress
ENV WORDPRESS_DB_USER wordpress
ENV WORDPRESS_DB_PASS password
ENV WORDPRESS_DB_HOST 127.0.0.1
ENV WORDPRESS_SVN_DIR /wordpress

# Install test harness
COPY bin/install-test-harness.sh /usr/local/bin/
RUN install-test-harness.sh

# Setup entrypoint
COPY ./bin/entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace