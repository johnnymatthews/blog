# Access the clipboard in Windows subsystem for Linux

1. Install [Xming](https://sourceforge.net/projects/vcxsrv/files/vcxsrv/1.20.6.0/vcxsrv-64.1.20.6.0.installer.exe/download?use_mirror=astuteinternet&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fvcxsrv%2F&use_mirror=astuteinternet#).
1. Create a file called `config.xlaunch`:

	```xml
	<?xml version="1.0" encoding="UTF-8"?>
	<XLaunch WindowMode="MultiWindow" ClientMode="NoClient" LocalClient="False" Display="-1" LocalProgram="xcalc" RemoteProgram="xterm" RemotePassword="" PrivateKey="" RemoteHost="" RemoteUser="" XDMCPHost="" XDMCPBroadcast="False" XDMCPIndirect="False" Clipboard="True" ClipboardPrimary="True" ExtraParams="" Wgl="True" DisableAC="False" XDMCPTerminate="False"/>
	```

1. Add `export DISPLAY=localhost:0.0` to the end of WSL's `~/.bashrc`.
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
