---
title: Terminal Based Password Manager
description: Password managers are great. Services like Lastpass, 1Password, and Dashlane are a great jumping off point for improving your online security.  It's just that they're not the end-all be-all of password management, and they suffer from a lot of the vulnerabilities that other onlines services do.
date: 2019-07-22
---

In 2017 there was a bug in the Lastpass browser plugin that [exposed passwords in plain text](https://www.engadget.com/2017/03/22/critical-exploits-found-in-lastpass-on-chrome-firefox/). Stuff like this is super bad, and can be exploited by attackers to get access to all your stuff.

So today we're going to walk through [Pass: the Unix Password Manager](https://www.passwordstore.org/). Essentially, Pass does all the same things that Lastpass and 1Password and Dashlane do, but locally on your machine. Your passwords are encrypted using a GPG key and stored in a repository. Only instead of an online service holding all your data, you're in charge of it.

## Setup

We're going to install the Pass program, setup a GPG key pair to use, and then setup a create repository to store everything in. Once that's done, we can walk through how to use Pass on a day-to-day basis.

### Install Pass

If you're using Ubuntu run:

```bash
sudo apt install pass haveged ruby -y
```

If you're running MacOS, you'll need to have the [Brew Package Manager](https://brew.sh/) installed first. Once you've got that installed run:

```bash
brew install pass
```

You should now have Pass installed. Run `pass --version`. You should see something like this:

```bash
pass --version

> ============================================
> = pass: the standard unix password manager =
> =                                          =
> =                  v1.6.5                  =
> =                                          =
> =             Jason A. Donenfeld           =
> =               Jason@zx2c4.com            =
> =                                          =
> =      http://www.passwordstore.org/       =
> ============================================
```

### Create a GPG Key

The GPG key is what encrypts your passwords and keeps them safe. You need to have access to your GPG key in order to read any of your passwords.

1\. Start the key generation:

```bash
gpg --gen-key

> gpg (GnuPG) 1.4.20; Copyright (C) 2015 Free Software Foundation, Inc.
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
…
```

2\. Select the `RSA and RSA (default)` option:

```bash
> Please select what kind of key you want:
>    (1) RSA and RSA (default)
>    (2) DSA and Elgamal
>    (3) DSA (sign only)
>    (4) RSA (sign only)
> Your selection?

1
```

3\. Set the key size to 4096:

```bash
> RSA keys may be between 1024 and 4096 bits long.
> What keysize do you want? (2048):

4096
```

4\. Set when you want the key to expire. While having a key that doesn't expire is convienent, it's insecure. You're best off selecting 1 month:

```bash
> Please specify how long the key should be valid.
>          0 = key does not expire
>       <n>  = key expires in n days
>       <n>w = key expires in n weeks
>       <n>m = key expires in n months
>       <n>y = key expires in n years

1m
```

It'll ask you to confirm that the expiration date is correct:

```bash
> Key expires at Mon 05 Aug 2019 03:12:25 PM UTC
> Is this correct? (y/N)

y
```

5\. Next up is to add your details into the key. This gets handy when you have more than one key on your system and you need to keep track of which one's which:

```bash
> Real name: Johnny
> Email address: johnny@email.com
> Comment: Key for Unix Pass
> You selected this USER-ID:
>     "Johnny (Key for Unix Pass) <johnny@email.com>"
```

6\. Enter `O` to select that everything's okay:

```bash
> Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit?
O
```

7\. The last thing you've got to do is enter a strong password to protect your key. This way, if anyone steals you key, they can't use it without this password. Make sure to remember this as you'll need to enter it everytime you want to view or edit a password.

8\. After a few seconds you should see something like the following:

```bash
> gpg: key CA987727 marked as ultimately trusted
> public and secret key created and signed.
>
> gpg: checking the trustdb
> gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
> gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
> gpg: next trustdb check due at 2019-08-05
> pub   4096R/CA987727 2019-07-06 [expires: 2019-08-05]
>       Key fingerprint = 027E 5752 0AF7 C0B5 5E89  59B3 F873 743F CA98 7727
> uid                  Johnny (Unix Pass Manager) <johnny@email.com>
> sub   4096R/05750380 2019-07-06 [expires: 2019-08-05]
```

So that's your GPG key sorted, keep it safe! You won't be able to access your passwords without it.

### Initialize your Password Store

This step creates a blank database for you to store your passwords in. To initialize your password store, you'll need the name you gave to your GPG key. I used _Johnny_ in the example above.

```bash
pass init Johnny

> mkdir: created directory '/home/johnny/.password-store/'
> Password store initialized for Johnny
```

Pass will make a new directory `~/.password-store` and put your passwords in there.

### Setup GitHub Repository

Now that you've got your GPG key created and ready to use, we're going to create a private repository on GitHub to store your keys. This step is option, but incredibly useful if you plan on using your password manager on multiple devices.

1\. Go to [GitHub.com](https://github.com/) and create a new **private** repository.

2\. Copy the repository URL to your clipboard.

3\. Back in the terminal, add your GitHub repo to your password store:

```bash
pass git init

> Initialized empty Git repository in /home/vagrant/.password-store/.git/
```

4\. Tell Git and Pass where your repository is stored by running this command and adding your repository's URL onto the end:

```bash
pass git remote add origin YOUR_GIT_URL
```

For example:

```bash
pass git remote add origin https://github.com/johnny/passwordstore
```

Your password store is now linked to that repository. You can run Git commands within Pass by adding `pass` to the start of the command. We'll go into this a bit more later.

## Manage your Passwords

So you've got your password manager setup, but how do you use it? It might help to understand how Pass actually manages your passwords. Each password is defined as a single file, and all those files live within the default `password-store` folder. On Ubuntu and MacOS this is `~/.password-store`.

Because all the passwords are stored in files, they can be organized into folders for easier management. I like to keep my work life and personal life separate, so I have a password folder for work and one for personal things:

```bash
tree ~/.password-store

> ~/password-store
> ├── personal
> └── work
```

At the moment I don't have any passwords stored in Pass, so let's add one.

### Add Password

1\. Create a new password for GitHub:

```bash
pass add personal/github
```

2\. Pass will ask you to enter the password twice.

```bash
> Enter password for personal/github:
> Retype password for personal/github:
```

3\. You now have a password stored in Pass! You can see it by listing all the passwords in your password store with the `pass` command:

```bash
pass

> Password Store
> └── personal
>     └── github
```

Pass can create passwords for you too, so you don't have to think of a hard-to-crack password every time!

```bash
pass generate personal/github 18

The generated password for personal/github is:
UWR9F$2Q"3E,l2={xG
```

The number at the end of the command is the length of the password. You can supply a bunch of arguments to the `generate` command. Here's a couple of helpful ones:

| Argument | Function | Example |
| -------- | -------- | ------- |
| `-c` | Copy the password to your clipboard once it's been created. | `pass generate -c personal/github 18` |
| `-n` | Create a password using only alpha-numeric characters | `pass generate -n personal/github 18` |

### View Password

To view a password, simply call the location of the password file with the `pass` command:

```bash
pass personal/github

> UWR9F$2Q"3E,l2={xG
```

If you just want to copy your password straight to your clipboard without it showing in the terminal, add the `-c` argument.

```bash
pass -c personal/github
```

### Edit Password

If you need to edit a password file, call the `edit` command, followed by the file you want to edit:

```bash
pass edit personal/github
```

The first time you try to edit a file, Pass will likely ask you which text editor you want to use. I use Vim because I hate myself, but you can use whatever you want. Except Emacs. Never use Emacs.

When editing your file, keep in mind that your password should **always be stored at the very top of the file**. This is because the `pass -c` command will always copy the first line. You can add any other information to the file, such as your username or the URL of a website below the first line.

### Delete Password

If you have decided you no longer need a password, run the `delete` command and select the password or folder you want to delete:

```bash
pass delete personal/github

> Are you sure you would like to delete personal/github? [y/N]

Y

> removed '/home/vagrant/.password-store/personal/github.gpg'
> [master ac89faa] Remove personal/github from store.
> 1 file changed, 0 insertions(+), 0 deletions(-)
> delete mode 100644 personal/github.gpg
```

You can also delete the file directly with the `rm` command:

```bash
rm ~/.password-store/personal/github
```

Using the integerated `pass delete` command is safer however, since there is less chance that you will corrupt your password store.

### Import from LastPass

Many people use LastPass as their password manager. Luckily, some of the Unix Pass community have create a migration tool to help you import everything into a Unix Pass.

First up, you need to export your LastPass password library:

1\. Go to LastPass.com and login.

2\. Click **More Options** at the bottom left.

3\. Click **Advanced** > **Export**.

4\. Enter your password again.

5\. Copy the text and save it as a `.csv` file somewhere on your computer, preferably your `Downloads` folder.

Now that you've downloaded all your passwords, we can import them using a script.

6\. Download the script to your root `~` folder:

```bash
cd ~/
wget https://git.zx2c4.com/password-store/plain/contrib/importers/lastpass2pass.rb
```

7\. Call the script, and enter the destination of your LastPass export file as an argument:

```bash
./lastpass2pass.rb path/to/passwords_file.csv
```

For example:

```bash
./lastpass2pass.rb ~/Downloads/passwords_from_lastpass.csv
```

8\. The script should output something like this:

```bash
Reading '/home/johnny/Downloads/passwords_from_lastpass.csv'...
6 records found!
Records parsed: 6
...
done!
6 records successfully imported!
```

You should be able to view all those records within `Pass`

### Importing from other Password Managers

There are several guides for importing data from other password managers listed on the [Unix Pass website](https://www.passwordstore.org/).
