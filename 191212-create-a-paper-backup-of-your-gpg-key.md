---
title: Create a paper backup of your GPG key
description: Having a paper backup of your keys is a great way to make sure you don't lose them. Yeah, you can store them on digital media like a USB stick or a CD, but there is a chance that the data could get borked. Create a paper copy and store it somewhere safe.
date: 2019-12-12
---

Having a paper backup of your keys is a great way to make sure you don't lose them. Yeah, you can store them on digital media like a USB stick or a CD, but there is a chance that the data could get borked. Create a paper copy and store it somewhere safe.

This guide is for macOS users. If you're running Linux, the steps should be similar, but you'll have to use whichever package manager comes with your distribution since Homebrew is macOS specific. Windows users should install Paperkey using the [precompiled binaries](https://www.jabberwocky.com/software/paperkey/).

### Install Paperkey

You need Paperkey installed to both export and import a paper-based key.

1. Install [Paperkey](https://www.jabberwocky.com/software/paperkey/) through [Homebrew](https://brew.sh/):

    ```bash
    brew install paperkey
    ```

1. Check that you've got Paperkey installed correctly:

    ```bash
    paperkey --version

    > paperkey 1.6 (darwin18.6.0)
    > Copyright (C) 2007, 2008, 2009, 2012, 2013, 2016, 2017, 2018 David Shaw <dshaw@jabberwocky.com>
    > This is free software. You may redistribute copies of it under the terms of
    > the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
    > There is NO WARRANTY, to the extent permitted by law.
    ```

### Export a key

1. List your available secret GPG keys:

    ```bash
    gpg --list-secret-keys

    > /Users/johnny/.gnupg/pubring.kbx
    > --------------------------------
    > sec rsa4096 2019-12-12 [SC]
    > E363354FA81A5AF9334F02EBD6304AF502D93919
    > uid [ultimate] John Smith <john@smith.com>
    > ssb rsa4096 2019-12-12 [E]
    ```

1. Export your key and _pipe_ `|` the result to the Paperkey `--output` command, replacing the `E36335...` _uid_ below with your own. Enter the password for the key.

    ```bash
    gpg --export-secret-key E363354FA81A5AF9334F02EBD6304AF502D93919 | paperkey --output paperkey.txt

    > lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk
    > x Please enter the passphrase to export the OpenPGP secret key: x
    > x "John Smith <john@smith.com>" x
    > x 4096-bit RSA key, ID D6304AF502D93919, x
    > x created 2019-12-12. x
    > x x
    > x x
    > x Passphrase: _______________________________________________________________ x
    > x x
    > x <OK> <Cancel> x
    > mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj
    ```

1. Your secret key is now in `paperkey.txt`. It should look something like this:

    ```bash
    cat paperkey.txt

    > # Secret portions of key E363354FA81A5AF9334F02EBD6304AF502D93919
    > # Base16 data extracted Thu Dec 12 14:44:00 2019
    > # Created with paperkey 1.6 by David Shaw
    > #
    > # File format:
    > # a) 1 octet: Version of the paperkey format (currently 0).
    > # b) 1 octet: OpenPGP key or subkey version (currently 4)
    > # c) n octets: Key fingerprint (20 octets for a version 4 key or subkey)
    > # d) 2 octets: 16-bit big endian length of the following secret data
    > # e) n octets: Secret data: a partial OpenPGP secret key or subkey packet as
    > # specified in RFC 4880, starting with the string-to-key usage
    > # octet and continuing until the end of the packet.
    > # Repeat fields b through e as needed to cover all subkeys.
    > #
    > # To recover a secret key without using the paperkey program, use the
    > # key fingerprint to match an existing public key packet with the
    > # corresponding secret data from the paper key. Next, append this secret
    > # data to the public key packet. Finally, switch the public key packet tag
    > # from 6 to 5 (14 to 7 for subkeys). This will recreate the original secret
    > # key or secret subkey packet. Repeat as needed for all public key or subkey
    > # packets in the public key. All other packets (user IDs, signatures, etc.)
    > # may simply be copied from the public key.
    > #
    > # Each base16 line ends with a CRC-24 of that line.
    > # The entire block of data ends with a CRC-24 of the entire block of data.
    >
    > 1: 00 04 E3 63 35 4F A8 1A 5A F9 33 4F 02 EB D6 30 4A F5 02 D9 39 19 494042
    > 2: 05 39 FE 07 03 02 A8 D4 41 26 21 29 93 F4 E7 59 2F C4 8B E3 22 C3 E5C919
    > 3: 0A BE 63 AC 1D CA 06 B6 43 FF F5 E5 69 B3 7C FF B4 24 E3 6B 3C DD 3BEEE4
    ...
    > 123: 07 70 93 42 01 1D 9F 08 5E 25 EF 15 C5 39 50 D5 2F 24 68 EA F3 52 088714
    > 124: B3 EF C9 83 74 E4 3F 4B 44 6A 83 25 10 50 74 6CDF7A
    > 125: 5494FC
    ```

1. Print the `paperkey.txt` file and put it somewhere super safe.

#### Use a QR Code

If you'd prefer to import and export your key to a QR code, then you can use [QREncode](https://formulae.brew.sh/formula/qrencode). Make sure the application you'll use to import the secret key accepts this type of QR code. Not all QR readers are created equal.

1. Install Qrencode:

    ```bash
    brew install qrencode
    ```

1. Double-check that it's installed properly:

    ```bash
    qrencode --version

    > qrencode version 4.0.2
    > Copyright (C) 2006-2017 Kentaro Fukuchi
    ```

1. Export your secret GPG key, pipe `|` the result to Paperkey, and then pipe _that_ result to Qrencode. The program will create a QR code image in `secret-key.qr.png`.

    ```bash
    gpg --export-secret-key E363354FA81A5AF9334F02EBD6304AF502D93919 | paperkey --output-type raw | qrencode --8bit --output secret-key.qr.png
    ```

1. Go ahead and print the `secret-key.qr.png` file.

#### Public Key

When importing the secret key, you need to have your public key available. Since it's safe to expose your public key, you can store this on a key-server. You can also print out your public key. Unfortunately, Paperkey doesn't support exporting your public key to a human-readable format, so you'll have to print out the key verbatim.

1. List your secret keys:

    ```bash
    gpg --list-keys

    > /Users/johnny/.gnupg/pubring.kbx
    > --------------------------------
    > pub rsa4096 2019-12-12 [SC]
    > E363354FA81A5AF9334F02EBD6304AF502D93919
    > uid [ultimate] John Smith <john@smith.com>
    > sub rsa4096 2019-12-12 [E]
    ```

1. Export your public key, changing `E3633...` for your key's ID:

    ```bash
    gpg --armor --output public-key.txt --export E363354FA81A5AF9334F02EBD6304AF502D93919
    cat public-key.txt

    > -----BEGIN PGP PUBLIC KEY BLOCK-----
    >
    > mQINBF3yl78BEAC1d3hAbfTWxnEWMs79OUGHFMgTGxMX+Rf/ZuD9jqvKV4R5/oQJ
    > XlCNYMVv2uBKFo0rFaJN2uxpQ613dXfhNFkD9VylXrsjpOR/foUOjwkzMrbL7DBa
    > myuaXrkXxZl03FZ52wenYcm1aVvTIrGGewUaGjP2b+5aMdwqXysXywFzPDgtuofQ
    > ...
    > CAPaZTUQOAKscWVdi17GKIwb/1fk9SB2wDbl8EMClwzaRYXj0xOJTa1DpDnqThH2
    > 3/cN47LZOTJxOvKPLj41cvjMqxAuEVRQ8XcpUeD5OWtZf4y+
    > =9OBm
    > -----END PGP PUBLIC KEY BLOCK-----
    ```

1. You can now go ahead and print the `public-key.txt` file.

### Import a key

So you've got your keys on paper. Now you need to import it.

1. Type out the entire contents of your public key into a file called `public-key.txt`.
1. _Dearmor_ the key:

    ```bash
    gpg --dearmor public-key.txt
    ```

1. Type out the entire contents of your secret key into a file called `secret-key.txt`.
1. Use Paperkey to parse your `secret-key.txt` file and _pipe_ `|` the result to the `gpg --import` command:

    ```bash
    paperkey --pubring public-key.txt.gpg --secrets secret-key.txt | gpg --import

    > gpg: key D6304AF502D93919: public key "John Smith <john@smith.com>" imported
    > gpg: Total number processed: 0
    > gpg: imported: 1
    > gpg: secret keys read: 1
    ```

1. Your secret key should now be imported!
1. Lastly, delete the `secret-key.txt` file:

    ```bash
    echo "This file has been deleted." > secret-key.txt && rm secret-key.txt
    ```

 This command overwrites the `secret-key.txt` file and deletes it. The file does not go into the _Trash_. This method is by no means to most secure way to delete a file, but it's better than just throwing it in the _Trash_. A motivated attacker could still be able to retrieve your secret key if they had access to your computer.

And there you have it! That's all you need to do to create a paper backup of your GPG keys. Make sure to store your paper backups is a secure place like a lockbox or a safe. It's also a good idea to make two backups and store them in different places, and use the [321 backup strategy](https://en.wikipedia.org/wiki/Backup#Storage).
