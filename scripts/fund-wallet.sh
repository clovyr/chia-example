#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]] ; then
    echo 'Usage: $0 <wallet address> [amount]'
    exit 0
fi

ADDRESS=${1}
AMOUNT=${2:-1}
curl -d "address=$ADDRESS&amount=$AMOUNT" "http://chia-testnet-faucet.wnext.app/send"
