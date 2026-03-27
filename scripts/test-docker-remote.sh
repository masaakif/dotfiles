#!/usr/bin/env bash

# Exit on error
set -e

# Change to repository root
cd "$(dirname "$0")/.." || exit 1

echo "=========================================================="
echo " Starting fresh Debian container for remote dotfiles testing..."
echo "=========================================================="
echo " - A new user 'tester' will be created."
echo " - Your dotfiles will be cloned from GitHub directly."
echo " - bootstrap.sh will be executed automatically."
echo " - When you exit the shell, the container will be destroyed."
echo "=========================================================="
echo ""

# Run docker container interactively, removing it automatically when done
# We do not mount the local directory, everything is cloned from GitHub.
docker run --rm --init -it \
  debian:bookworm-slim \
  bash -c "
    export GITHUB_TOKEN=${GITHUB_TOKEN}
    echo '[1/5] Installing minimal prerequisites...'
    apt-get update -qq && apt-get install -qq -y --no-install-recommends \
	    procps sudo curl git tzdata xz-utils unzip \
	    libreadline-dev ca-certificates build-essential >/dev/null 2>&1
    rm -rf /var/lib/apt/lists/*

    echo '[2/5] Setting up test user...'
    useradd -m -s /bin/bash tester
    echo 'tester ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/tester

    echo '[3/5] Cloning dotfiles from GitHub (develop branch)...'
    su - tester -c 'git clone -b develop https://github.com/masaakif/dotfiles.git ~/dotfiles'

    echo '[4/5] Running bootstrap.sh as tester...'
    su - tester -c 'cd ~/dotfiles && bash scripts/bootstrap.sh'
   
    echo '[5/5] Running doctor.sh to verify setup...'
    su - tester -c 'cd ~/dotfiles && ~/.local/bin/mise run doctor'

    echo -e '\n\n✅ Setup complete! Entering shell as tester... (Type exit to destroy this container)'
    su - tester
  "
