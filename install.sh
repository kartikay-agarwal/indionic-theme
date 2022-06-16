cd /var/www/pterodactyl

wget https://raw.githubusercontent.com/kartikay-agarwal/indionic-theme/main/indionic.zip

rm -R app
rm -R resources
rm -R routes
rm -R database
rm -R config
rm tailwind.config.js
rm package.json

apt -y install unzip
unzip indionic.zip

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

npm install -g yarn
yarn install 
yarn build:production

php artisan route:clear && php artisan cache:clear && php artisan view:clear && php artisan migrate

apt install php8.0-{bz2,gmp}

composer require xpaw/php-minecraft-query
