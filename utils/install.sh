#!/bin/sh

#
# Install zchat
#

# Determines the current user's shell, if `zsh` then installs.
[[ "$(basename -- "$SHELL")" == "zsh" ]] || exit 1

# Check for Homebrew, else install.
echo 'Checking for Homebrew...'
if ! command -v brew >/dev/null; then
  echo 'Brew is missing! Installing it...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check for jq, else install.
if ! command -v jq >/dev/null; then
  echo 'zchat: jp dependency is missing! Installing it...'
  brew install jq
fi

# Defines the PATHs.
SCRIPT="${HOME}/zchat/script"
ZSHRC="${ZDOTDIR:-${XDG_CONFIG_HOME/zsh:-$HOME}}/.zshrc"

# Make script executable.
zchatat="${0:h}/script/zchat"
chmod +x $zchat

if [[ -d "$SCRIPT" && -f "$ZSHRC" ]]; then
  # Appends to `zshrc`.
  cat << EOF >> ${ZSHRC}
# Zchat path.
fpath=(~/zchat/script \$fpath)
autoload -Uz zchat

# Zchat dependencies.
export OPENAI_API_KEY=""
export OPENAI_GPT_MODEL="gpt-3.5-turbo"
EOF
  echo 'zsh: appended zchat to zshrc.'

  # Reloads shell.
  source "${ZSHRC}"
else
  echo 'zsh: zshrc not found!'
fi
