# Manual setups

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

- `ssh-add --apple-use-keychain ~/.ssh/ttasovac+2025@humanistika.org`

- `gh auth status`
- if logged in, gh auth logout
- `gh auth login -p ssh`
- follow instructions and copy pub key
- `gh auth status`
- `gh repo list`
- i have a script check in bash and fish configs to make sure that the ssh agent is running

## mysql

- `brew services start mysql`
- `brew services list`
- `mysql_secure_installation`

In case of sock problems, make sure you:

- `brew service stop mysql`
- `brew unlink mysql`
- `brew uninstall mysql`
- `rm -rf /opt/homebrew/var/mysql`
- `rm /opt/homebrew/etc/my.cnf`
- `brew install mysql`

# PHP

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
- set 7.4 as default for now:
  - `brew unlink php`
  - `brew link --overwrite --force php@7.4`
  - `brew services start php@7.4`
- dotfiles should already have aliases for each of the versions php74, php80 etc.

## Misc

- activate Cyrillic and Yiddish QWERTZ keyboards
- change keyboard selection to cmd-space, and next: ctrl-command space
- change spotlight to option space
- install Mellel
- maybe install X (doesn't work with mas install at the moment because it's an iPad app)
