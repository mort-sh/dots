## Prompt 2: Interactive Cross-Platform Configuration Script

**Objective:** Develop an **interactive setup script** that runs on **both Unix-like systems (macOS/Linux)** and **Windows 11**, guiding the user through installation and configuration of the dotfiles.

**Details:**

- **Cross-platform Script:** Provide two implementations:
  1. **`scripts/setup.sh`** for macOS/Linux (Bash/Zsh).
  2. **`scripts/setup.ps1`** for Windows (PowerShell).
- **OS Detection:** The script should detect the current OS (e.g., via `$OSTYPE` or `uname` for Bash, and `[System.Environment]::OSVersion` or `$PSVersionTable` for PowerShell) and confirm it’s one of the supported platforms (Windows 11, macOS, Ubuntu).
- **Prerequisite Check:** Verify that essential tools are installed:
  - Git, cURL/wget, unzip, and package managers (`brew` on macOS, `apt` on Ubuntu, `winget` or `choco` on Windows).
  - On Windows, also check for PowerShell (Core 7+ if possible) and on Linux/macOS check for Zsh.
- **Automated Installation:** If a prerequisite is missing, the script should **offer to install it**:
  - Use **Homebrew** on macOS (or prompt to install Homebrew if not present).
  - Use **apt** on Ubuntu for packages (update apt cache as needed).
  - Use **Winget** (or Chocolatey) on Windows for tools (e.g., Git, oh-my-posh, etc.), or fall back to PowerShell’s `Install-Package`/manual download if necessary.
- **Interactive Prompts:** Guide the user through optional setup steps:
  - Ask for confirmation before proceeding at each major step (e.g., "Proceed with dotfiles installation? [Y/n]").
  - Offer choices for certain configurations (for example, whether to install VS Code, whether to set Zsh as default shell on Linux, etc.).
  - On Windows, **use GUI dialogs if available** (e.g., Windows Forms message boxes or Out-Host) for important prompts. If GUI cannot be initialized (e.g., running in a headless environment), safely fall back to console prompts (`Read-Host`).
- **Safe Execution:** Perform checks (like ensuring the script is running with appropriate privileges if needed, e.g., for installing packages or creating symlinks on Windows). If a step fails or the user declines an action, handle it gracefully (log a message and skip or retry).
- **Logging and Output:** Provide clear output messages for each action (e.g., "Installing Git...", "Creating directories...", "All prerequisites met."). Use colors if possible (e.g., tput in Bash or Write-Host with colors in PowerShell) to enhance readability.
- **No Hard-Coding Sensitive Data:** Do not include any user-specific info or secrets. The script should be generic and safe.

**Output:** Instruct the LLM to produce **two files** – `scripts/setup.sh` and `scripts/setup.ps1` – in one response, each enclosed in Markdown triple backticks with appropriate syntax highlighting (bash and powershell). Each script should be well-commented for clarity and maintainability. Ensure the PowerShell script adheres to PowerShell best practices and the Bash script to Bash best practices. Include error handling and user feedback throughout. The result should be a user-friendly guided installer for the dotfiles.