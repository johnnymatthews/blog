# Access the clipboard in Windows subsystem for Linux

1. Install [Xming](https://sourceforge.net/projects/vcxsrv/files/vcxsrv/1.20.6.0/vcxsrv-64.1.20.6.0.installer.exe/download?use_mirror=astuteinternet&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fvcxsrv%2F&use_mirror=astuteinternet#).
1. Create a file called `config.xlaunch`:

	```xml
	<?xml version="1.0" encoding="UTF-8"?>
	<XLaunch WindowMode="MultiWindow" ClientMode="NoClient" LocalClient="False" Display="-1" LocalProgram="xcalc" RemoteProgram="xterm" RemotePassword="" PrivateKey="" RemoteHost="" RemoteUser="" XDMCPHost="" XDMCPBroadcast="False" XDMCPIndirect="False" Clipboard="True" ClipboardPrimary="True" ExtraParams="" Wgl="True" DisableAC="False" XDMCPTerminate="False"/>
	```

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

1. That's it!

---

## Troubleshooting

There may be an issue with using WSL 2. If you've done everything above but still can't copy to the keyboard, do this:

1. Open Powershell.
1. Check your WSL version:

	```bash
	wsl -l -v
  
  	> NAME            STATE           VERSION
	> * Ubuntu          Running         2
  	>   Ubuntu-20.04    Stopped         2
	```
	
1. WSL 2 is the problem here. Change it to version 1:

	```bash
	wsl --set-version Ubuntu 1
	```
	
1. You should now be able to copy your passwords to the clipboard:

	```bash
	pass -c password
	```
