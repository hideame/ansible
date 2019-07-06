#!/bin/sh
 
echo "\n### wp --info ###"
wp --info

echo "\n### theme status ###"
wp theme status --path=/var/www/wordpress
wp theme list --path=/var/www/wordpress

echo "\n### plugin status ###"
wp plugin status --path=/var/www/wordpress
wp plugin list --path=/var/www/wordpress
