# Dank Linux Bluefin: Universal Blue's Bluefin + Dank Material Shell with Niri 

This repository builds a custom Universal Blue's [Bluefin](https://projectbluefin.io/) bootc image including [Dank Linux](https://danklinux.com), a project from [Avenge Media](https://github.com/AvengeMedia). The goal of this project is to provide a native-feeling Dank Material Shell with Niri experience on an immutable Fedora-based image, while staying close to the Universal Blue ecosystem. Starting from the Universal Blue [image template repository](https://github.com/ublue-os/image-template), it is shaped into a project-specific bootc image that simply includes Dank Material Shell, Niri, and related assets in the immutable operating system. 

## Project focus

- Dank Material Shell packages, `niri` and `alacritty` terminal emulator installation
- First-login bootstrap for ready-made user defaults
- Configuration assets shipped in the image
- Dank Greeter login integration and defaults

## Origin and inspiration

This repository inherits the [image template](https://github.com/ublue-os/image-template) workflow and follows the spirit of the [Zirconium](https://github.com/zirconium-dev) project, that brings native Dank Linux with Niri experience on a Fedora-based system.

After tinkering with [Dank Linux](https://danklinux.com) on different compositors and base operating systems (and some distros with different shells and compositors), and discovering Zirconium; the author's previous learning curiosity for bootc and immutable images rebasing led to try the Universal Blue image template and build a custom image with it. 

The goal is to provide another polished, modern desktop experience bootable image, that brings Dank Material Shell and Niri together on an immutable Fedora, using as the base the quality of life improvements of Universal Blue. The image is designed for users who want a modern, desktop experience with Niri and the benefits from the upstream Universal Blue ecosystem.

This image uses Niri, the preferred choice in Dank Linux; however, Hyprland is also a strong alternative that is worth considering once this compositor is available in Fedora. The base image is Bluefin, which provides GNOME as the default desktop environment, and the DX version of Bluefin could be also used as a base image for an even more feature-rich experience. You can also manage another terminal emulator, such as ghostty or kitty, which are also supported by Dank Material Shell.

The author didn't manage the Bluefin's featured dev-mode toggle, so using the `ujust` command would rebase to original Bluefin, or the DX version of Bluefin. If you build your own image, you can use the DX version of Bluefin as a base image and it should work fine. 

## Usage

If you want to test it on a local bootc system, you can switch to the image with:

```bash
sudo bootc switch ghcr.io/paufortiana/dms-bluefin:latest
```

The image will be built on weekly basis and published to GitHub Container Registry. The `ujust update` command will do the same as on Bluefin, with the new image, so you can use it to update your system to the latest version of the image (and the base image), including flatpaks and homebrew.

Dank Greeter (`greetd`) is the default display manager. You can switch to `gdm` whenever needed by disabling manually the greetd service and enabling the gdm service. 

```bash
sudo systemctl disable greetd
sudo systemctl enable gdm
```

If using the `greetd` display manager, you can still login into GNOME or any other desktop environment by selecting it on the login screen, however some features that require the disabled display manager will not work, such as the GNOME settings. You can install dconf-editor flatpak to manage your GNOME settings, and use the builtin `dms` settings for your Dank Material Shell preferences.

Check the status of Dank Greeter with: 

```bash
dms greeter status
```

If it is not already done, on login a script will run `dms greeter sync` in a visible terminal window to add your user to greeter group, setup permissions and ACLs for the greeter (will require your password). 

Sync the greeter after changing theme or wallpaper:

```bash
dms greeter sync
```

### Recommended workflow

1. Install a base Bluefin image first.
2. Switch to the DMS-Bluefin image (you will need to select `niri` on the login screen after rebooting).
3. Enjoy the Niri experience with all the features of Dank Material Shell and the quality of life improvements from Universal Blue.

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

A big thank-you to the people behind [Universal Blue](https://universal-blue.org/) and [Dank Linux](https://danklinux.com) for the projects, ideas, and tools that made my new favorite operating system possible. It is deeply thankful to the Universal Blue project for providing the excellent template and workflow foundation, and to the Dank Linux project for providing excellent documentation and resources for manual installation and configuration.
