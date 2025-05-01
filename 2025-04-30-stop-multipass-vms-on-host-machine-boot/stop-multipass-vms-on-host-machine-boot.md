---
title: "Stop Multipass VMs on Host-Machine Boot"
description: "This guide will help you set up a script that automatically stops all running Multipass VMs when your MacBook starts up. The idea here is to help conserve battery life when you're working away from a power source."
date: 2025-04-30
---

## Create the script

1. First, create a location to save this script:

  ```
  mkdir -p ~/Scripts
  ```

1. Create a file called `stop_multipass_vms.sh` and enter the following lines of code:

  ```shell
  #!/bin/bash
  
  # Description: Stop all running Multipass VMs on user login.
  # Author: https://github.com/johnnymatthews
  
  # Setup logging
  # -------------
  LOGFILE="${HOME}/Library/Logs/multipass_vm_stop.log"
  
  # Function to log messages.
  log_message() {
    echo "$(date): $1" >> "$LOGFILE"
  }
  
  # Create log directory if it doesn't exist.
  mkdir -p "$(dirname "$LOGFILE")"
  
  # Set restrictive permissions on the log file.
  chmod 600 $LOGFILE
  
  log_message "Script started..."
  # -------------
  
  
  
  # Verify script matches existing hash.
  # ------------------------------------
  if ! echo "$(cat ~/Scripts/stop_multipass_vms.checksum)" | shasum -a 256 -c - >/dev/null 2>&1; then
  log_message "Script integrity check failed!"
  exit 1
  fi
  # ------------------------------------
  
  
  # Continue with script.
  # ---------------------
  # Give the system a moment to fully initialize.
  sleep 3
  
  # Check for common Multipass installation locations.
  MULTIPASS_PATHS=(
      "/usr/local/bin/multipass"
      "/opt/homebrew/bin/multipass"
      "/usr/bin/multipass"
      "${HOME}/.local/bin/multipass"
      )
  
  MULTIPASS_CMD=""
  for path in "${MULTIPASS_PATHS[@]}"; do
  if [ -x "$path" ]; then
  MULTIPASS_CMD="$path"
  break
  fi
  done
  
  # If multipass wasn't found in the common locations, try using PATH.
  if [ -z "$MULTIPASS_CMD" ]; then
  if command -v multipass &> /dev/null; then
  MULTIPASS_CMD="multipass"
  else
  log_message "Multipass not found, exiting."
  exit 0
  fi
  fi
  
  log_message "Using Multipass at: $MULTIPASS_CMD"
  log_message "Stopping all VMs..."
  
  # Stop all the VMs within Multipass.
  $MULTIPASS_CMD stop --all
  # ---------------------
  
  
  
  # Finish script.
  # --------------
  log_message "Done!"
  exit 0
  # --------------
  ```

1. Make the script executable:

  ```shell
  chmod +x ~/Scripts/stop_multipass_vms.sh
  ```

## 2. Create the LaunchAgent config

1. In the `~/Library/LaunchAgents` directory, create a file called `com.user.multipass.stop.plist` with the following content:

  ```shell
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
  <dict>
      <key>Label</key>
      <string>com.user.multipass.stop</string>
      <key>ProgramArguments</key>
      <array>
          <string>/bin/bash</string>
          <string>/Users/johnny/Scripts/stop_multipass_vms.sh</string>
      </array>
      <key>EnvironmentVariables</key>
      <dict>
          <key>PATH</key>
          <string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin</string>
      </dict>
      <key>RunAtLoad</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>/tmp/multipass.stop.err</string>
      <key>StandardOutPath</key>
      <string>/tmp/multipass.stop.out</string>
  </dict>
  </plist>
  ```

1. Double-check that line 10 contains the full path to your script:

  ```shell
  [...]
  <string>/Users/johnny/Scripts/stop_multipass_vms.sh</string>
  [...]
  ```

## Load the LaunchAgent

1. Load the LaunchAgent to activate it:

  ```bash
  launchctl load ~/Scripts/com.user.multipass.stop.plist
  ```

  There is no output from this command.

## Testing the Script

1. To test the script without restarting:

  ```bash
  bash ~/Scripts/stop_multipass_vms.sh
  ```

  This command will only output something when it errors.

1. You can check the log file to see what happened:

```bash
cat ~/Library/Logs/multipass_vm_stop.log
```

```output
Wed 30 Apr 2025 16:00:45 ADT: Script started...
Wed 30 Apr 2025 16:00:48 ADT: Using Multipass at: /usr/local/bin/multipass
Wed 30 Apr 2025 16:00:48 ADT: Stopping all VMs...
Wed 30 Apr 2025 16:00:49 ADT: Done!
```

## How It Works

1. The script runs when log into your user account.
1. The script checks if Multipass is installed.
1. If Multipass is available, is shutdown all VMs.

## Troubleshooting

- If the script doesn't run on boot, check the error logs:

```shell
cat /tmp/multipass.stop.err
cat /tmp/multipass.stop.out
```

- You can manually unload and reload the LaunchAgent if needed:

```shell
launchctl unload ~/Library/LaunchAgents/com.user.multipass.stop.plist
launchctl load ~/Library/LaunchAgents/com.user.multipass.stop.plist
```

## Uninstallation

If you decide you no longer want this script:

```shell
launchctl unload ~/Library/LaunchAgents/com.user.multipass.stop.plist
rm ~/Library/LaunchAgents/com.user.multipass.stop.plist
rm ~/Scripts/stop_multipass_vms.sh
```
