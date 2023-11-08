#!/bin/zsh

# Uninstall Zchat

echo "Starting the uninstallation process of Zchat..."

# Define PATHs.
SCRIPT_DIR="${HOME}/zchat/script"
ZSHRC="${XDG_CONFIG_HOME:-$HOME}/.zshrc"

# Remove the Zchat script directory.
if [[ -d "$SCRIPT_DIR" ]]; then
  echo "Removing the Zchat script directory..."
  rm -rf "$SCRIPT_DIR"
else
  echo "Zchat script directory not found. It may have already been removed."
fi

# Check for .zshrc and back it up before making changes.
if [[ -f "$ZSHRC" ]]; then
  echo "Found .zshrc at ${ZSHRC}."
  echo "Backing up .zshrc..."
  cp "$ZSHRC" "${ZSHRC}.bak_$(date +%F-%H%M%S)" && echo "Backup saved as ${ZSHRC}.bak_$(date +%F-%H%M%S)."

  # Prompt the user before removing Zchat configurations.
  read -q "REPLY?Do you want to remove Zchat configurations from .zshrc? [y/N] ";
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    # Use 'sed' to remove lines related to Zchat.
    # Check if we are on macOS or Linux and adjust the sed command accordingly.
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' '/# Zchat path./d' "$ZSHRC"
      sed -i '' "/fpath=\(${SCRIPT_DIR//\//\\/} \$fpath\)/d" "$ZSHRC"
      sed -i '' '/autoload -Uz zchat/d' "$ZSHRC"
      sed -i '' '/export OPENAI_API_KEY=""/d' "$ZSHRC"
      sed -i '' '/export OPENAI_GPT_MODEL="gpt-4"/d' "$ZSHRC"
    else
      sed -i '/# Zchat path./d' "$ZSHRC"
      sed -i "/fpath=\(${SCRIPT_DIR//\//\\/} \$fpath\)/d" "$ZSHRC"
      sed -i '/autoload -Uz zchat/d' "$ZSHRC"
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
  read -q "REPLY?Do you want to uninstall the 'jq' package installed by Homebrew? [y/N] ";
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    brew uninstall jq && echo "'jq' has been uninstalled."
  else
    echo "The 'jq' package will remain installed."
  fi
fi

echo "Uninstallation of Zchat is complete."
