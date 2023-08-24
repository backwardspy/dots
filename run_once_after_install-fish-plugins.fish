#!/usr/bin/env fish
set fisher_url https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish
curl -sL $fisher_url | source
fisher update
