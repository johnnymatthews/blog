---
title: "Securing Windows"
description: "I'll start this off by saying that Windows is not a secure operating system. This is mostly due to the fact that it trusts the user to know what's going on. It also gives apps and features far more access to the system than it should. However, there are a few simple steps that users can take to increase their security posture."
date: 2023-08-31
---

## Create a standard user

Most folks running Windows right now are logged in as an admin. This is a problem since admins can do anything to a system -- they can install and remove programs, change the registry, edit firewall settings, and turn off security features. So, by extension, an attacker who gets access to an admin account can do whatever they want.

### Benefits of a standard account

Using a _standard account_ instead of an _admin_ account offers several security and safety benefits:

#### Reduced attack surface

Admin accounts have higher privileges, meaning any malware or malicious software that gains access to your system through your account also has those high privileges. A standard account limits the damage that malware can do by restricting its access to critical system settings.

#### Preventing unauthorized changes

With an admin account, users have the power to make significant changes to the system. This power can also be abused by malware or even by accident. A standard account limits the user's ability to make such changes, reducing the likelihood of unwanted modifications.

#### User Account Control (UAC)

Windows will often prompt you for permission before making system changes when using an admin account. This is known as _User Account Control (UAC)_. However, if you're already using a standard account, UAC prompts become more meaningful as they indicate potentially risky actions that require admin privileges.

#### Protection against social engineering

Attackers often trick users into granting administrative privileges through techniques like phishing. If you're using a standard account, the attacker won't gain the same control over your system even if you fall for such tricks.

#### Separation of privileges

The principle of _least privilege_ suggests that users should only have the minimum level of access necessary to perform their tasks. By using a standard account for everyday activities, users can adhere to this principle and enhance the security of your system.

## Hardentools

[Hardentools](https://github.com/securitywithoutborders/hardentools) is a tool designed to improve security on Microsoft Windows 10 and 11 operating systems and some widely used applications such as Microsoft Office, LibreOffice, and Adobe PDF Reader. It achieves this by disabling certain features that, while potentially useful for enterprise customers, are often exploited by attackers to execute malicious code. These features are typically unnecessary for regular users, and disabling them simply reduces the attack surface.

However, Hardentools is **not an antivirus software**. It does not block, identify, or remove any malware. It also does not prevent all risky features from being abused, nor does it prevent the changes it implements from being reverted. If malicious code runs on the system and can restore the changes, the premise of the tool is defeated.

### Install and harden

The easiest way to use Hardentools is to use the GUI:

1. Head to [GitHub and download](https://github.com/securitywithoutborders/hardentools/releases/latest) the latest `hardentools.exe` file.
1. Save the file somewhere handy. Sometimes you'll need to undo the changes that Hardentools does, so having a shortcut to the application is useful.
1. Open the `.exe` file with Admin privileges.
1. Click **Harden!**.
1. The app will take a few minutes to disable things and then check that they're _actually_ disabled.

### Un-harden

If you run into a situation where you need to revert the actions performed by Hardentools, you can undo everything by using the app.

1. Open the `hardentools.exe` app.
1. Confirm that you want to run this app as an Admin.
1. Click **Restore** and follow the on-screen prompts. 
1. Perform whatever action you need, and then re-harden your system by following the [Install and harden](#install-and-harden) steps again.
1. Done.
