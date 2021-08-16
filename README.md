# dotFiles
## Following tools must be installed on system.

* tmux
* pcre
* fd
* bat
* fzf
* ripgrep
* zsh (is being installed as part of script. oh-my-zsh will be installed overriding default system zsh)
* vim => 8.0
* perl
* greadlink (part of coreutils)
* git
* tree
* mktemp
* exa (for git fuzzy)
* delta (for git diff)
* lsd (ls with icons, not being used at the moment)
* nnn (cmd file manager with icons, is being compiled and installed as part of download script)
* font-meslo-lg-nerd-font (set iterm2 font: "MesloLGSDZ Nerd Font", font-style: regular, font-size: 15)
* nvm to install node (node is used by vim COC plugin)

```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
brew install tmux pcre fd bat fzf ripgrep vim coreutils git tree delta lsd nvm
nvm install node
git clone https://github.com/spareslant/dotFiles.git
cd dotFiles
./downloadAndCreateSymLinks.sh
cd downloaded/vim-plugins/coc.nvim
npm install esbuild
npm run build

# Open a new terminal session and run following command
base16_gruvbox-dark-hard
```

## Additional Settings
### Keybaord
* `System Preference` -> `Keyboard` -> `key repeat` = `Fast (take the marker to extreme right)`
* `System Preference` -> `Keyboard` -> `Delay Until Repeat` = `Short (take the marker to extreme right)`

### iterm2 settings
* `iterm2 Preferences` -> `General` -> `Selection Tab` -> check `Applications in Terminal may access clipboard`
* `iterm2 Preferences` -> `Profiles` -> Create new profile with name `DropDown` -> select `DropDown` -> `Text tab` -> set font to `MesloLGSDZ Nerd Font` -> `Regular` -> `15`
* `iterm2 Preferences` -> `Profiles` -> select `DropDown` -> `Window tab` -> `style => Maximized`, `Screen => Screen with Cursor`, `Space => current Space`
* `iterm2 Preferences` -> `Profiles` -> select `DropDown` -> `Keys Tab` -> `check => A hotkey opens a dedicated window in this profile`, `click => Configure Hotkey Window` -> `Set Hotkey to <option><Space>`,  `check => Pin hotkey window (stays open on loss of keybaord focus)`, `check => Show this Hotkey window`
