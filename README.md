## Please change your name and email in `<cloned_repo_dir>/git_configs/gitconfig` file after you cloned this repo.

# dotFiles

## Following tools will be installed on system. Installation commands for these tools are mentioned below for macos

- tmux (terminal multiplexer)
- pcre (used as dev dependency while compiling nnn)
- fd (modern find written in rust)
- bat (colourful cat)
- fzf (fuzzy finder)
- ripgrep (modern grep written in rust)
- oh-my-zsh (is being installed as part of script)
- vim => 8.0
- nvim
- perl (used in various scripts)
- greadlink (part of coreutils)
- git
- tree
- mktemp
- exa (for git fuzzy)
- git-delta (for git diff)
- lsd (ls with icons, aliased to ls)
- nnn (terminal file manager with icons, is being compiled and installed as part of download script)
- font-meslo-lg-nerd-font (set iterm2 font: "MesloLGSDZ Nerd Font", font-style: regular, font-size: 15)
- nvm (to install node.js. Node is used by VIM CoC plugin)
- pyenv (to install python and to get python version in prompt)
- asdf (to manage different versions of kubectl)

## Install various tools via brew and npm

```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
brew install tmux pcre fd bat fzf ripgrep vim coreutils git tree git-delta lsd nvm pyenv asdf nvim pinentry-mac gnupg tfenv exa
pyenv install 3.10.0
pyenv global 3.10.0
nvm install --lts
nvm use --lts
# node --version
# v16.13.0
nvm alias default 16.13.0
tfenv install
tfenv use 1.1.2

# Install language servers for nvim
npm install -g pyright bash-language-server prettier write-good neovim
brew install hashicorp/tap/terraform-ls stylua shellharden rust-analyzer
pip3 install neovim
```

## Set iterm-2 font

You need to set this font in your iterm2. You may install other fonts as well.

```
font: "MesloLGSDZ Nerd Font", font-style: regular, font-size: 15
```

## Take backup of following files from your home directory if you have

```
.tmux.conf
.zprofile
.zshrc
.vimrc
.gitconfig
```

## Setup your Terminal, Vim and other tools

**Note:** You can clone the repo anywhere you like and it should work.

```
git clone https://github.com/spareslant/dotFiles.git
cd dotFiles
./downloadAndCreateSymLinks.sh
```

**Note:** if above script fails on CoC, then run following three commands and run script `./downloadAndCreateSymLinks.sh` again. Even if above steps are successful you still need to run following commands in order to run `CoC` properly in `vim`.

```bash
cd downloaded/vim-plugins/coc.nvim
npm install esbuild
npm run build
```

## Set your terminal theme (Tmux and Vim also uses same theme)

Run following command

```
base16_gruvbox-dark-hard
```

Restart the terminal.

## Set kubectl version (Optional)

```bash
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf install kubectl 1.20.11
asdf global kubectl 1.20.11
```

## About `./downloadAndCreateSymLinks.sh`

- This script will download various `vim` plugins and `oh-my-zsh` shell and its plugins in `<cloned_repo_dir>/downloaded` directory.
- This will set your shell to `zsh`
- It will create various symlinks from your `homedir` to `<cloned_repo_dir>` e.g `.vimrc`, `.zshrc`, `.zprofile` etc.
- Run `ls -la $HOME` command to see what is being symlinked.
- Compiles `nnn` (terminal file browser)
- creates various shell functions.
- Script is idempotent and can be run repeatedly without any harm

## How to remove the whole thing

- Run `ls -la $HOME` command to see what is being symlinked to `<cloned_repo_dir>` directory and make a note of it.
- Change your shell and Remove `<cloned_repo_dir>` directory.
- Remove symlinks noted above.
- Brew packages can be uninstalled using brew command.

## How to remove vim plugins

- Method-1: Remove vim plugin directory from `<cloned_repo_dir>/downloaded/vim-plugins` location and restart VIM. You can re-install this plugin by just running `./downloadAndCreateSymLinks.sh` script again.
- Method-2: Alternatively remove the vim-plugin entry in `./downloadAndCreateSymLinks.sh` (inside `downloadVimPlugins`) and run `./downloadAndCreateSymLinks.sh` again. It will remove the vim-plugin

## How to add new vim plugin

- Add the git repo of vim plugin in `./downloadAndCreateSymLinks.sh` script where you see all the vim plugins list (inside `downloadVimPlugins` function).

## What do you get from this

- Colourful `ls` output.
- Soothing terminal, vim and tmux theme (base16_gruvbox)
- `git diff` is more colourful
- `zsh` default command line mode is `vi`.
  - To edit a long command in terminal more effectively, press `<ESC>vv`. This will open `vim` where you can edit command and exit when done.
- Run `base16<tab><tab>` to set more terminal themes.
- `tmux` tricks
  - In `tmux`, run `ctrl+b g` to capture the entire session in current pane. A timestamped file will be created in your home directory. `ctrl+b g` will create new file everytime.
  - If using `tmux`, then it will show you active and inactive tmux panes.
  - If using `tmux`, you can search for words in the terminal and scroll/copy/select in terminal using `vi` keys.
  - Move `tmux panes` easily among `tmux windows`.
    - Use `ctrl+b m` to mark the pane you want to move to another tmux window.
    - Switch to the desired tmux window by pressing `ctrl+b <tmux window number>`.
    - Now press `ctrl+b [h|j|k|l]` to bring marked pane here. `h, j, k, l` keys are taken from `vim` motion keys.
    - `h` => to the left of current pane, `j` => to the bottom, `k` => to the top, `l` => to the right
- In a `git` repo directory, run `git fuzzy log` to browse and search git history in nicer way. Use `Shift-<up|down arrow>` to scroll up and down.
- `ctrl+r` will give you nicer command history.
- `nnn` a nice icon based terminal file-browser (aliased to n). just run `n` to play with it and `q` to quit.
  - `nnn` has its own 4 tabs. Each tab maintains its own state.
  - `nnn` is highly customizable. You can launch programs and can write your own plugins.
  - press `.` to toggle hidden files, and `t` to sort by time. Get help with `?`
  - use `vim` keys to navigate and search (`h`, `j`, `k`, `l`, `/`)
- Command prompt with icons (You might not see icons properly in the browser)

```
╭─gpal@gpal-mac ~/dotfiles ‹שׂ master|✚1› ‹ 2.6.3› ‹🐍 venv_terraform_cdk› ‹ 3.9.7› ‹⬢ 16.10.0› ‹ﴱ kubernetes-context› ‹ OCI_profile›
╰─$
╭─gpal@gpal-mac ~/dotfiles ‹שׂ master|✚1› ‹ ruby_version› ‹🐍 py_virtualenv_name› ‹ py_version› ‹⬢ nodejs_version› ‹ﴱ kubernetes-context› ‹ OCI_profile›
╰─$
```

- `vim` tricks

  - Uses `vim` built-in plugin manager
  - `CoC` plugin gives you `vscode` like customization features for development.
    - e.g Install `python` support in `vim` by running `:CocInstall coc-pyright` and so on.
  - Open `nnn` file browser inside `vim` by `<spacebar> n`, making `vim` like IDE.
    - Use `ctrl+v` to open file in vertical split and `ctrl+s` to open file in horizontal split.
  - Open pop up terminal inside `vim` by pressing `<spacebar>fn`. Toggle the presence of pop-up terminal by pressing `<spacebar>ft`.
  - Editing file in `git` in `vim` will give inform you about what lines are added (showing `+` sings), deleted (showing `-` signgs) and changed (showing `~` signs).
    - You can revert these changes by pressing `<spacebar>hu`.
  - `vim` shows light vertical indent lines.
  - Look for `nnn`, `fzf`, `gitgutter` and `floatterm` vim plugins documentation for more tricks.

- `nvim` tricks
  - Most of the plugins used in `nvim` are `lua` based, hence `nvim` is fast.
  - Inside `nvim` press `<ALT>e` to open file explorer. In `MacOS` press `<right option>e`. See at the end, how to set your iterm-2 right option key as `<ALT>` key.
    - press `g?` for nvim-tree help
  - Press `<spacebar>tt` to open `nvim telescope`. You can search a number of items in telescope. e.g grep in all files.
    - Press `<C-t>` to open search results in nvim `trouble` `quickfix` list.
    - Press `<C-q>` to open search results in traditional `quickfix` list.
    - By default `telescope` opens in directory where `nvim` was launched. This can be confirmed via running `:pwd` command.
      - `pwd` can be changed in number of ways.
        - first one is to use `:cd <tab><tab>`
        - Second one is to use `nnn`
          - Press `<spacebar>np` to launch `nnn` in a float window.
          - navigate via `arrow keys` or `hjkl` keys to reach desired directory.
          - press <spacebar> on the desired directory or file to select it.
          - Now press `<ALT-w>` to change the nvim working directory.
          - At this time `nnn` may switch to another folder, simply press `q` to quit.
          - confirm it by running `:pwd` command.
  - Press `<spacebar>tr` to resume the search in telescope where you left last time.
  - Git history of a file can be viewed.
  - Press `<C-\>c` to open a terminal in a pop-up window. (Floatterm)
    - `<C-\>z` to enlarge the pop-up window.
    - `<C-\>s` to small it.
    - `<C-\>l` to place it vertically on right.
    - `<C-\>h` to place it vertically on left.
    - `<C-\>j` to place it horizontally at bottom.
    - `<C-\>t` to toggle the visibility of floatterm
    - `<C-\>r` rotate among floating terminals
    - `<C-\><C-n>` to switch in `vim normal` mode in terminal.

## Warning

- `IndentLine` vim plugin does not show `json` files correctly. It does not show double-quotes due to a bug. You can disable this feature while editing json file by running command `:IndentLinesDisable` in vim

## Additional optional settings for Macos iterm2

### Keybaord

- `System Preference` -> `Keyboard` -> `key repeat` = `Fast (take the marker to extreme right)`
- `System Preference` -> `Keyboard` -> `Delay Until Repeat` = `Short (take the marker to extreme right)`

#### Even faster cursor in terminal and vim

- `defaults write NSGlobalDomain KeyRepeat -int 1`
- reboot required after running above command.
- Official setting is `2`
  Ref: https://stackoverflow.com/questions/4489885/how-can-i-increase-the-cursor-speed-in-terminal

### iterm2 settings

- `iterm2 Preferences` -> `General` -> `Selection Tab` -> check `Applications in Terminal may access clipboard`
- `iterm2 Preferences` -> `Profiles` -> Create new profile with name `DropDown` -> select `DropDown` -> `Text tab` -> set font to `MesloLGSDZ Nerd Font` -> `Regular` -> `15`
- `iterm2 Preferences` -> `Profiles` -> select `DropDown` -> `Window tab` -> `style => Maximized`, `Screen => Screen with Cursor`, `Space => current Space`
- `iterm2 Preferences` -> `Profiles` -> select `DropDown` -> `Keys Tab` -> `check => A hotkey opens a dedicated window in this profile`, `click => Configure Hotkey Window` -> `Set Hotkey to <option><Space>`, `check => Pin hotkey window (stays open on loss of keybaord focus)`, `check => Show this Hotkey window`
- `iterm2 Preferences` -> `Profiles` -> select `DropDown` -> `Keys Tab` -> `Left Option Key => Normal`, `click => apps can change this`, `Right Option Key => ESC+`
  - `Right Option Key => ESC+` allows right option key to be used as `<ALT>` key by applications. e.g `FZF` and `neovim`
