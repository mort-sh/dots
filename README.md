# dotfiles

A cross-platform dotfiles repository to easily set up a consistent development environment on macOS, Linux, and Windows.

## Overview

This repository provides a unified configuration for your development environment across multiple platforms. It includes configurations for shells (Zsh and PowerShell), editors (Neovim, VS Code), and other essential tools, ensuring a consistent and productive experience regardless of the operating system you're using.

Key features:

-   Managed via a single repository for easy synchronization.
-   Interactive installation script for automated setup.
-   Consistent tools and themes across platforms.

## Supported Platforms

-   macOS (Ventura or later)
-   Ubuntu Linux (22.04 or later)
-   Windows 11 (with PowerShell 7)
-   WSL (Windows Subsystem for Linux)

## Repository Structure

The repository is organized to separate configurations by platform:

-   `macos/` – Contains macOS-specific configuration files (e.g., `.zshrc`, `.tmux.conf`)
-   `linux/` – Contains Linux-specific configuration files (e.g., `.zshrc`, `.tmux.conf`)
-   `windows/` – Contains Windows-specific configuration files (e.g., PowerShell profiles)
-   `scripts/` – Contains installation and setup scripts:
    -   `setup.sh` – Main setup script for macOS and Linux
    -   `setup.ps1` – Main setup script for Windows
    -   `install_fonts.sh`/`install_fonts.ps1` – Scripts for Nerd Fonts installation
    -   `link_dotfiles.sh`/`link_dotfiles.ps1` – Scripts for managing symlinks

## Prerequisites

Before using these dotfiles, ensure you have the following:

-   Git: Required to clone the repository.
-   Windows: Windows Terminal (recommended), PowerShell 7 or later.
-   macOS: Xcode command line tools (if Git is not already installed).
-   Linux: An internet connection and sudo access for installing packages.

The installer script will handle many prerequisites automatically, such as installing Homebrew on macOS.

## Setup Instructions

Follow these steps to install and use the dotfiles:

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
    ```

2.  **Run the setup script:**

    ```bash
    cd ~/dotfiles/scripts
    ```

    -   On macOS/Linux:

        ```bash
        ./setup.sh
        ```

    -   On Windows:

        Open PowerShell and run:

        ```powershell
        .\setup.ps1
        ```

        (Ensure execution policy allows it. If needed, set `RemoteSigned`: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`)

3.  The script will guide you through the rest of the installation process, including installing tools and linking files. Answer the prompts to customize the process.

If you prefer a manual setup, you can copy or symlink the files to their respective locations. However, using the script is highly recommended.

## What the Installer Does

The setup script automates the following:

-   Installs missing packages (Zsh, Oh My Zsh, Starship on \*nix; PowerShell modules, oh-my-posh on Windows).
-   Sets up symlinks for all configuration files to the home directory.
-   Backs up any existing dotfiles that would conflict.
-   Offers to install Nerd Fonts (Fira Code, Iosevka, JetBrainsMono).

## Post-Installation Steps

After running the script:

-   Restart your terminal to see the new prompt and settings in effect.
-   Set your terminal emulator's font to use one of the Nerd Fonts (e.g., FiraCode Nerd Font) to ensure icons and symbols display correctly.
-   On Windows, set the font in Windows Terminal settings and ensure UTF-8 encoding is enabled.
-   Log out/in or source the shell again if needed.

## Usage Examples

-   The prompt will display relevant information, such as the current Git branch and system status.
-   Running `ll` now uses `exa` and shows colorized output (if eza is installed).
-   Running `tmux` uses the provided configuration.
-   Open Neovim and run `:PlugInstall` to install plugins.

## Customization & Extensibility

You can customize and extend the dotfiles setup without modifying the core files.

-   **Adding Personal Aliases:** Use `~/.zshrc.local` (for Zsh) or `Documents\PowerShell\ProfileExtensions.ps1` (for PowerShell) to add custom aliases and functions.
-   **Tweaking Configurations:** Edit the configuration files in the repository or use local overrides to change themes or prompt symbols.
-   **Adding New Dotfiles:** Place new dotfiles in the appropriate OS-specific folder and symlink them.
-   **Supporting New Platforms:** Extend the setup for other platforms or shells by creating new OS-specific folders and modifying the installation scripts.

## Troubleshooting & Known Issues

-   If prompt symbols look like gibberish, ensure you have set your terminal's font to a Nerd Font.
-   If `setup.ps1` won't run, set the execution policy: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`.
-   If you encounter issues with Homebrew on macOS, try running the script again or running brew manually.

## Credits & References

-   Neovim configuration adapted from [dev-mute's neovim-init.vim](https://github.com/dev-mute/neovim-init.vim).
-   Uses [Oh My Zsh](https://ohmyz.sh/) for Zsh configuration.
-   Uses [Oh My Posh](https://ohmyposh.dev/) for PowerShell theming.
-   Uses [Starship](https://starship.rs/) for cross-shell prompt.

## Maintaining the Repo

This is a personal dotfiles repository. Feel free to fork it or modify it to fit your own needs. Pull changes from this repository occasionally if you forked it, or commit your customizations if it's your own.

## License

Feel free to use and adapt these configurations.