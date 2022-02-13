#!/bin/bash
set -x

USER_NAME=${USER_NAME:pdfbox}
USER_ID=${UID:-1000}
GROUP_ID=${GID:-1000}

usermod -u "$USER_ID" -o "$USER_NAME"
groupmod -g "$GROUP_ID" "$USER_NAME"

exec sudo -u "$USER_NAME" "$@"

