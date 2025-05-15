---
title: "Create a pen-testing Ubuntu VM"
description: "I've found myself travelling a lot with my MacBook. While I don't mind MacOS, the nature of Apple Silicon makes it tricker to run Kail VMs than on my AMD-based PC. To get around that, I use Multipass and spin up Ubuntu VMs. Once the VM is up and running, I install all the pentesting packages that I tend to us."
date: 2025-05-15
---

All you've gotta do is download and run this script.

1. [Download the script here](./pentest-installer.sh).
1. Add the executable permission:

  ```shell
  chmod +x ./pentest-installer.sh
  ```

1. Run the script:

  ```shell
  ./pentest-installer.sh
  ```

  You'll need root permissions to run the script.

## The script

If you're rather take a look at the script before downloading it (good idea), here is it!:

```shell
#!/bin/bash

# =====================================================
# Pentest Installer for Ubuntu
# This script installs common Kali Linux security tools on Ubuntu.
# without adding the Kali repositories (to avoid conflicts).
# =====================================================

# Log file setup.
LOG_FILE="kali_tools_install_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Color codes for output.
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored messages.
print_message() {
  echo -e "${2}[$(date +"%Y-%m-%d %H:%M:%S")] $1${NC}"
}

# Function to print success messages.
success() {
  print_message "$1" "${GREEN}"
}

# Function to print warning messages.
warning() {
  print_message "$1" "${YELLOW}"
}

# Function to print error messages.
error() {
  print_message "$1" "${RED}"
}

# Function to check if a command exists.
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if running as root.
if [ "$EUID" -ne 0 ]; then
  error "Please run this script as root or with sudo."
  exit 1
fi

# Check Ubuntu version.
if ! command_exists lsb_release; then
  apt-get update && apt-get install -y lsb-release
fi

OS_VERSION=$(lsb_release -rs)
OS_NAME=$(lsb_release -is)

if [ "$OS_NAME" != "Ubuntu" ]; then
  warning "This script is designed for Ubuntu. You're running $OS_NAME $OS_VERSION. Some tools might not install correctly."
else
  success "Detected: $OS_NAME $OS_VERSION"
fi

# Function to install a package with error handling.
install_package() {
  local package_name="$1"
  success "Installing $package_name..."
  
  if apt install -y "$package_name"; then
    success "$package_name installed successfully."
  else
    error "Failed to install $package_name. Continuing with the next package."
  fi
}

# Function to install multiple packages at once.
install_packages() {
  local packages=("$@")
  local install_list=""
  
  for pkg in "${packages[@]}"; do
    if ! dpkg -l | grep -q "^ii  $pkg "; then
      install_list="$install_list $pkg"
    fi
  done
  
  if [ -n "$install_list" ]; then
    success "Installing:$install_list"
    if apt install -y $install_list; then
      success "Packages installed successfully."
    else
      error "Some packages failed to install. Check the log for details."
    fi
  else
    success "All packages already installed."
  fi
}

# Function to clone and install a GitHub repository.
install_from_github() {
  local repo_url="$1"
  local tool_name=$(basename "$repo_url" .git)
  local install_dir="/opt/$tool_name"
  
  success "Installing $tool_name from GitHub..."
  
  if [ -d "$install_dir" ]; then
    warning "$tool_name directory already exists. Updating..."
    cd "$install_dir" || return
    git pull
  else
    git clone "$repo_url" "$install_dir"
    cd "$install_dir" || return
  fi
  
  if [ -f "setup.py" ]; then
    python3 setup.py install
  elif [ -f "install.sh" ]; then
    bash install.sh
  elif [ -f "Makefile" ]; then
    make && make install
  else
    warning "No standard installation method found for $tool_name."
  fi
  
  success "$tool_name installed at $install_dir"
}

# Start installation
clear
success "====================================================="
success "     Pentest Installer"
success "     Starting installation at $(date)"
success "     Log file: $LOG_FILE"
success "====================================================="

# Update package lists and upgrade system.
success "Updating package lists and upgrading system..."
apt update && apt upgrade -y

# Install basic dependencies.
success "Installing basic dependencies..."
BASE_DEPS=("git" "python3" "python3-pip" "python3-dev" "build-essential" 
           "libssl-dev" "libffi-dev" "software-properties-common"
           "apt-transport-https" "ca-certificates" "curl" "gnupg" "wget")
install_packages "${BASE_DEPS[@]}"

# Creating directories for tools.
mkdir -p /opt/security-tools

success "===== Installing Network Security Tools ====="
NET_TOOLS=("nmap" "wireshark" "tcpdump" "netcat-openbsd" "masscan" 
           "whois" "dnsutils" "net-tools" "iputils-ping" "traceroute"
           "hping3" "arp-scan" "macchanger" "iptables" "bettercap")
install_packages "${NET_TOOLS[@]}"

success "===== Installing Wireless Security Tools ====="
WIRELESS_TOOLS=("aircrack-ng" "kismet" "wifite" "reaver" "pixiewps" "bully")
install_packages "${WIRELESS_TOOLS[@]}"

success "===== Installing Web Application Security Tools ====="
WEB_TOOLS=("nikto" "sqlmap" "dirb" "gobuster" "wpscan" "whatweb" "wfuzz")
install_packages "${WEB_TOOLS[@]}"

success "===== Installing Password and Authentication Tools ====="
PASS_TOOLS=("hydra" "john" "hashcat" "crunch" "medusa" "wordlists" "smbclient")
install_packages "${PASS_TOOLS[@]}"

success "===== Installing Forensics and Analysis Tools ====="
FORENSIC_TOOLS=("autopsy" "foremost" "binwalk" "exiftool" "steghide" "testdisk")
install_packages "${FORENSIC_TOOLS[@]}"

success "===== Installing Reconnaissance Tools ====="
RECON_TOOLS=("theharvester" "fierce" "maltego")
install_packages "${RECON_TOOLS[@]}"

success "===== Installing Utility Tools ====="
UTILITY_TOOLS=("vim" "tmux" "screen" "proxychains" "tor" "torbrowser-launcher"
              "openvpn" "python3-scapy" "terminator" "htop" "nload" "iotop")
install_packages "${UTILITY_TOOLS[@]}"

# BurpSuite.
if ! command_exists burpsuite; then
  success "Installing BurpSuite Community Edition..."
  
  # Download BurpSuite JAR file.
  BURP_DIR="/opt/burpsuite"
  mkdir -p "$BURP_DIR"
  
  if wget -q -O "$BURP_DIR/burpsuite_community.jar" "https://portswigger.net/burp/releases/download?product=community&version=latest&type=jar"; then
    # Create desktop entry
    cat > /usr/share/applications/burpsuite.desktop << EOF
[Desktop Entry]
Type=Application
Name=Burp Suite Community
Comment=Web Security Testing
Exec=java -jar $BURP_DIR/burpsuite_community.jar
Icon=burpsuite
Terminal=false
Categories=Security;
EOF
    
    # Create launcher script.
    cat > /usr/local/bin/burpsuite << EOF
#!/bin/bash
java -jar $BURP_DIR/burpsuite_community.jar "\$@"
EOF
    chmod +x /usr/local/bin/burpsuite
    success "BurpSuite Community Edition installed successfully."
  else
    error "Failed to download BurpSuite."
  fi
else
  success "BurpSuite is already installed."
fi

# Install Metasploit Framework.
if ! command_exists msfconsole; then
  success "Installing Metasploit Framework..."
  
  # Add Metasploit repository
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /tmp/msfinstall
  chmod +x /tmp/msfinstall
  /tmp/msfinstall
  
  if command_exists msfconsole; then
    success "Metasploit Framework installed successfully."
  else
    error "Failed to install Metasploit Framework."
  fi
else
  success "Metasploit Framework is already installed."
fi

# Install OWASP ZAP.
if ! command_exists zaproxy; then
  success "Installing OWASP ZAP..."
  snap install zaproxy --classic
else
  success "OWASP ZAP is already installed."
fi

success "===== Installing tools from GitHub ====="

# GitHub repositories to install.
GITHUB_REPOS=(
  "https://github.com/sqlmapproject/sqlmap.git"
  "https://github.com/OWASP/Amass.git"
  "https://github.com/SecureAuthCorp/impacket.git"
  "https://github.com/carlospolop/PEASS-ng.git"
  "https://github.com/danielmiessler/SecLists.git"
)

for repo in "${GITHUB_REPOS[@]}"; do
  install_from_github "$repo"
done

# Install python tools using pip.
success "===== Installing Python tools using pip ====="
PIP_TOOLS=("requests" "beautifulsoup4" "pwntools" "factordb-pycli" "bluepy" 
           "stegcracker" "tqdm" "colorama" "ipython" "prompt-toolkit")
pip3 install --upgrade "${PIP_TOOLS[@]}"

# Create aliases for commonly used tools.
success "Creating aliases for commonly used tools..."
cat > /etc/profile.d/kali-tools-aliases.sh << 'EOF'
# Kali Tools Aliases.
alias nmap-quick='nmap -T4 -F'
alias nmap-full='nmap -T4 -A -v'
alias nmap-vuln='nmap --script vuln'
alias dirb-quick='dirb'
alias msfconsole-no-logo='msfconsole -q'
EOF

source /etc/profile.d/kali-tools-aliases.sh

success "Cleaning up..."
apt clean
apt autoremove -y

# Installation complete!
success "====================================================="
success "    Kali Tools Installation Completed!"
success "    Installation finished at $(date)"
success "    Log file: $LOG_FILE"
success "====================================================="
success "Tools installed:"
echo "- Network tools: nmap, wireshark, tcpdump, etc."
echo "- Web Security: nikto, sqlmap, dirb, burpsuite, etc."
echo "- Password tools: hydra, john, hashcat, etc."
echo "- Wireless tools: aircrack-ng, kismet, etc."
echo "- Forensics: autopsy, binwalk, foremost, etc."
echo "- Frameworks: Metasploit, ZAP"
echo "- And many more utility tools"
success "====================================================="
success "Run 'source /etc/profile.d/kali-tools-aliases.sh' to load the aliases"
success "or restart your terminal session."
```
