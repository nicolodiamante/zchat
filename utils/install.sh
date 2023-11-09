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
if ! command -v brew &>/dev/null; then
  echo 'Homebrew is missing and is required to install dependencies.' >&2
  read -q "REPLY?Do you want to install Homebrew? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo 'Installing Homebrew...'
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
      echo "Failed to install Homebrew." >&2
      exit 1
    fi
    echo 'Updating Homebrew...'
    brew update
  else
    echo "Homebrew installation aborted by the user. Homebrew is required to install Zchat dependencies." >&2
    exit 1
  fi
else
  echo 'Homebrew is already installed.'
fi

# Check for jq, else ask to install.
echo 'Checking for jq...'
if ! command -v jq &>/dev/null; then
  echo 'jq is required for Zchat.' >&2
  read -q "REPLY?Do you want to install jq using Homebrew? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo 'Installing jq dependency...'
    if ! brew install jq; then
      echo "Failed to install jq." >&2
      exit 1
    fi
  else
    echo "jq installation aborted by the user. jq is required for Zchat to function properly." >&2
    exit 1
  fi
else
  echo 'jq is already installed.'
fi

# Defines the PATH for the .zshrc.
ZSHRC="${XDG_CONFIG_HOME:-$HOME}/.zshrc"

# Check if zchat script exists and make it executable.
if [[ -f "${HOME}/zchat/script/zchat" ]]; then
  echo "Making Zchat script executable..."
  if ! chmod +x "${HOME}/zchat/script/zchat"; then
    echo "Failed to make the Zchat script executable." >&2
    exit 1
  fi
else
  echo "The Zchat script does not exist at ${HOME}/zchat/script/zchat." >&2
  exit 1
fi

# Backup .zshrc before updating.
if [[ -f "$ZSHRC" ]]; then
  BACKUP="${ZSHRC}.bak_$(date +%F-%H%M%S)"
  echo "Backing up .zshrc..."
  if ! cp "${ZSHRC}" "${BACKUP}"; then
    echo "Failed to backup .zshrc." >&2
    exit 1
  else
    echo "Backup of .zshrc saved as ${BACKUP}."
  fi
else
  echo "No .zshrc file found to backup." >&2
  exit 1
fi

# Update .zshrc.
if ! grep -q "fpath=(${HOME}/zchat/script" "${ZSHRC}"; then
  if [[ -f "$ZSHRC" ]]; then
    cat << EOF >> "${ZSHRC}"

# Zchat PATH.
fpath=(${HOME}/zchat/script \$fpath)
autoload -Uz zchat

# Zchat dependencies.
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
