#!/bin/zsh

#
# Uninstall Zchat.
#

echo "Starting the uninstallation process of Zchat..."

# Defines the PATHs.
SCRIPT_DIR="${HOME}/zchat/script"
ZSHRC="${XDG_CONFIG_HOME:-$HOME}/.zshrc"
ZSHRC_BACKUP_GLOB="${ZSHRC}.bak_*"

# Check for .zshrc and back it up before making changes.
if [[ -f "$ZSHRC" ]]; then
  echo "Found .zshrc at ${ZSHRC}. Backing up .zshrc..."

  # Check for existing backups and offer to use the latest one.
  existing_backups=( $ZSHRC_BACKUP_GLOB )
  if (( ${#existing_backups[@]} > 0 )); then
    # Sort backups by date, descending.
    sorted_backups=($(echo "${existing_backups[@]}" | tr ' ' '\n' | sort -r))
    latest_backup=${sorted_backups[0]}
    echo "Latest backup found at ${latest_backup}."
    read -q "REPLY?Do you want to restore the latest backup instead of creating a new one? [y/N] "
    echo ""
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      # Restore the latest backup.
      if cp "$latest_backup" "$ZSHRC"; then
        echo "Restored .zshrc from the latest backup."
      else
        echo "Failed to restore .zshrc from the latest backup." >&2
        exit 1
      fi
    fi
  fi

  if [[ "$REPLY" =~ ^[Nn]$ ]] || [[ -z "$REPLY" ]]; then
    # If user chooses not to use the latest backup, create a new one.
    BACKUP="${ZSHRC}.bak_$(date +%F-%H%M%S)"
    if cp "$ZSHRC" "${BACKUP}"; then
      echo "Backup saved as ${BACKUP}."
    else
      echo "Failed to backup .zshrc." >&2
      exit 1
    fi
  fi

  # Prompt the user before removing Zchat configurations.
  read -q "REPLY?Do you want to remove Zchat configurations from .zshrc? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    # Use 'sed' to remove lines related to Zchat.
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' '/# Zchat PATH./d' "$ZSHRC"
      sed -i '' "/fpath=\(${SCRIPT_DIR//\//\\/} \$fpath\)/d" "$ZSHRC"
      sed -i '' '/autoload -Uz zchat/d' "$ZSHRC"
      sed -i '' '/# Zchat dependencies./d' "$ZSHRC"
      sed -i '' '/export OPENAI_API_KEY=""/d' "$ZSHRC"
      sed -i '' '/export OPENAI_GPT_MODEL="gpt-4"/d' "$ZSHRC"
    else
      sed -i '/# Zchat PATH./d' "$ZSHRC"
      sed -i "/fpath=\(${SCRIPT_DIR//\//\\/} \$fpath\)/d" "$ZSHRC"
      sed -i '/autoload -Uz zchat/d' "$ZSHRC"
      sed -i '/# Zchat dependencies./d' "$ZSHRC"
      sed -i '/export OPENAI_API_KEY=""/d' "$ZSHRC"
      sed -i '/export OPENAI_GPT_MODEL="gpt-4"/d' "$ZSHRC"
    fi
    echo "Zchat configurations have been removed from .zshrc."
  else
    echo "No changes made to .zshrc."
  fi
else
  echo ".zshrc file not found. No cleanup needed."
fi

# Ask the user if they want to remove the `jq` dependency installed by Homebrew.
if brew list jq &>/dev/null; then
  read -q "REPLY?Do you want to uninstall the 'jq' package installed by Homebrew? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    brew uninstall jq && echo "'jq' has been uninstalled."
  else
    echo "The 'jq' package will remain installed."
  fi
fi

echo "Uninstallation of Zchat is complete."
