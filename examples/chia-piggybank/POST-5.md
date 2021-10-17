Test out the Piggybank Example in 15 minutes

# Connect to testnet

Download the blockchain
 - `export CHIA_ROOT="~/.chia/testnet"`
 - `chia init`
 - `chia configure --testnet true`
 - `cd ~/.chia/testnet`
 - `mkdir db`
 - `cd db`
 - `wget https://download.chia.net/testnet7/blockchain_v1_testnet7.sqlite`

Add this node to the network
 -  `chia keys generate` (Copy resulting address for later)
 - `chia start farmer`
 - `chia show -a testnet-node.chia.net:58444`
 - `chia show --connections`
 - `chia show --state`

# Generate Wallet
 - `chia wallet show`
 - `s` (skip backup import for first time)
 - `f` (find backup - need process to save backup)

# Get some test mojos

# Prep example

# Deploy empty piggybank

# Move mojos into piggybank

# Verify savings dump to new coin
