## Prompt 7: Customizations and Extensibility

**Objective:** Enhance the dotfiles setup with a **modular structure** that allows users to easily customize and extend it – for example, adding their own aliases, including additional tools, or even supporting new operating systems or shells – **without modifying the core files**.

**Details:**

- **Modular Config Loading:** Update the shell configuration files to automatically include any user-specific or additional configurations:
  - **Zsh (`.zshrc`):** Toward the end of the file, add logic to source any custom files. For example:
    ```bash
    # Load custom aliases or overrides if available
    if [ -f "$HOME/.zshrc.local" ]; then
      source "$HOME/.zshrc.local"
    fi
    ```
    Also, consider sourcing all files in a directory (e.g., `~/.zshrc.d/`) if that directory exists, to allow the user to drop multiple shell scripts that get loaded. Comment this out or document it so user can opt-in.
  - **PowerShell profile:** Do something similar. For example:
    ```powershell
    # Load custom PowerShell profile extensions if present
    $customProfile = Join-Path $HOME "Documents\PowerShell\ProfileExtensions.ps1"
    if (Test-Path $customProfile) {
        Write-Host "Loading custom profile extensions from $customProfile"
        . $customProfile
    }
    ```
    This will automatically run any additional commands the user wants in their PowerShell profile without altering our main profile script.
  - These hooks allow users to maintain their personal or machine-specific settings separately.
- **Adding New Aliases/Functions:** Document (perhaps in comments or README) that users can add new aliases either via the above local files or by editing a specific section. Encourage grouping custom aliases in one file that gets sourced as above, to keep the main dotfiles clean.
- **Adding New Tools:** If a user wants to add configuration for a new tool (say, a new Vim plugin, or a new CLI tool config file), the repository structure should accommodate it:
  - They can place the config file in the appropriate folder (macos/linux/windows) and then add it to the stow linking process (if not automatic).
  - Alternatively, instruct how to manually stow additional files.
  - Ensure the directory structure is such that adding a new dotfile is straightforward (e.g., if one adds `linux/.config/myapp/config.toml`, the `linux/` folder can be stowed and it will go to `~/.config/myapp/config.toml`).
- **Supporting New OSes or Distros:** Explain how one might extend:
  - For example, to add **Fedora support**, one could create a `fedora/` directory for any Fedora-specific configs. The setup script’s OS detection (Prompt 2) could be extended with a case for Fedora (detect via `ID_LIKE` or `uname` etc.) and then use the appropriate folder.
  - Similarly, to support a different Linux distro or FreeBSD, etc., the structure can be extended. The key is to follow the established pattern: create a folder, put config in it, adjust install scripts to handle any package differences, and perhaps adjust symlink script to include that OS.
- **Supporting Different Shells:** Our setup uses Zsh and PowerShell. If a user prefers **Bash** on Linux/macOS or wants to add **Fish shell**:
  - They can add a bash config (e.g., `linux/.bashrc`) and adjust the interactive script to detect that preference or simply manually use it. We can mention that one could include a `.bashrc` and even load it conditionally.
  - The structure might be extended with a `shells/` directory or just include bash config in the OS folder and comment it out if not used.
  - To support **Fish**, one could add a fish config file in the repo and include installation of Fish in the script. (Detailing this is beyond our scope, but acknowledging extensibility is good.)
- **Clean Overrides:** Emphasize that because of the structure, users can keep their changes separate:
  - e.g., by using the `*.local` files and not editing the main tracked files, making pulling updates to the dotfiles repo easier if it’s shared.
- **Extensible Scripts:** Design the scripts (from Prompts 2 and 3) in a way that adding a new OS is straightforward:
  - For instance, use a case statement or if/elif chain in `setup.sh` and `link_dotfiles.sh` that clearly can be extended. Comment in those scripts something like "# TODO: Add additional OS cases here".
  - Possibly use variables for package manager commands so one can plug in new ones for another distro.
- **Themes and Appearance:** If users want to change the prompt theme (Oh My Posh or Starship) or colors, note that they can edit the config (like starship’s config or change the theme name in PowerShell profile) without affecting functionality. Encourage them to explore different built-in themes.
- **Testing and Dry-Run:** For advanced users, mention that they can test the scripts with a "dry run" (maybe by a `-n` flag if implemented or by reading through what will happen) and that the scripts are written in a modular way so one can run parts independently (for instance, just the font installer, just the stow step, etc.).

**Output:** The LLM should output:
- **Updated versions of the shell config files** (`.zshrc` and PowerShell profile) with the new modular sourcing logic included. Show the additions in context and ensure the files remain functional. (You can reprint the full file or the relevant excerpt with the new lines, but it should be clear how the file looks after modification.)
- Optionally, a brief **guide (text)** summarizing how to extend the dotfiles (point form or paragraph) that can be included in documentation. This might also be integrated into the final README in the next prompt, but you can provide it here for completeness (e.g., a short note like "To add your own aliases, use ~/.zshrc.local as described...").
- All code sections should be in Markdown format. Comments should clearly explain the purpose of the new lines (for instance, “# Load user customizations if present”).
- Make sure this prompt’s output doesn’t undo or conflict with earlier configurations; it should only add flexibility. Maintain any comments from earlier outputs as needed for continuity.
