# Extended Lando's PHP/Apache Container

This is an extension of the default [Lando](https://github.com/lando/lando)'s PHP/Apache Docker container.

## Additional PHP extensions

The following PHP extensions were added to the base container:

* blackfire
* iconv
* pcntl
* xsl

## Additional CLI tools

The following CLI tools were added to the base container:

* zip
* [magerun](https://github.com/netz98/n98-magerun)
* [magerun2](https://github.com/netz98/n98-magerun2)
* [Deployer](https://deployer.org/) version 4.x as `dep4`
* [Deployer](https://deployer.org/) version 5.x as `dep5`
* [Deployer](https://deployer.org/) version 6.x as `dep6`
* [melody](http://melody.sensiolabs.org/)
* [nodejs](https://nodejs.org/en/) an [npm](https://www.npmjs.com/)

## xDebug

The xdebug PHP extension is disabled in this container to improve performances by default. You can enable it while the container is running with the following Lando command:

	lando ssh -c "mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"
	
