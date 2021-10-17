# [Chia Dev Sandbox](../README.md) > Getting Started

The main resources for Chialisp are:

  - [Chialisp website](https://chialisp.com/)
  - [Chialisp docs](https://chialisp.com/docs/)
  - [Video tutorials](https://chialisp.com/docs/tutorials/why_chia_is_great/)

## Chia concepts crash course

### "Smart Coins" vs "Smart Contracts" 

In most blockchain systems (like Ethereum), transactions are first class objects. There is a single smart contract that maintains an internal representation of who owns the tokens the contract has been given permission to manipulate. The state of this contract is updated not when a transaction is sent to the contract, but when the transaction is processed by the contract (minted into a block). This means that the order that transactions are processed matters very much and opens the system to tampering by miners who might manipulate the order in which transactions are mined. 

In Chia, money is the first class object. This means that all the rules and functionality for a coin exist *inside* the coin itself. Coins only exist once. Running the coin's program spends that coin. Coins can be spent in many ways, e.g. sending a coin from Alice to Bob, donating to a crowd-funding campaign, or buying an NFT.  Each of these actions consumes existing coin(s), ending in creation of a new coin with updated state. Thus, the ledger is resistant to transaction order fidgeting, and the overal system is more "decentralized" because each coin is running on rules intrinsic to itself. Spends are atomic: they have either happened or they have not (i.e. we avoid any re-entrancy bugs). 

### Programs are called puzzles

Spending a coin requires solving that coin's puzzle, which is also equivalent to successfully running a coin's program. Running a coin's program successfully will always result in destruction of that coin and creation of one or more new coins. If the puzzle isn't solved successfully, the coin isn't spent. Anyone can attempt to solve any puzzle, so it's up to the coin's creator to secure the intended behavior of the coin. 

The most basic coin program is the "standard puzzle," which says "I will only respond to a spend attempt that is signed by a specific public key, and I will then follow any other instructions given to me."

Puzzles can be much more complicated, though. They can contain arbitrary data blobs that travel with the coin forever, increment a tally with each spend, or refuse to be spent unless some other requirements have been met. 

Programs that run successfully return a list of conditions. These might be more familar as "OP codes." For example, one condition returned for a basic puzzle is CREATE_COIN, which will create a new coin to replace the one being spent. 

Once solved, a puzzle's solution is stored transparently on the blockchain. This means that arguments passed in will eventually become public knowledge. 

### Coins contain:

 - ParentID - Information about the coin that created this coin
 - Amount - How many mojos this coin represents (or, for custom tokens, how many of that token's denomination). Mojos are to Chia as Satoshis are to Bitcon. 
 - Puzzle Hash - The hash of the puzzle (program) that governs this coin. 

 CoinID - The hash of these three pieces of information together

### No one "owns" a coin

Ok. But the coins in my wallet are mine, right? 
Yes. "Standard puzzle" coins that must be signed by your pubkey (and only your pubkey) as an input to their puzzle solution can only be spent by you. 

### Transactions happen as "spend bundles"

To create a spend, you reveal the full puzzle corresponding to the puzzle hash inside the coin to be spent, and also attach a solution to that puzzle

The Spend Bundle object contains:
 - The ID of a coin to be spent
 - A puzzle reveal - the fulltext of a coin's program, the hash of which must match the Puzzle Hash of the target coin to spend
 - A solution - arguments that solve the puzzle
 - An aggregated signature - spend bundles can contain multiple coin spends with one single aggregated signature

In a process familiar to most blockchains, a spend bundle is broadcast to the network and a Chia farmer will eventually evaluate it:
  - Does a coin with the Coin ID exist?
  - Does the puzzle reeal match the puzzle hash inside the coin?
  - Does the puzzle (program) run successfully, given the arguments (solution) passed to it during runtime? 
  - What conditions are returned by this spend?
  - Do the conditions pass? 

### Mental models for a few common transaction archetypes

#### Alice sends 100 mojo to Bob
* Alice's sync'd wallet contains a local index of all the coins for which her private key is an input to their puzzle?
* There are standard Chia coins (XTCH) for which the solution to their puzzle has is Al
* Alice passes a coin the arguments that solve its puzzle: the coin's amount, her private key, and Bob's public key

#### Alice sends 100 mojo into a shared, public piggybank

#### Alice buys an NFT for 100 mojo

### Putting it all together

As Chialisp developers, this means that we need to think about "programmable money" in a new way: Each 

**Instead of writing contracts about data, ask yourself, "What rules govern this coin?"**
 - This coin can only be spent by .
 - This coin can be increased in value by anyone, as long as _____.
 - As long as the coin always _____, let the owner add whatever other rules they want going forward.
 - This coin must exist for ______ days before it can be spent.
 - All these rules can be layered.


## Developing on Chia crash course

### Terms to know
 - CLVM - the compressed language which runs on the Chia blockchain
 - Chilisp - expanded version of CLVM which has extra operators and features, and compiles to CLVM
 - Conditions - a defined interface that allows puzzles inside coins to communicate with the blockchain. Also called OP codes. [Full list](https://chialisp.com/docs/coins_spends_and_wallets#conditions)

So to recap:
 - CLVM programs are also called "puzzles," and to run them, they are passed a set of arguments, called the "solution."
 - A puzzle is a coin, and a successful solution results in a spend of that coin.
 - More specifically, a coin contains a hash of a puzzle

We recommend watching the following videos for a quick overview of the language:

## Why Chia is Great
[![Why Chia is Great](static/img/video-why_chia_is_great.png)](https://www.youtube.com/watch?v=jRyTNdqP07Y)

## An Overview of Developing Applications on Chia
[![An Overview of Developing Applications on Chia](static/img/video-an_overview_of_developing_applications_on_chia.png)](https://www.youtube.com/watch?v=lh9spX6Qv8I)

## Programming in Chialisp
[![Programming in Chialisp](static/img/video-programming_in_chialisp.png)](https://www.youtube.com/watch?v=JcC1_igwSmA)

# Examples

Have a look at the following examples:

- [chia-checkers](../examples/chia-checkers/README.md)
- [chia-piggybank](../examples/chia-piggybank/README.md)
