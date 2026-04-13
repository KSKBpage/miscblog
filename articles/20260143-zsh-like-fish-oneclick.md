make zsh like fish in one paste script:

```md
#!/usr/bin/env bash
set -e

apt-get update
apt-get install -y git zsh curl

RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

cp ~/.zshrc ~/.zshrc.bak

sed -i 's/^#\?DISABLE_AUTO_UPDATE=.*/DISABLE_AUTO_UPDATE="true"/' ~/.zshrc
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="fishy"/' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(git zsh-syntax-highlighting zsh-autosuggestions z)/' ~/.zshrc

grep -q '^ZSH_AUTOSUGGEST_STRATEGY=' ~/.zshrc || echo 'ZSH_AUTOSUGGEST_STRATEGY=(history completion)' >> ~/.zshrc

cat << 'EOF' >> ~/.zshrc

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -U colors && colors
EOF

echo "Done. Restart shell or run: exec zsh"
```
