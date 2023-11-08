#!/bin/zsh

#
# Install Zchat
#

# Determines the current user's shell, if not `zsh` then exit.
if [[ "$(basename -- "$SHELL")" != "zsh" ]]; then
  echo "Please switch to zsh shell to continue."
  exit 1
fi

# Check for Homebrew, else ask to install.
echo 'Checking for Homebrew...'
if ! command -v brew >/dev/null; then
  echo 'Homebrew is missing and is required to install dependencies.'
  read "confirm?Do you want to install Homebrew? (y/N) "
  if [[ $confirm == [yY]* ]]; then
    echo 'Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
      echo "Failed to install Homebrew."
      exit 1
    }
  else
    echo "Homebrew installation aborted by the user. Homebrew is required to install Zchat dependencies."
    exit 1
  fi
else
  echo 'Homebrew is already installed.'
fi

# Check for jq, else ask to install.
if ! command -v jq >/dev/null; then
  echo 'jq is required for Zchat.'
  read "confirm?Do you want to install jq using Homebrew? (y/N) "
  if [[ $confirm == [yY]* ]]; then
    echo 'Installing jq dependency...'
    brew install jq || {
      echo "Failed to install jq."
      exit 1
    }
  else
    echo "jq installation aborted by the user. jq is required for Zchat to function properly."
    exit 1
  fi
fi

# Defines the PATH for the .zshrc.
ZSHRC="${XDG_CONFIG_HOME:-$HOME}/.zshrc"

# Make the Zchat script executable.
chmod +x "${HOME}/zchat/script/zchat" || {
  echo "Failed to make the Zchat script executable."
  exit 1
}

# Backup .zshrc before updating.
if [[ -f "$ZSHRC" ]]; then
  cp "${ZSHRC}" "${ZSHRC}.bak" || { echo "Failed to backup .zshrc."; exit 1; }
fi

# Update .zshrc.
if ! grep -q "fpath=(${HOME}/zchat/script" "${ZSHRC}"; then
  if [[ -f "$ZSHRC" ]]; then
    cat << EOF >> "${ZSHRC}"
# Zchat path.
fpath=(${HOME}/zchat/script \$fpath)
autoload -Uz zchat

# Zchat dependencies.
# Only APIs with a history of successful payments can use the GPT-4 API.
# If you don't qualify for GPT-4, consider using GPT-3.5-Turbo model.
export OPENAI_API_KEY=""
export OPENAI_GPT_MODEL="gpt-4"
EOF
    echo "Appended Zchat's necessary lines to .zshrc"
  else
    echo 'Error: .zshrc not found!'
    exit 1
  fi
else
  echo "Zchat's lines are already present in .zshrc"
fi

# Reminder for the user.
echo "Remember to insert your OPENAI_API_KEY in ~/.zshrc and then either source it or open a new terminal session."
