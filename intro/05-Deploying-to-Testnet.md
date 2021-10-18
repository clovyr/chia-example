# [Chia Dev Sandbox](../README.md) > Deploying to Testnet

## Manually
This is a slow and error prone way to deploy a coin, but a very useful exercise to understand how the system works. 

1. Compile the CLSP program
    - `$ cdv clsp retrieve condition_codes` - import op codes
    - `$ cdv clsp build file.clsp` - output filename.clsp.hex (serialized version of the cvlm code) in the cwd
2. Test locally
    - `$ brun (cdv clsp disassemble filename.clsp.hex) '(arguments)'` - pass in various values for arguments to suit test cases
3. Deploy coin
    - `$ cdv clsp treehash filename.clsp.hex` - Get the puzzle hash (treehash) of filename (this can be used later to retrieve the coin record)
    - `$ cdv encode (cdv clsp treehash filename.clsp.hex) --prefix txch` - outputs and encoded address from the treehash
    - `$ chia wallet send -a 0 -t [EncodedAddress]`
    - Wait for the transaction to confirm
4. Verify the coin record
    - `$ cdv rpc coinrecords --by puzhash [0xYourPuzzleHash]`

## Via a Driver Script
We can automate interacting with a chialisp coin via driver files. These scripts can deploy the coin without risking human error, and also make it easier to interact with the coin later. [Video Tutorial](https://www.youtube.com/watch?v=dGohmAc658c)

Example drivers: [Piggybank](../examples/chia-piggybank/piggybank_drivers.py) | [Chia Video Example] (to add)


**Next Topic > [Deploying to Mainnet](06-Deploying-to-Mainnet.md)**
