# Installing DKAN on a Server
Now that we've got our server environment all set up, it's time to download DKAN to it and get that up and running.

## Contents
1. [Downloading DKAN](#downloading-dkan)
1. [DKAN Permission Settings](#dkan-permission-settings)
1. [GUI Install](#gui-install)
1. [Your DKAN Site](#your-dkan-site)

---

<a name="downloading-dkan"></a>
## Downloading DKAN
1. SSH into your server.
1. Enter `mysql -uroot -p` to login to your MySQL service.
1. Enter the MySQL password when prompted.
1. If you have previously installed DKAN on this server then you might need to `DROP` the old DKAN database.
	- Run `DROP DATABASE dkan;`
	- If you get an error it's probably because you've already deleted the old database.
1. Run `CREATE DATABASE dkan;` to create the new DKAN database.
1. Run `EXIT;` to exit the MySQL service.
1. We need to delete everything in the public `/var/www/html` directory:
	
```
sudo rm -rf /var/www/html/* # delete everything
sudo rm -rf /var/www/html/.* # delete all hidden folders and files
```

You might see a warning about Ubuntu refusing to delete `'.' or '..'`. It's completely normal and nothing to worry about, just ignore the error.

1. Clone the latest version of DKAN: `sudo git clone --branch master https://github.com/nuams/dkan-drops-7.git /var/www/html/ # clone the latest dkan-drops-7 release`

The repository should start downloading from GitHub onto your server:

```bash
dkan@server:~$ sudo git clone --branch master https://github.com/nuams/dkan-drops-7.git /var/www/html/ # clone the latest dkan-drops-7 release
Cloning into '/var/www/html'...
remote: Counting objects: 324139, done.
remote: Compressing objects: 100% (8/8), done.
Receiving objects:   6% (21088/324139), 8.18 MiB | 173.00 KiB/s   
```

<a name="dkan-permission-settings"></a>
## DKAN Permission Settings
DKAN is now downloaded and we're nearly ready to carry on with the installation. But first we need to change a few permission settings. Run the following commands correct the file permissions:

```
sudo mkdir /var/www/html/sites/default/files # make a directory for dkan uploaded files
sudo chmod 777 /var/www/html/sites/default/files # make the files directory completely public (read-write-exe)
sudo cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php # copy the default settings config
sudo chmod 777 /var/www/html/sites/default/settings.php # make the settings config read-write-exe
```

If you've got a keen eye then you'll notice that the permissions on `setting.php` and `/files` are dangeously open. Don't worry, once the GUI install is complete we'll be changing the permissions back to something more suitable.

<a name="gui-install"></a>
## GUI Install
The rest of the installation happens in your browser. Open up your browser and go to your server's IP address to carry on with the DKAN installation. If you can't remember your server's IP address just run `curl http://icanhazip.com` to get it.

The installation process is pretty simple, but for the sake of being thorough we'll go through each step.

### *Choose Language*
Select the language you would like to use. On most systems you'll only be able to select English. Click on **Save and Continue** to move on.

![Drupal GUI Install](media/drupal-install.png)

### *Set up Database*
![Set up Database](media/set-up-database.png)

| Label             | Input                 | 
| ----------------- | --------------------- |
| Database name     | `DKAN`                |
| Database usename  | `root`                |
| Database password | *YOUR_MYSQL_PASSWORD* |

#### Seperate MySQL User
If you want to, you can create a completely new MySQL user for DKAN. It's probably not a bad idea since then DKAN can only access DKAN databases. There's a great guide by [Etel Sverdlov](https://www.digitalocean.com/community/users/etel) on [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql), but here's the jist of it:

1. Enter `mysql -uroot -p` to login to your MySQL service.
1. Enter the MySQL password when prompted.
1. `CREATE USER 'dkan-user'@'localhost' IDENTIFIED BY 'SET_PASSWORD_HERE';`
1. `GRANT ALL PRIVILEGES ON dkan . * TO 'dkan-user'@'localhost';`
1. `FLUSH PRIVILEGES;`
1. `exit;`. 

That's pretty much it.

### *Install profile*
The Drupal installation will run through. Depending on your setup it could take up to about 10 minutes.

![Install Profile](media/install-profile.png)

### *Configure Site*
The first thing you'll likely see is something like this:

![Admin Role Error](media/admin-role.png)

It's nothing to worry about, it's just a bug that's been in this version of Drupal for years. It's completely harmless, if not a bit odd looking.

Further down the page is where you can set your admin details. Make sure to write this information down because there is no way of getting it back once you've finished this page.

![Configure Site](media/configure-site.png)

| Label                | Input                 | 
| -------------------- | --------------------- |
| Site name            | My DKAN Website       |
| Site e-mail address  | dkan@example.com      |
| Username             | admin                 |
| E-mail address       | admin@example.com     |
| Password             | su93r_5ecure!p@55w0rd |
| Confirm password     | su93r_5ecure!p@55w0rd |
| Default country      | Select your country   |
| Default time zone    | Select your timezone  |
| Check for updates automatically | Recommended |
| Check for updates automatically | Recommended |

### *DKAN final setup tasks*
DKAN and Drupal will now run their final tasks to install everything.

![DKAN Final Setup Tasks](media/dkan-final-setup-tasks.png)

Once everything's finished you'll see a congratulatory message telling you everything finished. Click on the link to **Visit your new site.**

<a name="your-dkan-site"></a>
## Your DKAN Site
You should now have a fresh installation of DKAN on your server! Now all you have to do is add your data!

![DKAN Default Homepage](media/dkan-default-homepage.png)

Next we'll discuss creating a [backup and restore procedure]().