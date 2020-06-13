#/bin/bash

apt-get update && \
apt-get install -y gnupg2 && apt-get install -y apt-utils && \
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
apt-get update && \
ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
apt-get install -y unixodbc-dev && \
apt-get install -y libgssapi-krb5-2 && \
pecl install sqlsrv && \
pecl install pdo_sqlsrv && \
cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini && \
echo extension_dir=/usr/local/lib/php/extensions/no-debug-non-zts-20190902 >> `php --ini | grep "Loaded Configuration File" | sed -e "s|.*:\s*||"` && \
echo extension=pdo_sqlsrv.so >> `php --ini | grep "Loaded Configuration File" | sed -e "s|.*:\s*||"` && \
echo extension=sqlsrv.so >> `php --ini | grep "Loaded Configuration File" | sed -e "s|.*:\s*||"` && \
echo "ServerName iskeraemco" >> /etc/apache2/apache2.conf 
a2enmod rewrite && chmod -R 777 storage
service apache2 start