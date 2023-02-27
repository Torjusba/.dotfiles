#/bin/bash
stow -D .
stow --ignore="(.*bootstrap.*)|symlink.sh" .
