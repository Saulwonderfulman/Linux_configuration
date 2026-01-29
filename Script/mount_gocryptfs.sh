#!/bin/bash

# Set up encrypted directories and mount point directories
CIPHER_DIR="$HOME/文档/.safe"
PLAIN_DIR="$HOME/文档/Pho"

# Check if the encrypted directory exists
if [ ! -d "$CIPHER_DIR" ]; then
    exit 1
fi

if [ ! -d "$PLAIN_DIR" ]; then
    mkdir -p "$PLAIN_DIR"
fi

# mount
# echo "Encrypted passwords are the most secure passwords"
gocryptfs "$CIPHER_DIR" "$PLAIN_DIR"

