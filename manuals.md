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

- brew services start mysql
- brew services list
- mysql_secure_installation

In case of problems, make sure with running via sock, make sure you:

- stop the service
- `brew unlink mysql`
- `brew uninstall mysql`
- `rm -rf /opt/homebrew/var/mysql`
- `rm /opt/homebrew/etc/my.cnf`
- `brew install mysql`

## Misc

- activate Cyrillic and Yiddish QWERTZ keyboards
- change keyboard selection to cmd-space, and next: ctrl-command space
- change spotlight to option space
- install Mellel
- maybe install X (doesn't work with mas install at the moment because it's an iPad app)
