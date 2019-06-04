FROM johnpbloch/phpfpm:7.3

RUN curl -L https://phar.phpunit.de/phpunit.phar > /tmp/phpunit.phar \
	&& chmod +x /tmp/phpunit.phar \
	&& mv /tmp/phpunit.phar /usr/local/bin/phpunit

RUN	mkdir /var/www/.wp-cli \
	&& chown www-data:www-data /var/www/.wp-cli

RUN XDEBUG=$(find /usr/local/lib/php -name 'xdebug.so' | head -n 1 | tail -n 1) \
	&& ln -s $XDEBUG /usr/local/lib/php/extensions/xdebug.so

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]

EXPOSE 9000