![Chia Logo](intro/static/img/chia-logo.svg)

# Chia Dev Sandbox TEST PREVIEW 

Notes:
- The environment starts with `cdv` and `chia` installed
- `chia init` is configured for testnet10
- Latest sqlite db is loaded
- To view this page again, open [README.md](README.md) and hit `CTRL+SHIFT+V`.

## User Steps

### Create and sync a wallet
1. `chia start node` - start the node
   - `chia show -c` - view peers (we benchmarked 
   - `chia show -s` - view sync status
2. `chia keys generate` - generate unique keys private to the user
3. `chia start wallet` - begin the wallet fast sync

### Get test mojos
1. `chia wallet show` - view wallet fingerprint and sync status
2. `chia wallet get_address -f [fingerprint]` - get wallet address from fingerprint
3. https://testnet10-faucet.chia.net/request - open the chia testnet web faucet
4. enter the wallet address and click [Submit]
5. `chia wallet show` - verify that the txch was received (this may take a couple minutes)

### Prepare piggybank
First, we generate a puzzle hash from our wallet address:

1. `chia wallet get_address -f [fingerprint]` - get wallet address from fingerprint
2. `cdv decode [wallet address]` - decode bech32m address to a puzzle hash

Then, we update the example file to use our wallet address as the location for the piggybank

1. `cd /home/clovyr/git/github.com/clovyr/chia-example/examples` - navigate to the examples folder
2. `cp -pr chia-piggybank piggybank-test` - make a copy of the piggybank example
3. `cd piggybank-test` - navigate to the new directory
4. open the piggybank.clsp file
5. Locate the wallet placeholder in the example file 
   - line 10: `(defconstant CASH_OUT_PUZZLE_HASH 0xYourWallet)`
6. replace "0xYourWallet" constant with the generated puzzle hash of your wallet
   - e.g.: (defconstant CASH_OUT_PUZZLE_HASH 0x7ba40c4022538388575ebde88dd0158da37e311d28a81e60e576e67807d26ec7) 
7. `CTRL+S` to save the file

### Test connectivity 
Eventually, we will deploy an empty piggybank, create & send contribution coins, and verify a payment once the threshold is met. 

1. `chia wallet show` - ensure that the wallet is Synced
2. ensure you are in the `examples/piggybank-test` directory
3. `python3 -i ./piggybank_drivers.py` - load the piggybank python driver in interactive mode
   - TOFIX: creating an empty piggybank is failing, likely due to recent updates in the python API. Will look at this.  
   - However, creating a contribution coin with a value IS working, so we will use that to verify connectivity: 
   - `contribution_100 = deploy_smart_coin("contribution.clsp", 100)`
5. `CTRL + D` to exit the python interpreter (will unset the value of `contribution_100`) 
