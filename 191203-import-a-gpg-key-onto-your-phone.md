# Import a GPG key onto your phone

1. On your phone, install [OpenKeychain](https://www.openkeychain.org/)
2. On your computer run `gpg --list-secret-keys` to find out what keys you have available:

	```bash
	$ gpg --list-secret-keys
	/Users/johnny/.gnupg/pubring.kbx
	--------------------------------
	sec   rsa4096 2019-11-25 [SC]
	      A717D3E342CA94F3E04A51D4E2E4A167B1B617FE
	uid           [ultimate] Johnny
	ssb   rsa4096 2019-11-25 [E]
	```

3. Export the key to the current directory:

	```bash
	gpg --export-secret-keys $ID > my-private-key.asc
	```

4. Transfer the `my-private-key.asc` file to your phone. This file isn't encrypted, so make sure you trust the transfer method.
5. On your phone open the OpenKeychain app.
6. Press the `+` button and select **Import from File**.
7. Select the folder icon and navigate to the `my-private-key.asc` file you transferred to your phone in step 4.
8. Select **Import**. The key should now be imported.