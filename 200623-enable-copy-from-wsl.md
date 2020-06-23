# Unix Pass on Windows Subsystem for Linux

## Run Ubuntu

1. Install Ubuntu for Windows from the Microsoft Store.
1. Install Ubuntu 20.02 from the Microsoft Store.
1. Open Ubuntu from the start menu.
1. Open Ubuntu 20.02 from the start menu. It will begin installing, and will take a few minutes.

## Get VcXsrv

1. Download and install [VcXsrv](https://sourceforge.net/projects/vcxsrv/files/vcxsrv/1.20.6.0/vcxsrv-64.1.20.6.0.installer.exe/download?use_mirror=astuteinternet&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fvcxsrv%2F&use_mirror=astuteinternet#).

1. Create a file called `config.xlaunch`:

	```xml
	<?xml version="1.0" encoding="UTF-8"?>
	<XLaunch WindowMode="MultiWindow" ClientMode="NoClient" LocalClient="False" Display="-1" LocalProgram="xcalc" RemoteProgram="xterm" RemotePassword="" PrivateKey="" RemoteHost="" RemoteUser="" XDMCPHost="" XDMCPBroadcast="False" XDMCPIndirect="False" Clipboard="True" ClipboardPrimary="True" ExtraParams="" Wgl="True" DisableAC="False" XDMCPTerminate="False"/>
	```

1. After saving the file, double click it to run the application.
1. Add `export DISPLAY=localhost:0.0` to the end of WSL's `~/.bashrc`:

	```bash
	echo "export DISPLAY=localhost:0.0" >> ~/.bashrc
	```

1. Enable the Vim clipboard:

	```bash
	sudo apt install vim-gtk
	```

1. Check that it got installed properly:

	```bash
	vim --version | grep clipboard

	> +clipboard
	```

1. POTENTIALLY IMPORTANT STEP. Run as Admim in Powershell:

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    ```

## CHMOD the GPG keys

1. The `~/.gnupg` folder should be `700`:

    ```bash
    chmod 700 ~/.gnupg
    ```

1. All the files inside should be `600`;

    ```bash
    cd ~/.gnupg
    chmod 600 *
    ```

1. Check that you didn't just change any folders within `~/.gnupu` to `600`. If you did, change them back to `700`.

    ```bash
    ls -la
    
    > ...
    >
    > drwx------ 2 johnny 4096 Jun  6 22:49 private-keys-v1.d
    >
    > ...

    chmod 700 private-keys-v1.d
    ```

## Install Pass

1. `sudo apt update`
1. `sudo apt install pass -y`

### Install pass-update

1. `git clone https://github.com/roddhjav/pass-update/`
1. `cd pass-update`
1. `sudo apt-get install build-essential`
1. `sudo make install  # For OSX: make install PREFIX=/usr/local`

### Install pass-otp
1. `git clone https://github.com/tadfisher/pass-otp`
1. `cd pass-otp	`
1. `sudo make install`

## Powershell 7

1. Go to the [Releases page](https://github.com/PowerShell/PowerShell/releases) and download the latest Powershell 7 release. You're looking for an `-x64.msi` file.
1. Install the `.msi`.