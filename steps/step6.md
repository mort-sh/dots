## Prompt 6: Nerd Font Installation and Management

**Objective:** Ensure that the appropriate **Nerd Fonts** are installed and available, as many of the prompt themes and developer tools (like powerline prompts, `exa` icons, or Neovim plugins) use special icons. This prompt will create logic to check for and install fonts, as well as provide instructions to the user on how to enable them.

**Details:**

- **Target Fonts:** Focus on the following Nerd Font families (as requested):
  - **Fira Code Nerd Font**
  - **Iosevka Nerd Font (or IosevkaCode)** 
  - **JetBrainsMono Nerd Font (Proportional, if available)** 
  - These fonts provide good coverage of programming ligatures and icons.
- **Font Detection:** The script or logic should:
  - Check if the fonts are already installed on the system.
    - On Windows: likely check the Windows Fonts directory or use PowerShell to query installed fonts by name.
    - On macOS: check `~/Library/Fonts` and `/Library/Fonts` for the font files or use `fc-list` if available.
    - On Linux: check `~/.local/share/fonts` or system font directories, or use `fc-list | grep "FiraCode"` etc.
  - If fonts are installed, confirm to the user that they are present.
- **Font Installation:** If any of the target fonts are missing, offer to install them:
  - **Download sources:** Nerd Fonts are available on GitHub (e.g., from the official Nerd Fonts releases). Provide URLs or use `curl`/`wget` to download the latest releases for those fonts.
    - For example, FiraCode Nerd Font can be downloaded as a TTF/OTF zip from Nerd Fonts GitHub.
    - Ensure the script picks the right variant (e.g., "Complete" version of the font for all glyphs).
  - **Installation process:**
    - On **macOS/Linux**: Download the .ttf files (e.g., to `~/.local/share/fonts` or `~/Library/Fonts` on Mac). After downloading, refresh the font cache (on Linux, run `fc-cache -fv`).
    - On **Windows**: Use PowerShell to download the font file(s) (maybe via `Invoke-WebRequest`) and then install:
      - For installation, you can copy to `%LOCALAPPDATA%\Microsoft\Windows\Fonts` for per-user installation or use the Shell.Application COM object to install fonts. Simpler: instruct the user to manually double-click the fonts if automatic install is complex. Alternatively, use PowerShell to add a registry entry (not ideal).
      - Possibly, if using winget, check if winget has a package for these fonts (some fonts are available via package managers).
    - Provide progress or confirmation messages.
  - Only install if user agrees (especially on Windows, might require admin for system-wide).
- **Script Integration:** Decide where this logic lives:
  - Could be part of the main `setup` scripts (Prompt 2) as one of the steps (if user opts in).
  - Or as a separate script `scripts/install_fonts.(sh|ps1)` that the main script can call or user can run independently.
  - The prompt should clarify this integration (e.g., “this script can be invoked from the main installer or run standalone”).
- **Post-Installation Instructions:** After installing (or if fonts already present), **inform the user** how to activate them:
  - Windows: e.g., "Open Windows Terminal settings and set the font face to 'FiraCode Nerd Font'" or set it in PowerShell profile via `$env:TerminusFont` (for Windows Terminal profiles, the user typically has to configure it in terminal settings JSON).
  - macOS: "Set your Terminal/iTerm2 font to FiraCode Nerd Font Regular".
  - Linux: "Update your terminal emulator's font settings to use the Nerd Font (or if using GUI like GNOME Terminal, set it in preferences)".
  - If using VS Code, ensure the font family in settings includes the Nerd Font name.
  - If using Neovim in a GUI (like Neovide/Kitty/Alacritty), mention setting the font there if needed.
- **Verification:** Optionally, after installation the script can verify by listing the font files or using `fc-list` to confirm.
- **No Duplicates:** If fonts already exist, avoid re-downloading unnecessarily (unless a force update is chosen).
- **Security:** Download over HTTPS and verify downloads (if possible, e.g., check hash or at least ensure HTTP 200 success). Use official sources.

**Output:** Provide the content of a **font installation script** (for example, `scripts/install_fonts.sh` and/or `scripts/install_fonts.ps1`). Alternatively, incorporate it into existing setup scripts as a function and show that code snippet. The code should be in markdown fences, properly commented. Additionally, include a short **usage note** in markdown outside the code, which can be added to the README, explaining how the user should set their terminal or editor to use the new font after running the script. This ensures the user knows how to actually enable the Nerd Font in their environment.

---
