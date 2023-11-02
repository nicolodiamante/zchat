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
  echo 'zchat: jq dependency is missing! Installing it...'
  brew install jq
fi

# Defines the PATHs.
SCRIPT="${HOME}/zchat/script"
ZSHRC="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME}/zsh}/.zshrc"

# Make script executable.
zchat="${0:h}/script/zchat"
chmod +x $zchat

# Only append to zshrc if the necessary lines are not present already.
if ! grep -q "fpath=(~/zchat/script" "${ZSHRC}"; then
  if [[ -f "$ZSHRC" ]]; then
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
    echo "zsh: appended Zchat's necessary lines to .zshrc"
  else
    echo 'zsh: zshrc not found!'
  fi
else
  echo "zsh: Zchat's lines already present in .zshrc"
fi

# Reminder for the user.
echo "Remember to insert your OPENAI_API_KEY in ~/.zshrc and then either source it or open a new terminal session."
