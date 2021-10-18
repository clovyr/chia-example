# [Chia Dev Sandbox](../README.md) > Creating a Custom Asset Token (CAT)

Custom Asset Tokens (CATs) are user-created coins in the Chia Network. 

CATs are useful to represent real world assets like cars or rare books. They can be tied to financial assets, such as "you can redeeom one of our coins for one share of stock". They can be used to create reward schemes, like in-network travel points.

CATs are unforegeable. No extra value can be added to, or removed from, the set at any point after their creation (though they can be merged with a new deposit to create a new CAT with a higher value than before). Their value is always transferred from legitimate CAT parents. The value of the CAT can be stored in one big coin, or split among any number of coins of arbitrary value, summing to the total value of the CAT.

Also see: [Glossary](https://www.chia.net/2021/09/23/chia-token-standard-naming.en.html) of CAT-related terms

# Example CAT: Piggybank

The piggybank example shows how to make a token that increases in value when mojos are sent to it, without allowing any withdrawls until a pre-set savings target is met. Once the goal is met, the piggybank creates a new, spendable Standard Puzzle coin of that value at a pre-determined address, and resets itself to zero so you can start saving again. 

This piggybank example is a simple version of something like a Kickstarter model, where funds are collected in an escrow account until the project reaches a goal, at which point a pre-specified recipient receives the total amount. Unlike Kickstarter, in our example we know the rules of the game up front, and that they won’t be altered mid-stream. Out of scope for this example are some features like returning funds in the event that a goal isn’t reached, and some security considerations. 

## Tutorials

1. ### [Test out the Piggybank Example in 15 minutes](../examples/chia-piggybank/01-Piggybank-QuickStart.md)
   Connect to the Chia testnet and deploy a premade version of piggybank coin.
   
2. ### [Piggybank Coin from Scratch: A Gentle Introduction to Chialisp](../examples/chia-piggybank/02-Piggybank-Simple.md)
   Write the piggybank contract step-by-step, exactly following the official [video tutorial](https://chialisp.com/docs/tutorials/coin_lifecycle_and_testing).

3. ### [Intermediate Guide](https://github.com/kimsk/chia-piggybank)
   
   Visit kimsk's piggybank example on [github](https://github.com/kimsk/chia-piggybank), which expands the piggybank contract to explore additional security considerations, including attestations and contribution coins. Under active development. 

**Next Topic > [Creating a Singleton](04-Creating-a-Singleton.md)**
