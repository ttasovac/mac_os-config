# Manual setups

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Manual setups](#manual-setups)
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

## SSH keys

- `ssh-keygen -t ed25519 -C "ttasovac+2025@humanistika.org"`
- `ssh-keygen -t ed25519 -C "ttasovac+2025@humanistika.org"`
- filename: `ttasovac+2025@humanistika.org` (pub will have .pub)
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

- `ssh-add --apple-use-keychain ~/.ssh/ttasovac+2025@humanistika.org`g

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
  - change user to `ttasovac`, and listen to `127.0.0.1:9084`
- `code /opt/homebrew/etc/php/8.3/php-fpm.d/www.conf`
  - change user to `ttasovac`, and listen to `127.0.0.1:9083`
- `code /opt/homebrew/etc/php/8.2/php-fpm.d/www.conf`
  - change user to `ttasovac`, and listen to `127.0.0.1:9082`
- `code /opt/homebrew/etc/php/8.1/php-fpm.d/www.conf`
  - change user to `ttasovac`, and listen to `127.0.0.1:9081`
- `code /opt/homebrew/etc/php/8.0/php-fpm.d/www.conf`
  - change user to `ttasovac`, and listen to `127.0.0.1:9080`
- `code /opt/homebrew/etc/php/7.4/php-fpm.d/www.conf`
  - change user to `ttasovac`, and listen to `127.0.0.1:9074`
- set 8.4 as default for now:
  - `brew unlink php`
  - `brew link --overwrite --force php@8.4`
  - `brew services start php@8.4`
- dotfiles should already have aliases for each of the versions php74, php80 etc. and function `phpv` to switch.

Still todo: set up a cron task to clear php-fmp logs. See [here](https://kevdees.com/how-to-clear-php-fpm-logs-daily-on-macos/).

## Nginx

- `sudo nginx` to start
- `sudo nginx -s stop`   # Signal the main process to stop
- `sudo nginx -s reload` # Signal the main process to reload configuration
- check <http://localhost:8080>
- `cp ~/Development/ttasovac/dotfiles/nginx/nginx.conf /opt/homebrew/etc/nginx/nginx.conf`
- `cp ~/Development/ttasovac/dotfiles/nginx/index.php /opt/homebrew/var/www/index.php`
- `rm /opt/homebrew/var/www/index.html`
- `mkdir /opt/homebrew/etc/nginx/servers`
- `mkdir /opt/homebrew/etc/nginx/ssl`
- `sudo nginx -s reload`
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
- change keyboard selection to cmd-space, and next: ctrl-command space
- change spotlight to option space
- install Mellel
- set up Bartender
- maybe install X (doesn't work with mas install at the moment because it's an iPad app)
