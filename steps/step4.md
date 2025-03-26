## Prompt 4: Shell Environment Configuration (Zsh and PowerShell)

**Objective:** Set up the shell environment on each platform with customized configuration files:
- **Zsh** for macOS and Linux, including Oh My Zsh and Starship prompt.
- **PowerShell** for Windows, including Oh My Posh and Starship prompt.

**Details:**

- **Zsh Configuration (macOS & Linux):**
  - Create a dotfile for Zsh (e.g., `macos/.zshrc` and `linux/.zshrc`). These files will be symlinked to `~/.zshrc` on their respective systems.
  - Incorporate **Oh My Zsh** framework:
    - Include a check in the `.zshrc` whether Oh My Zsh is installed. If not, provide a commented instruction or automated snippet to install it (e.g., the official curl command).
    - Set a sensible Zsh theme (avoid powerlevel10k as requested; you may use a simple theme or none since we will use Starship for the prompt).
    - Enable some common plugins in Oh My Zsh (like `git`, `z`, etc.) to improve user experience.
  - Configure the **Starship prompt** in Zsh:
    - After Oh My Zsh initialization, add the line to initialize Starship, e.g.:
      ```bash
      eval "$(starship init zsh)"
      ```
    - (Starship will be installed via the setup script if not present.)
  - Add useful **aliases** and environment variables in `.zshrc`:
    - For example: `alias ll='ls -la'` (and consider using `exa`/`eza` if installed), `alias gs='git status'`, etc.
    - Preserve PATH modifications (especially on macOS, ensure Homebrew paths are included).
    - Source any additional config files as needed (like a separate aliases file or local customizations – to be expanded in Prompt 7).
- **PowerShell Configuration (Windows):**
  - Use the PowerShell profile script, typically `Documents\PowerShell\Microsoft.PowerShell_profile.ps1` (for PS Core) or `WindowsPowerShell\Microsoft.PowerShell_profile.ps1` for Windows PowerShell. In our repository, store it as `windows/Microsoft.PowerShell_profile.ps1`.
  - Configure **Oh My Posh**:
    - Assume the setup script installed Oh My Posh (via Winget or `Install-Module`). Import the module: `Import-Module oh-my-posh`.
    - Set a prompt theme. For example, use a built-in theme (like `Paradox` or any available) or a custom theme file stored in the repo (optional). E.g.:
      ```powershell
      Set-PoshPrompt -Theme Paradox
      ```
      (Ensure the theme name exists on the system or provide instructions to download it if custom.)
  - Configure **Starship** in PowerShell:
    - Add an initialization for Starship in the PowerShell profile:
      ```powershell
      Invoke-Expression (&starship init powershell)
      ```
    - This allows switching to Starship prompt if desired. (Note: Using both Starship and Oh My Posh at the same time might be redundant; you can include both but perhaps comment out one by default, explaining in comments how to switch.)
  - Add **aliases and PS configuration**:
    - Useful PowerShell aliases or functions (e.g., `ls` to `Get-ChildItem -Force`, `cat` to `Get-Content`, if not already present).
    - Import modules like PSReadLine (for better history and syntax highlighting) and enable any desired options (e.g., `Set-PSReadLineOption -EditMode Emacs` or `vi` depending on preference).
    - Environment variable customizations (if any) for convenience (like `HttpProxy` if needed, etc.).
    - Ensure the profile does not throw errors if modules are missing; use `if (Get-Module ...)` checks or try/catch around imports.
- **Installation of Tools:** The configuration should assume the necessary tools are installed:
  - The **interactive script** (Prompt 2) will have installed:
    - Zsh (on Linux, since macOS has it by default).
    - Oh My Zsh (via the official script).
    - Starship (via Homebrew, cargo, or curl script).
    - Oh My Posh (via Winget or PowerShell module).
  - Still, include comments in the config files to guide someone installing manually, e.g., “# Run `brew install starship` if Starship is not installed.”
- **Security and Best Practices:**
  - Avoid running any dangerous commands in the shell configs. They should primarily set up environment, not execute heavy logic.
  - Use comments to explain sections so the user can maintain the files.
  - Ensure paths are properly handled (use `$HOME` or `~` in Zsh; use `$env:USERPROFILE` in PowerShell for home directory).
- **No p10k:** Confirm that the configurations do not reference Powerlevel10k (p10k), as per requirements.

**Output:** The LLM should output the **contents of the shell config files** for each OS, in markdown code fences. For example:
- `macos/.zshrc` (for macOS Zsh config)
- `linux/.zshrc` (for Linux Zsh config, can be similar to macOS with minor tweaks if needed)
- `windows/Microsoft.PowerShell_profile.ps1` (PowerShell config for Windows)
Each file’s content should be clearly separated and labeled (you can prepend a comment or a markdown note indicating which file is which). Ensure each configuration file is complete, with appropriate comments and ready to be deployed.
