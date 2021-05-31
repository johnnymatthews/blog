---
title: Create a new virtual desktop in MacOS.
description: MacOS has the ability to create multiple virtual desktops. I find this feature super handy because it allows me to have separate desktops for separate pieces of work. Annoying, Apple doesn't include a built-in hot-key to create a new desktop. However, with the use of Albert, we can create a script to create a new desktop for us!
date: 2021-05-31
---

1. Install Alfred.
1. Buy the pro version.
1. Select **Workflows** and create a blank workflow.
1. Enter the following info:

    | Field | Value |
    | --- | --- |
    | Name | Create a new desktop. |
    | Description | Creates a new virtual desktop using a script. |
    | Category | Productivity |

    ![Create a workflow screen.](media/2021-05-31-create-a-new-virtual-desktop-in-mac-os/create-a-workflow-screen.png)

1. Click **Create**.
1. Right-click in the workflow panel and select **Input** > **Keyword**.

    ![Select input > keyword.](media/2021-05-31-create-a-new-virtual-desktop-in-mac-os/select-input-keyword.png)

1. Enter the following information:

    | Field | Value |
    | --- | --- |
    | Keyword | desktop |
    | Arguments dropdown | No arguments |
    | Title | Desktop |
    | Subtitle | Creates a virtual desktop. |

    ![Create a keyword.](media/2021-05-31-create-a-new-virtual-desktop-in-mac-os/create-a-keyword.png)

1. Right click the block that was just created and select **Insert after** > **Actions** > **Run script**. 

    ![Select Insert after > Actions > Run script.](media/2021-05-31-create-a-new-virtual-desktop-in-mac-os/select-run-script.png)

1. Set the **Language** to **osascript (AS)**.
1. Leave **with input as argv** and running instance **sequentially** as their defaults.
1. Paste the following code into the textbox:

    ```applescript
    #!/usr/bin/osascript
    tell application "System Events"
      do shell script "/System/Applications/Mission\\ Control.app/Contents/MacOS/Mission\\ Control"
      click button 1 of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"
      do shell script "/System/Applications/Mission\\ Control.app/Contents/MacOS/Mission\\ Control"
    end tell
    ```

1. Click **Save**.
1. Open Alfred and search for `desktop`.

    ![Search for desktop.](media/2021-05-31-create-a-new-virtual-desktop-in-mac-os/search-for-desktop.png)

1. That's it!

Now, every time you search for `desktop` in Alfred, MacOS should create a new desktop for you! You could also follow the steps above to create a script to _delete_ an open desktop if you were so inclined.

