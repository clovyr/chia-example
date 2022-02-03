# Developing on Chia with Clovyr Code

This guide introduces the main tools and processes you'll encounter when building with Chialisp. 

Each of these tools is already installed in this Clovyr Code environment. Go ahead, try them out! 
(`` CTRL+` `` to show/hide the terminal).

 - Chia CLI - `chia --help` - Interact with the chia network | [Full Reference](https://github.com/Chia-Network/chia-blockchain/wiki/CLI-Commands-Reference)
 - Chia Developer Tools - `cdv --help` - A suite of helpful tools | [Full Reference](https://github.com/Chia-Network/chia-blockchain/wiki/CLI-Commands-Reference)
 - CLVM Tools | [Full Reference](https://github.com/Chia-Network/clvm_tools)
    - `run --help` - Compile and execute chialisp to clvm 
    - `brun --help` - Execute clvm code, especially useful for local testing [Tips](https://chialisp.com/docs/high_level_lang)

## Getting Started

### Prequel
If you didn't run `chia start node` as described in the "Create and sync a wallet" section below within 24hours or so of opening your Clovyr Code for Chialisp environment, or if you stopped the node and left for a few days, your node is likely far behind the current blockheight. Catching up may take anywhere from 5-30 minutes. You can address this in a few ways:

If you have already authed to your own repo and begun working inside the Clovyr Code environment, or created keys and test mojos you want to keep using:
   1. Run `wget https://download-chia-net.s3-us-west-2.amazonaws.com/testnet10/blockchain_v1_testnet10.sqlite -O /home/clovyr/.chia/standalone_wallet/db/blockchain_v1_testnet10.sqlite` - this will redownload the latest testnet db
   2. Continue on to the "Create and sync a wallet" steps 

If you have only browsed and/or cloned repos, but not done the items above:
   1. Visit the [Clovyr Code for Chialisp]( https://clovyr.app/instant/code-chia) splash page and click "Destroy" next to your current environment
   2. Launch a fresh one


### Create and sync a wallet
The Clovyr Code environment comes with the testnet10 blockchain database pre-downloaded. The first step is to start the node, which will then connect to peers and download the latest activity since the last database image. Syncing to the current block height usually takes less than five minutes. 

1. `~/git/github.com/clovyr/chia-example/scripts/init.sh` - initialize Chia for the testnet
2. `chia start node` - start the node
   - `chia show -c` - view peers (more peers will be added over time)
   - `chia show -s` - view sync status 
3. `chia keys generate` - generate unique keys private to the user
4. `chia start wallet` - begin the wallet fast sync

### Get test mojos
1. `chia wallet show` - view wallet fingerprint and sync status
2. `chia wallet get_address -f [fingerprint]` - get wallet address from fingerprint
3. Get funds from either:
   - open https://testnet10-faucet.chia.net/ to get funds via the web-based faucet
   - or use `scripts/fund-wallet.sh <address> [amount]` to get funds via CLI
4. enter the wallet address and click [Submit]
5. `chia wallet show` - verify that the txch was received (this takes about a minute)

## Writing a Chialisp Program
The steps to write and test Chialisp programs inside of Clovyr Code are exactly the same as if you had a local development environment. When following guides and tutorials online, skip all the steps related to initializing the environment and connecting to the testnet. 

Two examples (chia-checkers and chia-piggybank) are included in this repo. 
  - [Piggybank: A Gentle Introduction](https://github.com/clovyr/chia-example/blob/main/examples/chia-piggybank/02-Piggybank-Simple.md) is step-by-step tutorial of how to write a basic Chialisp program
  - [Piggybank: Quickstart](https://github.com/clovyr/chia-example/blob/main/examples/chia-piggybank/01-Piggybank-QuickStart.md) is a step-by-step tutorial of how to deploy a completed Chialisp program and interact with it on the testnet

Use `git clone` to import additional examples from elsewhere. 

### Chialisp common program layout

```clojure
(mod (; arguments that solve the puzzle)

  ; import op code library
  (include condition_codes.clib) 

  ; define any constants
  (defconstant CONSTANT 100) 

  ; define any functions
  (defun-inline function_name (arguments)
    (list (list))
  )

  ; main program flow
  (if ()
    (
      ; do if true
      ; CONDITIONS, ASSERTIONS, and other logic goes in here
    )
    (x) ; else abort
  )
)

```
