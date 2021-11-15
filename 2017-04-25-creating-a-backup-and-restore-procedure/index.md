---
title: Creating a Backup and Restore Procedure
description: We're going to quickly run through how to set up a backup and restore procedure for your DKAN installation.
date: 2017-04-25
---

This is essentially just a cheatsheet for myself, but it might come in handy for someone else one day. Good luck!

## Prerequisites

### Composer

1. SSH into your server.
2. Run `sudo apt-get install composer`.

### PIP

1. Run the following commands:

    ```shell
    sudo apt-get install python-pip python-dev build-essential -y
    sudo pip install --upgrade pip
    sudo pip install --upgrade virtualenv
    ```

## Downloading the Scripts

1. SSH into your server.
1. Change directory into your DKAN installation: `cd /var/www/html`
1. Clone the [GitHub repository](https://github.com/mohnjatthews/dkan-backup-and-restore): `git clone https://github.com/mohnjatthews/dkan-backup-and-restore.git`

## Installing the Scripts

These instructions can be found on the [GitHub repo home page](https://github.com/mohnjatthews/dkan-backup-and-restore#installation), and inside `README.md`.

1. Run `cd dkan_backup_procedure` to move into the repo folder.
2. Run `cp .env-example .env` to copy and rename `.env-example` to `.env`.
3. Edit the `.env` file to relfect the details of the server you are connected to:

    ```shell
    username_mysql="SUPER_FUN_MYSQL_USERNAME"
    password_mysql"INCREDIBLY_SECURE_MYSQL_PASSWORD"
    database_mysql="STANDARD_DATABASE_NAME"
    dkan_environment="DEV"
    backup_storage_directory="BACKUP_FILE_LOCATION/"
    ```

1. Run `composer install` to install all the PHP dependencies.
1. Install [pip](//pypi.python.org/pypi/pip) by running the following:

    ```shell
    sudo apt-get install python-pip python-dev build-essential -y
    sudo pip install --upgrade pip
    sudo pip install --upgrade virtualenv
    ```

1. Install AWS CLI by running `pip install awscli --upgrade --user`
1. Add the following line into `~/.bashrc`:

    ```shell
    export PATH=~/.local/bin:$PATH
    ```

1. Run `source ~/.bashrc`
1. Run `aws configure` and fill out the form, inputting the correct credentials into each section.

    ```shell
    AWS Access KEY ID [None]: PASTE_KEY_HERE
    AWS Secret Access Key [None]: PASTE_KEY_HERE
    Default region name [None]: eu-west-1
    Default output format [None]: json
    ```
