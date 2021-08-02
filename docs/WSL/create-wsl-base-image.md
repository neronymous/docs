# Create Base Linux Image

## Prerequisites

* WSL Windows feature installed
* Ubuntu installed

## 1. Patch and Prep

### a) Bootstrap OS

Open ubuntu and execute the following to patch/configure a base image:

```sh
# update OS
sudo apt update
sudo apt upgrade --assume-yes
sudo apt autoremove --assume-yes

# setup brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install common tools
brew install git gpg gcc
```

### b) Setup wsl.conf

Create (with sudo) an `/etc/wsl.conf` file with the following content:

```
[user]
default=nero

[automount]
enabled = true
mountFsTab = false

[network]
generateHosts = true
generateResolvConf = true
```


## 2. Customise Shell

### a) Install ZSH, oh-my-zsh and powerlevel9k theme

```sh
brew install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

### b) Configure ZSH

```sh
# enable brew
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile

mkdir -p  -m 700 ~/.ssh
mkdir -p ~/.config/zsh
rm ~/.zshrc
```

Create a new `~/.zshrc` with the following content:

```
export ZSH=$HOME/.oh-my-zsh
export ZDOTDIR=$HOME/.config/zsh

ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="yellow"
POWERLEVEL9K_DIR_HOME_BACKGROUND="037"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="cyan"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_STATUS_OK="false"

# OPTIONS
unsetopt NOMATCH

CASE_SENSITIVE="false"

# PLUGIN CONFIG
plugins=(
  docker
  docker-compose
  gpg-agent
  ssh-agent
)

source $ZSH/oh-my-zsh.sh
```

### c) Change Default Shell

```sh
command -v zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)

# reload shell
source ~/.zshrc
```


## 3. Cleanup Redundant/Temp Files

```sh
brew cleanup --prune=all -s
rm -rf $(brew --cache)
rm -rf ~/.landscape
rm ~/.bash* ~/.profile ~/.motd_shown ~/.zcompdump-* ~/.zsh_history
```


## 4. Export Image to File

Open a command prompt and execute the following, replacing the ISO date with today's date.

```bat
wsl --export <DISTRO> ./<DISTRO>-base-YYYY-MM-DD.tar.gz
```


## 5. Cleanup

```bat
wsl --unregister <DISTRO>
```
