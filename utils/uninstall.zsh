#!/bin/zsh

#
# Uninstall Zchat.
#

echo "Starting the uninstallation process of Zchat..."

# Define the .zshrc PATH.
ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
ZSHRC_BACKUP_GLOB="${ZSHRC}_*.bak"

# Function to remove Zchat configurations.
remove_zchat_config() {
  echo "\nZchat: Checking for existing configuration in .zshrc..."

  local ZCHAT_PATH_LINE="fpath=($HOME/zchat/script $fpath)"
  local AUTOLOAD_LINE="autoload -Uz zchat"

  if grep -Fxq "${ZCHAT_PATH_LINE}" "${ZSHRC}" || grep -Fxq "${AUTOLOAD_LINE}" "${ZSHRC}"; then
    read -q "REPLY?Zchat configurations found in .zshrc. Do you want to remove them? [y/N] "
    echo ""
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' '/# Zchat PATH./d' "${ZSHRC}"
        sed -i '' "/fpath=($HOME\/zchat\/script $fpath)/d" "${ZSHRC}"
        sed -i '' '/autoload -Uz zchat/d' "${ZSHRC}"
        sed -i '' '/# Zchat dependencies./d' "${ZSHRC}"
        sed -i '' "/export OPENAI_API_KEY=/d" "${ZSHRC}"
        sed -i '' '/export OPENAI_GPT_MODEL="gpt-4-1106-preview/d' "${ZSHRC}"
      else
        sed -i '/# Zchat PATH./d' "${ZSHRC}"
        sed -i "/fpath=($HOME\/zchat\/script $fpath)/d" "${ZSHRC}"
        sed -i '/autoload -Uz zchat/d' "${ZSHRC}"
        sed -i '/# Zchat dependencies./d' "${ZSHRC}"
        sed -i "/export OPENAI_API_KEY=/d" "${ZSHRC}"
        sed -i '/export OPENAI_GPT_MODEL="gpt-4-1106-preview/d' "${ZSHRC}"
      fi
      echo "Zchat: Configurations have been removed from .zshrc."
    else
      echo "Zchat: No changes made to .zshrc."
    fi
  else
    echo "Zchat: No configurations found in .zshrc."
  fi
}

# Check for .zshrc and back it up before making changes.
if [[ -f "$ZSHRC" ]]; then
  # Look for the most recent backup.
  backups=($(ls -t $ZSHRC_BACKUP_GLOB 2>/dev/null))
  if [[ ${#backups[@]} -gt 0 ]]; then
    latest_backup="${backups[0]}"
    echo "Zchat: Latest backup found at ${latest_backup}."
    read -q "REPLY?Do you want to restore from the latest backup? [y/N] "
    echo ""
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      # Restore the latest backup.
      if cp "${latest_backup}" "${ZSHRC}"; then
        echo "Zchat: Restored .zshrc from the latest backup."
        exit 0
      else
        echo "Zchat: Failed to restore .zshrc from the latest backup." >&2
        exit 1
      fi
    else
      remove_zchat_config
    fi
  else
    remove_zchat_config
  fi
else
  echo "\nZchat: .zshrc not found. No cleanup needed."
fi

# Ask the user if they want to uninstall jq.
echo "\nZchat: Uninstalling jq may affect other applications."
read -q "REPLY?Do you want to uninstall jq? [y/N] "
echo ""
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo "Zchat: Uninstalling jq..."
  brew uninstall jq
  echo "Zchat: jq uninstalled."
fi

# Ask the user if they want to uninstall Homebrew.
echo "\nZchat: Uninstalling Homebrew may affect other applications and remove all packages installed through it."
read -q "REPLY?Do you want to uninstall Homebrew? [y/N] "
echo ""
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo "Zchat: Uninstalling Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
  echo "Zchat: Homebrew uninstalled."
fi

# Prints a success message.
echo "\nZchat: Uninstall complete."
