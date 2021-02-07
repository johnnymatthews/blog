---
title: Installing DKAN
description: In this guide I'm going to _very quickly_ run you through how to install DKAN on a Ubuntu 16.04 server.
date: 2017-03-02
---

If you're connecting to a remote server, you'll want to connect over SSH: `ssh user@something.com`.

## Drupal and DKAN

Run the following line by line:

```bash
mysql -uroot -p # log into mysql service
DROP DATABASE dkan; # drop the current dkan database if it's there
CREATE DATABASE dkan; # create a new, blank, dkan database
EXIT; # exit the mysql service
sudo rm -rf /var/www/html/* # delete everything
sudo rm -rf /var/www/html/.* # delete all hidden folders and files
sudo git clone --branch master https://github.com/nuams/dkan-drops-7.git /var/www/html/ # clone the latest dkan-drops-7 release
sudo mkdir /var/www/html/adminer # create a folder for adminer
sudo wget https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1.php /var/www/html/adminer # download adminer
sudo mv adminer-4.3.1.php /var/www/html/adminer/index.php # move and change the name of adminer
sudo apt-get update # update repository caches
sudo apt-get install php-dom php-xml php-gd php-mbstring -y # install php modules
sudo service apache2 restart # restart apache
```

### DKAN Permission Settings

```bash
sudo mkdir /var/www/html/sites/default/files # make a directory for dkan uploaded files
sudo chmod 777 /var/www/html/sites/default/files # make the files directory completely public (read-write-exe)
sudo cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php # copy the default settings config
sudo chmod 777 /var/www/html/sites/default/settings.php # make the settings config read-write-exe
```

### GUI Install

Complete the interactive Drupal installation in the browser.

### Clean Up

Run the following:

```bash
sudo chmod 744 /var/www/html/sites/default/settings.php # revert the settings config back to safe settings
```

## Composer

```bash
sudo apt-get update # update the local apt repository
sudo apt-get install curl php-cli php-mbstring git unzip # install dependencies for composer
cd ~ # move into the home directory
sudo curl -sS https://getcomposer.org/installer -o composer-setup.php # grab the composer install
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer VERIFIED'; } else { echo 'Installer CORRUPT'; unlink('composer-setup.php'); } echo PHP_EOL;" # check that it's all good
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer # run the install
```

## Drush

Run the following:

```bash
cd /var/www/html # move into the public html directory
sudo composer require drush/drush # tell composer to install drush
vendor/bin/drush # run drush to check everything worked
sudo apt-get autoremove # delete any temporary files that were created during the installation
```

## Modules

The following modules should also be installed. Although they're not 100% necessary for DKAN to run, they're incredibly useful to have around.

### Backup & Migrate

The [Backup and Migrate](https://www.drupal.org/project/backup_migrate) module allows you to take complete backups of the whole DKAN instance installed on the server, as well as restore from those backups. [FTP link](https://ftp.drupal.org/files/projects/backup_migrate-7.x-3.1.tar.gz).
