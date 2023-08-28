#!/bin/sh

#
# Install Zchat
#

# Determines the current user's shell, if not `zsh` then exit.
if [[ "$(basename -- "$SHELL")" != "zsh" ]]; then
  echo "Please switch to zsh shell to continue."
  exit 1
fi

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
# Append the necessary lines to zshrc.
cat << EOF >> ${ZSHRC}
# Zchat path.
fpath=(~/zchat/script \$fpath)
autoload -Uz zchat

# Zchat dependencies.
# Only APIs with a history of successful payments can use the GPT-4 API.
# If you don't qualify for GPT-4, consider using GPT-3.5-Turbo model.
export OPENAI_API_KEY=""
export OPENAI_GPT_MODEL="gpt-4"
EOF
  echo 'zsh: appended Zchat's necessary lines to .zshrc'

  # Reloads shell.
  source "${ZSHRC}"
else
  echo 'zsh: zshrc not found!'
fi
