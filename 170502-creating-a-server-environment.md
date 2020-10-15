---
title: Create a Server Environment for DKAN
description: DKAN is an open-source tool for managing and displaying large public data sets like census data, or weather patterns. This post runs through how to set up DKAN on a LAMP stack.
date: 2017-05-02
---

## Creating the Server Environment

We're going to walkthrough how to set up a LAMP stack from scratch, install further dependencies for DKAN, and set everything up for actually installing the platform.

### Choosing your Server

The vast majority of the web is contained in third-party servers from companies like, Amazon, DigitalOcean, and Google. For a relativly low cost you can *spin-up* a virtual server inside one of their [massive data warehouses](https://www.youtube.com/watch?v=XZmGGAbHqa0). For most of my projects I use [DigitalOcean](https://m.do.co/c/ed12e702f869), mainly because their' VMs are easy to set up, the user interface on their site is nice and simple, and it's only $5 a month for simple server. [Amazon](https://amazonlightsail.com/pricing/) and [Google](https://cloud.google.com/) also have a similar products for around the same price, but I like to stick with DigitalOcean (they've been doing this sort of thing for ages, and they always look out for little developers).

#### Using your own Hardware

Saying all that, feel free to set up your own server in-house. I won't be walking through how to install any of the physical hardware (you'll have to do that on your own), but the rest of the steps will be pretty much the same.

### Installing a LAMP Stack

A LAMP stack is a group of open-source software (**L**inux, **A**pache, **M**ySQL, **P**HP) that all work together to make an excellent web server. LAMP is the default server configuration for about [50% of the internet](https://w3techs.com/technologies/details/ws-apache/all/all), but that is decreasing over time with the rise of LEMP stacks (I'll get into LEMP in another post). We'll be using Ubuntu 16.04, Apache2, MySQL, and PHP7 for our stack.

#### Manual Install

This section closely follows the guide created by [Brennen Bearnes](https://www.digitalocean.com/community/users/bpb) over at [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04), with a few personalisation changes along the way.

This guide assumes you have your user accounts and firewall already set up. I won't go into details on how to do this, but you can follow [this guide by DigitalOcean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04).

##### Apache

1. SSH into your server.
2. Update the available packages on your system, and install `apache2`:

    ```bash
    sudo apt-get update
    sudo apt-get install apache2
    ```

**Tip:** When running certain commands (like `install` or `remove`), Ubuntu will ask you to confirm the installation. So if nothing much is happening in the terminal, just check that you've confirmed by entering `y`.

3. Run `sudo ufw allow in "Apache Full"` to adjust the firewall to all web traffic.

```bash
dkan@server:~$ sudo ufw allow in "Apache Full"
[sudo] password for dkan:
Rules updated
Rules updated (v6)
```

4. You should now be able to view the default apache web page by visiting your server address: `http://your_server_ip_address`

![Default Apache page](media/default-apache-page.png)

5. If you don't know what your IP address is run:

```bash
sudo apt-get install curl
curl http://icanhazip.com
```

It should output the IP address of your server:

```bash
dkan@server:~$ curl http://icanhazip.com
138.68.158.46
```

So that's the Apache service installed. Now let's get MySQL sorted.

##### MySQL

If you don't already know, MySQL is the database system that DKAN is going to run on. While you don't have to be fluent in MySQL to run DKAN, knowing a few basic commands can prove useful. I'd suggest taking a look at [W3Schools' SQL tutorials](https://www.w3schools.com/sql/default.asp) when you get a chance.

1. Download and run the installer

```bash
sudo apt-get install mysql-server
mysql_secure_installation
```

2. Enter a password for your root MySQL account. I recommend using a password manager to generate and store your passwords.
1. Enter `n` when asked if you want to install the `VALIDATE PASSWORD PLUGIN`.
1. Enter `n` when asked if you want to change the root MySQL password.
4. Enter `y` for the rest of the questions.

```bash
dkan@server:~$ mysql_secure_installation

Securing the MySQL server deployment.

Enter password for user root:

VALIDATE PASSWORD PLUGIN can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD plugin?

Press y|Y for Yes, any other key for No: n
Using existing password for root.
Change the password for root ? ((Press y|Y for Yes, any other key for No) : n

 ... skipping.
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done!
```

##### PHP

PHP: Hypertext Preprocessor is the backend language that DKAN runs off. All the login and data management is written in PHP, so I'd advise that you familiarise yourself with it's syntax at some point. Again, [W3Schools has a great tutorial](https://www.w3schools.com/php/default.asp) you can follow.

1. Install PHP and it's dependencies:

```bash
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql php-dom php-xml php-mbstring php-gd
```

2. Next we want to tell Apache to look for `.php` files before looking for .`html` files. Open `/etc/apache2/mods-enabled/dir.conf` in a text editor. I tend to use Vim, but you can use Nano or some other editor if you prefer.

```bash
sudo vim /etc/apache2/mods-enabled/dir.conf
```

3. Change the 2nd line to read:

```bash
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
```

4. Save and exit the file. If you are using Vim press `esc` and then type `:wq`, then press `enter`.
5. Run `sudo systemctl restart apache2`

That is the final step. You should now have a fully functioning LAMP stack running on your server. You can now visit your website in your browser.

#### Pre-built Stacks

DigitalOcean offer pre-built Stacks, so you can click and single button and you'll get a fully-fledged LAMP stack up and running in seconds. If you want to learn more about how to create a LAMP stack from scratch then I'd recommend not using this option. However if you don't really care about learning how to build a LAMP stack, then by all means use the pre-built option! Select **LAMP on 16.04**.

![LAMP one-click apps](media/lamp-one-click-apps.png)
