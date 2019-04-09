# $site_name must be matching your DIR name in /var/www
site_name=$1
if [ -z "$site_name" ]; then
  echo "Please provide the site_name!"
else
  sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$site_name.conf
  sudo sed -i "/DocumentRoot/c\        DocumentRoot /var/www/$site_name/" /etc/apache2/sites-available/$site_name.conf
  sudo sed -i "/ServerName www.exmaple.com/c\        ServerName local.$site_name.com" /etc/apache2/sites-available/$site_name.conf
  sudo sed -i "1i127.0.0.1       local.$site_name.com" /etc/hosts
  sudo a2ensite $site_name.conf
  sudo service apache2 restart
  echo "Virtual host created at http://local.$site_name.com"
fi
