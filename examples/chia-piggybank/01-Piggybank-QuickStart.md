# Test out the Piggybank Example in 15 minutes

In this example we will:
 - Connect to the Chia testnet
 - Create a wallet and add some mojos to it
 - Create a copy of the example piggybank contract such that our wallet is the cash out destination where funds will be deposited when the savings goal is reached
 - Deploy the contract 
 - Send some of our test mojos to the piggybank
 - Verify the piggybank's value has increased
 - Verify that the piggybank cashes out to our wallet when the savings goal is reached

## Connect to testnet
In order to deploy our coin to the testnet, we want to run a full node. This will also allow us to test out all the other chia CLI commands to directly inspect the blockchain state. 

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

## Update piggybank example with our wallet address
 - `cp -r chia-piggybank piggybank-test` - copy the chia-piggybank folder for this test
 - open file `piggybank-test/piggybank.clsp`
 - `cdv decode [wallet address]` - decode bech32m address to a puzzle hash
 - update `CASH_OUT_PUZZLE_HASH` constant with the puzzle hash of your wallet. 
    - *Prepend the address with "0x"* (just like in the example contract)
 - save the file

## Ensure you have some chia in your wallet

 - In order to create a coin (send to an address) even with 0 mojo, one must
   have a coin to be its parent.  Ensure that your wallet has a nonzero balance
   with `chia wallet show` before continuing.

## Deploy and fund the piggybank
This script compiles the piggybank.clsp file to clvm, gets its puzzle hash, and forms a coin with 1 mojo and this puzzle hash. We then create a contribution coin and deposit it into the piggybank.

- ensure that piggybank-test is your working directory
- `python3 -i ./piggybank_drivers.py` - load the piggybank python driver in interactive mode
- `piggybank = deploy_smart_coin("piggybank.clsp", 1, 10)` - deploy the piggybank contract with initial balance of 1 mojo for a 10 mojo tx fee
   - On success, `parent_coin_info` and `puzzle_hash` are displayed. Note the puzzle hash to use as [your_puzzle_hash] in the final verification step
- Next, we create a contribution coin, which spends funds from our wallet into a contribution coin. Contribution coins are coins earmarked for a specific purpose.  
   - `contribution_100 = deploy_smart_coin("contribution.clsp", 100, 10)` - create a contribution coin with value of 100 mojos for a 10 mojo tx fee
   - `deposit(piggybank, contribution_100)` - move the value from the contribution coin into the piggybank
     - Note this step requires a synced blockchain. You can check the sync status in a new terminal with `chia show -s`

## Verify that the piggybank now has stored value
 - `CTRL + D` to exit the python interpreter (this will unset the values of `piggybank` and `contribution_100`)
    - Alternatively, open a new terminal with `` CTRL+SHIFT+` ``. Open terminals are listed in the righthand sidebar of the terminal.
 - `cdv rpc coinrecords --by puzhash [your_puzzle_hash] -ou -s 460000 -nd` - use chia-devtools to verify the contents of the piggybank
