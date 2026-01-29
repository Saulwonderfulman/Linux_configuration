#!/bin/bash
PLAIN_DIR="$HOME/文档/Pho"
fusermount -u "$PLAIN_DIR"
rm -rf "$PLAIN_DIR"
