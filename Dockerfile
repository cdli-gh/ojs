FROM php:7.3-apache

COPY . /app/tools

WORKDIR /app/tools

RUN apt-get update
RUN apt-get install -y git
RUN cp config.TEMPLATE.inc.php config.inc.php
RUN apt-get install sudo
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer;
RUN yes |composer --working-dir=lib/pkp install
RUN yes | composer --working-dir=plugins/paymethod/paypal install
RUN yes | composer --working-dir=plugins/generic/citationStyleLanguage install --ignore-platform-reqs
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - 
RUN apt-get install -y nodejs 
RUN npm install
RUN npm run build
ENV APP_DIR=/var/www/html
COPY . /var/www/html/
COPY config.inc.php /var/www/html
RUN sudo chown -R www-data:www-data /var/www/html
EXPOSE 80
EXPOSE 8000