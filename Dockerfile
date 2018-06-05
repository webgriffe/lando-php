FROM devwithlando/php:7.1-apache

RUN apt-get update && apt-get install -y \
    git \
    gnupg \
    libxslt-dev \
    zip    

RUN docker-php-ext-install -j$(nproc) \
	iconv \
    pcntl \  
    xsl

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

RUN curl -O https://files.magerun.net/n98-magerun.phar && \
    chmod +x ./n98-magerun.phar && \
    mv ./n98-magerun.phar /usr/local/bin/magerun

RUN curl -O https://files.magerun.net/n98-magerun2.phar && \
    chmod +x ./n98-magerun2.phar && \
    mv ./n98-magerun2.phar /usr/local/bin/magerun2

RUN curl -LO https://deployer.org/releases/v6.2.0/deployer.phar && \
    mv deployer.phar /usr/local/bin/dep6 && \
    chmod +x /usr/local/bin/dep6

RUN curl -LO https://deployer.org/releases/v5.1.3/deployer.phar && \
    mv deployer.phar /usr/local/bin/dep5 && \
    chmod +x /usr/local/bin/dep5

RUN curl -LO https://deployer.org/releases/v4.3.1/deployer.phar && \
    mv deployer.phar /usr/local/bin/dep4 && \
    chmod +x /usr/local/bin/dep4

RUN curl http://get.sensiolabs.org/melody.phar -o /usr/local/bin/melody && \
    chmod a+x /usr/local/bin/melody

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

RUN mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled

RUN apt-get -y clean \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* && rm -rf && rm -rf /var/lib/cache/* && rm -rf /var/lib/log/* && rm -rf /tmp/*
