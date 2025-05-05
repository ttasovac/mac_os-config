# Manual setups

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Manual setups](#manual-setups)
  - [Before install](#before-install)
  - [zsh](#zsh)
  - [Full access](#full-access)
  - [fish](#fish)
  - [SSH keys](#ssh-keys)
  - [mysql](#mysql)
  - [PHP](#php)
  - [Nginx](#nginx)
  - [Dnsmasq](#dnsmasq)
  - [Mailpit](#mailpit)
  - [Redis](#redis)
  - [Issues with tide](#issues-with-tide)
  - [Misc](#misc)

<!-- /code_chunk_output -->

## Before install

- Install Github Desktop
  - sign in
  - clone notes
- Install VSCode
  - turn on cloud changes
  - sign in with github

## zsh

to make the rest of the script finish, we need this after installing brew

`export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc`

## Full access

- give Terminal app full access to disk in Privacy & Confidentiality / Disk Access (otherwise Safari, Mail etc. defualts won't write)

## fish

- make sure you manually set the font in Terminal to MesloLGS NF Regular (will be installed with shells)
- issue at dariahmini was probably because i didn't turn fish_variables.snapshot into fish_variables. try that first. if it doesn't work, then:
- configure tide manually
- symlink manually
- all of the above before install_shell

## SSH keys

- `ssh-keygen -t ed25519 -C "ttasovac+2025@humanistika.org"`
- `ssh-keygen -t ed25519 -C "ttasovac+2025@dariahmini"`
- `ssh-keygen -t ed25519 -C "platan+2025@dariahmini"`
- filename: `ttasovac+2025@humanistika.org` (pub will have .pub); make sure it's saved inside .ssh
- enter passphrase
- `open ~/.ssh/config`  to check if config file exists; if not:
- `touch ~/.ssh/config`
- add to config:
  
  ```config
  Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  User ttasovac
  IdentityFile ~/.ssh/ttasovac+2025@humanistika.org
  ```

- `ssh-add --apple-use-keychain ~/.ssh/ttasovac+2025@humanistika.org`

- `gh auth status`
- if logged in, gh auth logout
- `gh auth login -p ssh`
- follow instructions and copy pub key
- `gh auth status`
- `gh repo list`
- i have a script check in bash and fish configs to make sure that the ssh agent is running

## mysql

- `brew services start mysql@8.4`
- `brew services list`
- `ln -s /opt/homebrew/opt/mysql@8.4 /opt/homebrew/opt/mysql`
- `code /opt/homebrew/etc/my.cnf`:
  
  ```sql
  [mysqld]
  # Only allow connections from localhost
  bind-address = 127.0.0.1
  mysqlx-bind-address = 127.0.0.1
  mysql_native_password=ON
  ```  

- `mysql_secure_installation`

In case of sock problems, make sure you:

- `brew service stop mysql`
- `brew unlink mysql`
- `brew uninstall mysql`
- `rm -rf /opt/homebrew/var/mysql`
- `rm /opt/homebrew/etc/my.cnf`
- `brew install mysql`

## PHP

- `code /opt/homebrew/etc/php/8.4/php-fpm.d/www.conf`
  - change user to `ttasovac`, and group to `staff`, and listen to `127.0.0.1:9084`
- `code /opt/homebrew/etc/php/8.3/php-fpm.d/www.conf`
  - change user to `ttasovac`, and group to `staff`, and listen to `127.0.0.1:9083`
- `code /opt/homebrew/etc/php/8.2/php-fpm.d/www.conf`
  - change user to `ttasovac`, and group to `staff`, and listen to `127.0.0.1:9082`
- `code /opt/homebrew/etc/php/8.1/php-fpm.d/www.conf`
  - change user to `ttasovac`, and group to `staff`, and listen to `127.0.0.1:9081`
- `code /opt/homebrew/etc/php/8.0/php-fpm.d/www.conf`
  - change user to `ttasovac`, and listen to `127.0.0.1:9080`
- `code /opt/homebrew/etc/php/7.4/php-fpm.d/www.conf`
  - change user to `ttasovac`, and group to `staff`, and listen to `127.0.0.1:9074`
- set 8.4 as default for now:
  - `brew unlink php`
  - `brew link --overwrite --force php@8.4`
  - `brew services start php@8.4`
- current raskovnik requires `brew services start php@7.4`
- dotfiles should already have aliases for each of the versions php74, php80 etc. and function `phpv` to switch.

Still todo: set up a cron task to clear php-fmp logs. See [here](https://kevdees.com/how-to-clear-php-fpm-logs-daily-on-macos/).

## Nginx

- `sudo brew services start nginx` to start
- `sudo brew services stop nginx`   # Signal the main process to stop
- `sudo brew services restart nginx` # Signal the main process to reload configuration
- check <http://localhost:8080>
- `cp ~/Development/ttasovac/dotfiles/nginx/nginx.conf /opt/homebrew/etc/nginx/nginx.conf`
- `cp ~/Development/ttasovac/dotfiles/nginx/index.php /opt/homebrew/var/www/index.php`
- `rm /opt/homebrew/var/www/index.html`
- `mkdir /opt/homebrew/etc/nginx/servers` ! file exists!
- `mkdir /opt/homebrew/etc/nginx/ssl`
- `sudo nginx -s reload`
- check <http://localhost>
- To also start on system boot, `sudo brew services start nginx`
  
  ```shell
  sudo brew services start nginx     ✔   stable
  Warning: Taking root:admin ownership of some nginx paths:
    /opt/homebrew/Cellar/nginx/1.27.4/bin
    /opt/homebrew/Cellar/nginx/1.27.4/bin/nginx
    /opt/homebrew/opt/nginx
    /opt/homebrew/opt/nginx/bin
    /opt/homebrew/var/homebrew/linked/nginx
  This will require manual removal of these paths using `sudo rm` on
  brew upgrade/reinstall/uninstall.
  Warning: nginx must be run as non-root to start at user login!
  ==> Successfully started `nginx` (label: homebrew.mxcl.nginx)
  ```

I still didn't deal with SSL. Maybe [later](https://kevdees.com/install-nginx-amp-multiple-php-versions-on-macos-15-sequoia/).

## Dnsmasq

- `echo 'address=/.test/127.0.0.1' >> /opt/homebrew/etc/dnsmasq.conf`
- `sudo mkdir -p /etc/resolver` (but it probably exists)
- `sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'`
- `sudo brew services start dnsmasq`

  ```shell
  Warning: Taking root:admin ownership of some dnsmasq paths:
    /opt/homebrew/Cellar/dnsmasq/2.90/sbin
    /opt/homebrew/Cellar/dnsmasq/2.90/sbin/dnsmasq
    /opt/homebrew/opt/dnsmasq
    /opt/homebrew/opt/dnsmasq/sbin
    /opt/homebrew/var/homebrew/linked/dnsmasq
  This will require manual removal of these paths using `sudo rm` on brew upgrade/reinstall/uninstall.
  ```
  
  - `ping test.test`

## Mailpit

If needed, see [here](https://kevdees.com/install-nginx-amp-multiple-php-versions-on-macos-15-sequoia/#mailpit).

## Redis

- `brew services start redis`

## Issues with tide

If there are issues with tide and fish_variables being constantly updated, despite `$HOME/.gitconfig`  and `$HOME/Development/ttasovac/dotfiles/fish.gitattributes` being set properly, do, in `dotfiles`:

```shell
- rm -rf*
- git reset --hard
```

then commit `fish_variables` once

## Misc

- activate Cyrillic and Yiddish QWERTZ keyboards
- install rsanu.dictionary from Dropbox to ttasovac/Library/Dictionaries; make sure it's readable by everybody
- change keyboard selection to cmd-space, and next: ctrl-command space
- change spotlight to option space
- set up Bartender
- allow screen sharing: Apple menu > System Settings > General > Общий экран
- maybe install X (doesn't work with mas install at the moment because it's an iPad app)
