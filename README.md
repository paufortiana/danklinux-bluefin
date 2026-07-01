# Dank Linux Bluefin: Universal Blue's Bluefin + Dank Material Shell with Niri 

This repository builds a custom Universal Blue's Bluefin bootc image including Dank Material Shell and Niri. The goal of this project is to provide a native-feeling Dank Material Shell with Niri experience on an immutable Fedora-based image, while staying close to the Universal Blue ecosystem. Starting from the Universal Blue image template repository, it is shaped into a project-specific bootc image that simply includes Dank Material Shell, Niri, and related assets in the immutable operating system. 

## Project focus

- dms and dms-greeter packages, niri and alacritty terminal emulator installation
- First-login bootstrap for ready-made user defaults
- Configuration assets shipped in the image
- dms-greeter login integration and defaults

## Origin and inspiration

This repository inherits the Universal Blue bootc image-template workflow and follows the spirit of the [Zirconium project](https://github.com/zirconium-dev) that brings native niri experience on Fedora system.

It builds on the work of:

- [Universal Blue](https://github.com/ublue-os)
- [Avenge Media](https://github.com/AvengeMedia/DankMaterialShell)

After tinkering with Dank Material Shell on different compositors and base operating systems (and some distros bundling different shells and compositors), and discovering Zirconium, a fedora-based bootc image using the Dank Material Shell with Niri; the author's previous learning curiosity for bootc and immutable images rebasing led to try the Universal Blue image template and build a custom image with it. The goal is to provide another polished, modern desktop experience bootable image, that brings Dank Material Shell and Niri together on an immutable Fedora, using as the base the quality of life improvements of Universal Blue. The image is designed for users who want a modern, opinionated desktop experience with DMS and Niri with the benefits from the upstream Universal Blue ecosystem.

This image uses Niri, the preferred choice in Dank Linux; however, Hyprland is also a strong alternative that is worth considering. The base image is Bluefin, which provides GNOME as the default desktop environment, and the DX version of Bluefin could be also used as a base image for an even more feature-rich experience. The author didn't managed the featured DX toggle ujust, so using the toggle would rebase to original Bluefin, and the DX version of Bluefin. If you build your own image, you can use the DX version of Bluefin as a base image and it should work fine. You can also manage another terminal emulator, such as ghostty or kitty.

## Usage

If you want to test it on a local bootc system, you can switch to the image with:

```bash
sudo bootc switch ghcr.io/paufortiana/dms-bluefin:latest
```

The image will be built on weekly basis and published to GitHub Container Registry. The `ujust update` command will do the same as on your current uBlue system, with the new image, so you can use it to update your system to the latest version of the image (and the base image), including flatpaks and homebrew.

### Recommended workflow

1. Install a base Bluefin image first.
2. Switch to the DMS-Bluefin image (you will need to select `niri` on the login screen after rebooting).
3. Enjoy the DMS/Niri experience with all the features of Bluefin and Dank Material Shell.

## Local build

If you prefer to not use the pre-built image in this repository, you can build the image locally. Clone the repo, and run `just` to see the available commands.

Follow instructions in the [ublue-os/image-template repository README](https://github.com/ublue-os/image-template) for more information about building your image locally. 

## Repository structure

- [Containerfile](Containerfile) — build entrypoint for the image
- [build_files/build.sh](build_files/build.sh) — installs packages and applies image customizations
- [system_files](system_files) — configuration and service files shipped into the image
- [image-template.env](image-template.env) — image metadata and publishing defaults
- [Justfile](Justfile) — build and test commands for the image

## Thanks

A big thank-you to the people behind [uBlue](https://universal-blue.org/) and [DankLinux](https://danklinux.com) for the projects, ideas, and tools that made my new favorite operating system possible. It is deeply thankful to the uBlue project for providing the excellent template and workflow foundation, and to the Dank Linux project for providing excellent documentation and resources for manual installation and configuration.
