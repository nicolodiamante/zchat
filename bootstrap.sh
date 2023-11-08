#!/bin/zsh

# Determines the current user's shell.
[[ "$SHELL" == */zsh ]] || { echo "Please switch to zsh shell to continue."; exit 1; }

# Define paths.
SOURCE="https://github.com/nicolodiamante/zchat"
TARBALL="${SOURCE}/tarball/master"
TARGET="${HOME}/zchat"
TAR_CMD="tar -xzv -C \"${TARGET}\" --strip-components 1 --exclude .gitignore"
INSTALL="${TARGET}/utils/install.sh"

# Check if a command is executable.
is_executable() {
  command -v "$1" > /dev/null 2>&1
}

# Ensure TARGET directory doesn't already exist.
if [[ -d "$TARGET" ]]; then
  echo "Target directory $TARGET already exists. Please remove or rename it and try again."
  exit 1
fi

# Checks which executable is available then downloads and installs.
if is_executable "git"; then
  CMD="git clone ${SOURCE} \"${TARGET}\""
elif is_executable "curl"; then
  CMD="curl -L ${TARBALL} | ${TAR_CMD}"
elif is_executable "wget"; then
  CMD="wget --no-check-certificate -O - ${TARBALL} | ${TAR_CMD}"
else
  echo 'No git, curl, or wget available. Aborting!'
  exit 1
fi

echo 'Installing Zchat...'

# Create the target directory and proceed with the chosen download method.
mkdir -p "${TARGET}" || { echo "Error: Failed to create target directory. Aborting!" >&2; exit 1; }

# Execute the download command and run the installation script.
if eval "${CMD}"; then
  cd "${TARGET}" && source "${INSTALL}" || { echo "Error: Failed to navigate to ${TARGET} or run the install script. Aborting!" >&2; exit 1; }
else
  echo "Download failed. Aborting!" >&2
  exit 1
fi
