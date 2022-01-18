#!/usr/bin/env bash
set -euxo pipefail
sudo bash /home/clovyr/git/github.com/clovyr/chia-example/scripts/init-dns.sh
chia init
chia configure -t true
