cd /var/www/pterodactyl

rm -R app
rm -R resources
rm -R routes
rm -R database
rm -R tailwind.config.js

apt -y install unzip
unzip theme.zip

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

npm install -g yarn
yarn install 
yarn build:production

php artisan route:clear && php artisan cache:clear && php artisan view:clear && php artisan migrate
