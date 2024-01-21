#!/bin/zsh

#
# Install Zchat.
#

# Determines the current user's shell, if not `zsh` then exit.
if [[ "$(basename -- "$SHELL")" != "zsh" ]]; then
  echo "Please switch to zsh shell to continue."
  exit 1
fi

# Check for Homebrew, else ask to install.
echo "\nZchat: Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "Zchat: Homebrew is missing and is required to install dependencies." >&2
  read -q "REPLY?Do you want to install Homebrew? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Zchat: Installing Homebrew..."
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
      echo "Failed to install Homebrew." >&2
      exit 1
    fi
    echo "Zchat: Updating Homebrew..."
    brew update
  else
    echo "Zchat: Homebrew installation aborted by the user. Homebrew is required to install Zchat dependencies." >&2
    exit 1
  fi
else
  echo "Zchat: Homebrew is already installed."
fi

# Check for jq, else ask to install.
echo "\nZchat: Checking for jq..."
if ! command -v jq &>/dev/null; then
  echo "jq is required for Zchat." >&2
  read -q "REPLY?Do you want to install jq using Homebrew? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Zchat: Installing jq dependency..."
    if ! brew install jq; then
      echo "Zchat: Failed to install jq." >&2
      exit 1
    fi
  else
    echo "Zchat: jq installation aborted by the user. jq is required for Zchat to function properly." >&2
    exit 1
  fi
else
  echo "Zchat: jq is already installed."
fi

# Defines the PATHs.
ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
ZCH_SCRIPT=${HOME}/zchat/script/zchat

# Check if zchat script exists and make it executable.
if [[ -f "${ZCH_SCRIPT}" ]]; then
  echo "\nZchat: Making script executable..."
  if ! chmod +x "${ZCH_SCRIPT}"; then
    echo "Failed to make the Zchat script executable." >&2
    exit 1
  fi
else
  echo "Zchat: Script not found." >&2
  exit 1
fi

# Update .zshrc with Zchat.
if [[ -f "$ZSHRC" ]]; then
  echo "\nZchat: Starting the installation process..."

  # Ask the user if they want to create a backup.
  read -q "REPLY?Found an existing .zshrc in ${ZSHRC}. Do you want to create a backup? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    # Backup existing file
    ZSHRC_BACKUP="${ZSHRC}_$(date "+%Y%m%d%H%M%S").bak"
    echo "Creating backup of .zshrc as ${ZSHRC_BACKUP}..."

    if cp "${ZSHRC}" "${ZSHRC_BACKUP}"; then
      echo "Zchat: Backup successful as ${ZSHRC_BACKUP}."
    else
      echo "\nZchat: Failed to backup .zshrc. Aborting operation." >&2
      exit 1
    fi
  else
    # If the response is not 'yes', proceed without creating a backup.
    echo "\nZchat: Proceeding without creating a backup."
  fi

  # Updates .zshrc with Zchat configurations.
  echo "\nZchat: Updating .zshrc..."
  ZCHAT_PATH_LINE="fpath=($HOME/zchat/script $fpath)"
  AUTOLOAD_LINE="autoload -Uz zchat"
  OPENAI_API_KEY="export OPENAI_API_KEY="
  OPENAI_GPT_MODEL="export OPENAI_GPT_MODEL=gpt-4-1106-preview"
  if ! grep -Fxq "${ZCHAT_PATH_LINE}" "${ZSHRC}" && ! grep -Fxq "${AUTOLOAD_LINE}" "${ZSHRC}"; then
    echo "" >> "${ZSHRC}"
    echo "# Zchat PATH." >> "${ZSHRC}"
    echo "${ZCHAT_PATH_LINE}" >> "${ZSHRC}"
    echo "${AUTOLOAD_LINE}" >> "${ZSHRC}"
    echo "" >> "${ZSHRC}"
    echo "# Zchat dependencies." >> "${ZSHRC}"
    echo "${OPENAI_API_KEY}" >> "${ZSHRC}"
    echo "${OPENAI_GPT_MODEL}" >> "${ZSHRC}"
    echo "Zchat: Appended PATH to ${ZSHRC}"
  else
    echo "Zchat: PATH is already present in ${ZSHRC}"
  fi
else
  # Creates a new .zshrc file if it doesn't exist.
  echo "\nZchat: .zshrc not found. Creating a new one..."
  if echo "" > "${ZSHRC}"; then
    echo "\nZchat: Adding PATH to a new .zshrc..."
    echo "# Zchat PATH." >> "${ZSHRC}"
    echo "${ZCHAT_PATH_LINE}" >> "${ZSHRC}"
    echo "${AUTOLOAD_LINE}" >> "${ZSHRC}"
    echo "" >> "${ZSHRC}"
    echo "# Zchat dependencies." >> "${ZSHRC}"
    echo "${OPENAI_API_KEY}" >> "${ZSHRC}"
    echo "${OPENAI_GPT_MODEL}" >> "${ZSHRC}"
    echo "Zchat: PATH was added to a new .zshrc."
  else
    echo "Zchat: Failed to create a new .zshrc." >&2
    exit 1
  fi
fi

# Attempts to reload .zshrc to apply changes
if ! source "${ZSHRC}" &>/dev/null; then
  echo "\nZchat: Failed to reload .zshrc. Please reload manually to apply changes." >&2
fi

# Prints a success message.
echo "\nZchat: Setup complete."
