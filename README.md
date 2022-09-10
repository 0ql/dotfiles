## dotfiles
Personal Dotfiles with an added install script.

### Stack

- **Hyprland** as the WM
- **Kitty** as the terminal emulator
- **NeoVim** as the texteditor
- **Wofi** a dmenu/rofi-like window switcher and application launcher
- **Starship** prompt
- **zsh** as the shell

### install.sh
Basically copies over all config files and their according positions within the file system. Don't run as root. Optionally auto install software (available only on arch).

### install-archiso-x86_64-uefi.sh
Ideally suited to run on a bare bones Arch ISO to set up a virtual machine (as it doesn't create a swap file).

### Some commands

To download install-archiso-x86_64-uefi file
```bash
curl -O https://raw.githubusercontent.com/0ql/dotfiles/master/install-archiso-x86_64-uefi.sh
wget https://raw.githubusercontent.com/0ql/dotfiles/master/install-archiso-x86_64-uefi.sh
curl -O https://0ql.dev/install-archiso-x86_64-uefi.sh
wget https://0ql.dev/install-archiso-x86_64-uefi.sh
```

To clone the repo with `git`
```bash
git clone https://github.com/0ql/dotfiles
```

### Known Issues

[telescope grep not working](https://github.com/nvim-telescope/telescope.nvim/issues/506)
