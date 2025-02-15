# Manual setups

## SSH keys

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
