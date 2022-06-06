## dotfiles
Personal Dotfiles with an added install script.

### Stack

- **Awesome** as the WM
- **Kitty** as the terminal emulator
- **NeoVim** as the texteditor
- **Rofi** a dmenu-like window switcher and application launcher
- **Starship** prompt
- **zsh** as the shell


### install.sh
Ideally suited to run on a bare bones Arch install. Should work on most GNU / Linux distros.

To clone the repo
```bash
git clone https://github.com/0ql/dotfiles.git
```

To update the repo
```bash
git pull
```

To install
```bash
bash install.sh
```

To update without confirm
```bash
bash install.sh -u
```

To install or update without overwriting .xinirc .profile .bashrc .bash_profile or installing required software
```bash
bash install.sh -n
```

To Update without confirm or overwiriting .xinitc .profile etc. (same as "bash install.sh -u -n")
```bash
up
```

### Known Issues

[telescope grep not working](https://github.com/nvim-telescope/telescope.nvim/issues/506)
