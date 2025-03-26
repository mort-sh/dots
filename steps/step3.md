## Prompt 3: Dotfile Symlink Management (GNU Stow or Equivalent)

**Objective:** Provide a solution for **managing dotfile symlinks** on each platform, ensuring that the files in the repository are correctly linked to the user’s home directory (so that the configurations take effect). This should handle differences between platforms (including WSL on Windows).

**Details:**

- **GNU Stow (macOS/Linux):** Utilize GNU Stow on macOS and Linux to manage symlinks. The prompt should produce a script (or function) that:
  - Checks if GNU Stow is installed; if not, offers to install it (via Homebrew on macOS or apt on Ubuntu) or uses a simple fallback method to create symlinks manually.
  - Uses `stow` to link the configuration directories (e.g., `macos/`, `linux/`) into the user’s home directory. For example, running `stow -d ~/dotfiles -t ~ linux` would symlink all files in `linux/` to the home directory on a Linux machine.
  - Ensures that only the appropriate folder for the current OS is stowed (e.g., only `macos` on Mac, only `linux` on Linux, etc.).
- **Windows Symlinks:** On Windows, provide an equivalent solution:
  - Since GNU Stow is not native on Windows, use PowerShell to create symlinks (using `New-Item -ItemType SymbolicLink` for each file) or use a Windows version of `stow` if available (e.g., via MSYS2 or WSL).
  - Handle Windows specifics: For example, creating a symlink might require Administrator privileges or Developer Mode enabled. The script should detect if it has the necessary rights and inform the user if not.
  - Make sure to target the correct Windows user home (e.g., `C:\Users\Username`) for linking. In the case of WSL, detect that scenario and possibly skip Windows linking (since WSL will use the Linux section) or handle it appropriately.
- **Path Resolution:** Ensure the scripts correctly expand `~` (home directory) for each platform. For WSL detection in a Linux script, you can check for the presence of the `WSL` environment or the OS name containing "Microsoft".
- **Idempotence and Safety:** If a dotfile already exists in the home location:
  - Backup the existing file (e.g., rename to `*.backup` with a timestamp) or prompt the user before overwriting.
  - Then create the new symlink.
  - Use clear logging to indicate what is being linked and any files that were backed up.
- **Script Organization:** You can incorporate this logic into the main setup scripts from Prompt 2 or provide it as a separate script for clarity (e.g., `scripts/link_dotfiles.sh` and `scripts/link_dotfiles.ps1`). **Make sure to coordinate with Prompt 2 output** (for example, the main setup might call this linking script as a final step).
- **WSL Support:** If running under WSL, treat it as a Linux environment for linking Linux dotfiles into the WSL home. Optionally, detect if a Windows 11 OS is accessible and advise the user if they should also run the Windows script for Windows apps.

**Output:** The LLM should produce the symlink management logic as code. This could be done as **two scripts** for clarity: one Bash script (for macOS/Linux) and one PowerShell script (for Windows). Provide the code in Markdown fences, with appropriate comments. Ensure each script clearly identifies the OS, performs the linking using either `stow` or native methods, and outputs success/failure messages for each link. The scripts should be robust and not break if partially applied (i.e., they can be re-run safely).
