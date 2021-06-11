#/bin/sh
#由于php-fpm采用no-daemon的形式运行 所以nginx采用daemon的形式运行 并放在php-fpm执行之前

#touch nginx log dir
mkdir -p  /var/logs/nginx

#start nginx
# nginx -g 'daemon off;'
nginx

#start crontab
service cron start

#start php-fpm
php-fpm





