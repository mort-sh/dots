## Prompt 5: Editor and Tooling Configuration

**Objective:** Set up configurations for developer tools and editors, ensuring seamless integration with the shell environment and providing default settings for a productive development setup.

**Details:**

- **Visual Studio Code:**
  - Provide instructions or a script to install VS Code on each platform (if the user opts in):
    - e.g., use Homebrew on macOS (`brew install --cask visual-studio-code`), apt on Ubuntu (from Microsoft’s repository or Snap), and Winget on Windows (`winget install --id Microsoft.VisualStudioCode`).
    - This installation step might be part of the interactive script (Prompt 2) via user choice.
  - Configure VS Code settings for integration:
    - Ensure the `code` command-line launcher is available in the shell (the interactive script can set this up, e.g., by installing Shell Command on macOS or adding to PATH).
    - Provide a basic `settings.json` (or a snippet) that could be placed in the user’s VS Code configuration to, for example, set the integrated terminal to use the configured shell (Zsh or PowerShell) and enable font ligatures for Nerd Font usage.
    - Optionally include recommended extensions or settings (for example, settings to use the installed tools like ESLint, Python linting if using Poetry, etc., though keep it minimal).
    - Since storing the entire settings.json in the dotfiles might be user-specific, you can mention it in documentation rather than creating a file. However, do include any configuration needed for proper shell integration (like using Zsh as default terminal on Mac/Linux, and PowerShell on Windows).
- **Tmux:**
  - Create a `tmux.conf` with **sane defaults** and improvements:
    - Example settings: reasonable prefix key, mouse support enabled, vim-keybindings, a pleasing status bar with minimal info, and any integration with system clipboard (particularly on macOS, use `reattach-to-user-namespace` if needed).
    - Ensure it doesn’t conflict with common usages and comment each setting for clarity.
    - Place this as a dotfile in the repo (possibly `linux/.tmux.conf` and `macos/.tmux.conf` if any OS-specific differences, or a common one if identical).
- **Neovim:**
  - Include a **Neovim configuration** (`init.vim`) that provides a rich development environment, inspired by the provided config (GitHub: `dev-mute/neovim-init.vim`):
    - Use **vim-plug** for plugin management (since the reference config uses it). Include the Plug installation line for vim-plug if needed (so a user can install it easily).
    - Plugins to include (based on the reference):
      - Core plugins: `nvim-treesitter` (with `:TSUpdate`), `neovim/nvim-lspconfig` (for LSP), completion plugins like `nvim-cmp` and sources (`cmp-nvim-lsp`, `cmp-buffer`, etc.), `telescope.nvim` (fuzzy finder with `fzf` native extension), `lualine` (statusline), `nvim-tree.lua` (file explorer), and `nvim-web-devicons` (for file icons).
      - Utility plugins: examples from reference – git integration (`vim-fugitive`), better commenting (`nerdcommenter`), surround text (`vim-surround`), autopairs, etc. Include a few popular ones for productivity.
      - Colorschemes: add `dracula/vim` (as `dracula` theme) or any preferred theme (since Nerd Font will be used, a theme that includes icons support is good, Dracula is fine as per reference).
    - After listing `call plug#end()`, include additional Neovim settings:
      - Enable true color, set the colorscheme (e.g., `colorscheme dracula`).
      - Basic editor settings: indenting, line numbers, relative number perhaps, search highlight settings, etc.
      - Configure LSP and completion in a Lua block or minimal Vimscript:
        - For example, ensure that the Python LSP (pyright) is enabled by default (since Python dev was a focus in reference).
        - Set up `cmp` to use LSP and snippet source.
        - Map a few convenient keys (like `<Leader>f` for formatting if LSP supports, etc.).
      - If needed, include an `init.lua` or `lua/` directory for advanced configuration (the reference uses a `lua/` folder for modular config). For simplicity, you can keep most config in `init.vim` but it should remain clean and commented.
    - Ensure the Neovim config is placed in a suitable path in the repo (e.g., `linux/.config/nvim/init.vim` for Linux/Mac). Note in documentation that the user should symlink `~/.config/nvim` to this or copy it.
    - Include instructions or an `:PlugInstall` step in comments so the user knows how to install plugins.
- **Python Tooling (Poetry & Uv):**
  - Ensure that the interactive script (Prompt 2) offers to install **Poetry** (Python dependency management) and **Uv** (the new unified Python tool).
  - In terms of configuration:
    - You might include an alias or function in shell configs for convenient use of Poetry (like `pvenv` to activate Poetry’s virtualenvs, or set `POETRY_VIRTUALENVS_IN_PROJECT=true` in environment).
    - For **Uv**, since it can replace multiple tools, you might add an alias to use `uv` for certain tasks or a note in documentation that it’s installed. (Uv doesn’t require much config, but verify it’s accessible via PATH.)
    - If applicable, ensure that any environment variables needed for these tools are set (for example, Poetry’s settings or shell completions – you could add a line in `.zshrc` to source Poetry’s shell completion script if available).
- **Other CLI Tools:**
  - The dotfiles should accommodate modern CLI tools:
    - **eza (exa)**: modern replacement for `ls`. If installed (the setup script can install it on Linux/macOS), add aliases: `alias ls='eza --group-directories-first'`, etc.
    - **fzf**: fuzzy finder. If installed, ensure the key bindings and auto-completion are enabled. (If using Oh My Zsh, the `fzf` plugin can handle this.)
    - **ripgrep (rg)**: a fast search tool. No specific config needed except ensuring it’s installed for use in fzf.vim or telescope (which it can integrate with).
    - **GitHub CLI (gh)**: If installed, maybe add an alias or ensure that authentication is set up (this might be more user-specific, so just mention it in docs).
    - **Git configuration**: Optionally, as part of dotfiles, include a base `.gitconfig` in the repo with common settings (user can fill in their name/email separately or the interactive script can ask for it). This `.gitconfig` can be symlinked as well. Common settings might include safecrlf, autocolor, default branch naming, etc.

**Output:** The LLM should output relevant configuration files or snippets for these tools in Markdown format. Specifically:
- A `tmux.conf` (or one per OS if needed, but it can likely be universal for macOS/Linux) in a code block.
- The `init.vim` configuration for Neovim (this will be a longer block of code, well commented).
- If creating a sample VS Code `settings.json` or snippet, provide it in a code block (with comments in JSON comments or adjacent text explaining where to put it).
- Any other config files (for example, a sample `.gitconfig` if you choose to include one).
- Ensure each is clearly labeled (either by a comment at the top of the code block or in text preceding it) so the user knows what file it is. For instance, you might say "**File: .tmux.conf**" before that code block.
- The content should be clean and secure (no secrets, no personal paths). Use placeholders or generic values where appropriate (like user name in gitconfig can be `<Your Name>` as a placeholder).
- Include comments in these configs to guide the user, e.g., explain a tmux setting or a Neovim keybinding.

---
