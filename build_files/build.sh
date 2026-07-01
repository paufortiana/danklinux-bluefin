#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Enable the COPR repos for dms and danklinux packages
dnf5 -y copr enable avengemedia/dms
dnf5 -y copr enable avengemedia/danklinux

# Install dms packages, niri and alacritty
dnf5 install -y --refresh niri alacritty dms dms-greeter

# Disable the COPR repos for dms and danklinux packages
dnf5 -y copr disable avengemedia/dms
dnf5 -y copr disable avengemedia/danklinux

# Enable first-login DMS bootstrap for all users.
systemctl --global enable dms-user-bootstrap.service
systemctl --global enable dms-greeter-sync.service

# Switch from GDM to greetd for login management
systemctl disable gdm
systemctl enable greetd 

# Clean up before finalizing the image
rm -rf /run/selinux-policy
rm -rf /run/dnf
rm -rf /tmp/*
rm -rf /var/tmp/*
dnf5 clean all
rm -rf /var/cache/dnf /var/lib/dnf/repos /var/lib/dnf/system-repo.lock
