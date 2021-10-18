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

Download the blockchain
 - `export CHIA_ROOT="~/.chia/testnet"`
 - `chia init` - create the configuration
 - `chia configure --testnet true` - modify the configuration to connect to the testnet
 - `cd ~/.chia/testnet`, `mkdir db`, `cd db` - create a directory for the testnet blockchain database
 - `wget https://download.chia.net/testnet7/blockchain_v1_testnet7.sqlite` - download the testnet blockchain

Add this node to the network
 - `chia keys generate` - generate keys and add them to the keychain
    - *Make note of the wallet address and/or fingerprint.* 
    - The wallet address can be viewed from the fingerprint with `chia wallet get_address -f [fingerprint]`
 - `chia start farmer` - begin syncing the blockchain
 - `chia show -a testnet-node.chia.net:58444` - add the chia.net peer, which has high availability
 - `chia show --connections` - confirm node has peers
 - `chia show --state` - confirm block height is growing
 - `chia --help` - view more options. [Chia CLI commands reference](https://github.com/Chia-Network/chia-blockchain/wiki/CLI-Commands-Reference). 

## Generate Wallet
 - `chia wallet show`, `s` - show wallet information for a new wallet
 - The wallet will need 12-24 hours to completely sync

## Get some test mojos
 - Visit chia-faucet.com/testnet 
 - Enter address: [your wallet address]
 - Enter amount: [0-1], e.g. .5

## Update piggybank example with our wallet address
 - `cp chia-piggybank piggybank-test` - copy the chia-piggybank folder for this test
 - open file `piggybank-test/piggybank.clsp`
 - `cdv decode [wallet address]` - decode bech32m address to a puzzle hash
 - update `CASH_OUT_PUZZLE_HASH` constant with the puzzle hash of your wallet. 
    - *Prepend the address with "0x!"* (just like in the example contract)
 - save the file

## Deploy empty piggybank
This script compiles the piggybank.clsp file to clvm, gets its puzzle hash, and forms a coin with zero mojos and this puzzle hash. 

- `python3 -i ./piggybank_drivers.py` - load the piggybank python driver in interactive mode
- `piggybank = deploy_smart_coin("piggybank.clsp", 0)` - deploy the piggybank contract with initial balance of 0
   - `CTRL + D` to exit the python interpreter (will unset the value of `piggybank`)
- Note `your_puzzle_hash`

## Move mojos into piggybank
We create a contribution coin, which spends funds from our wallet into a contribution coin. Contribution coins are coins earmarked for a specific purpose. In the future, we will add code to contribution.clsp that restricts the coin so that it will only spend itself as a deposit into the piggybank. 

 - `contribution_100 = deploy_smart_coin("contribution.clsp", 100)`
 - `contribution_200 = deploy_smart_coin(("contribution.clsp", 450)`

  - piggybank = get_coin("a61eb63b0206e1ced64d3c3becc054ebf3dcf43ad3d4ea78c4a685844ed1af8c")
contribution_100 = get_coin("ad65797cd26018efb0ef8903532124704749b71bd77e765ebd19ad0cb7f5cd9c")
 - `deposit(piggybank, contribution_100)`

## Verify savings dump to new coin

 - `cdv rpc coinrecords --by puzhash [your_puzzle_hash] -ou -s 570135 -nd`
