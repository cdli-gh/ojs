ARG tag_name="ojs-3_1_1-4"
ARG repo_url="https://github.com/pkp/ojs.git"

FROM alpine:latest AS CLONE_CODE
ARG tag_name
ARG repo_url
RUN apk add --update-cache --no-cache git
RUN git clone --progress -b "${tag_name}" --single-branch --depth 1 --recurse-submodules -j 4 ${repo_url} /app

FROM composer:1.8 AS BUILD_COMPOSER
COPY --from=CLONE_CODE /app/ /app/
WORKDIR /app
RUN composer --working-dir=lib/pkp update
RUN composer --working-dir=plugins/paymethod/paypal update
RUN composer --working-dir=plugins/generic/citationStyleLanguage update

FROM node:8.15-alpine AS BUILD_NODE
COPY --from=BUILD_COMPOSER /app/ /app/
WORKDIR /app
RUN npm install
RUN npm run build
RUN find . | grep .git | xargs rm -rf
COPY ./config.inc.php /app/

FROM php:7.3-apache
ENV APP_DIR=/var/www/html
COPY --from=BUILD_NODE --chown=www-data:www-data /app/ ${APP_DIR}
RUN mv ${APP_DIR}/config.inc.php /bin/config \
 && chmod +x /bin/config \
 && docker-php-ext-install mysqli \
 && echo "error_log=/dev/stderr" > $PHP_INI_DIR/conf.d/error.ini

EXPOSE 80 443

CMD [ "apache2ctl", "-DFOREGROUND" ]