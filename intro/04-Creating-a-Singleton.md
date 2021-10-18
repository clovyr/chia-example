# [Chia Dev Sandbox](../README.md) > Creating a Singleton 

A singleton is an indivisible, uniquely identifiable coin. It's unique identifier is called its Launcher ID, which is derived from the coin that created it (the launcher). 

Singleton IDs can be thought of as functionally comparable to Ethereum's contract addresses. State can be stored there and accessed from inside the singleton's puzzle.

A singleton can be used to represent things that need to be unique on the blockchain, such as identities or NFTs. If you receive a message from a singleton, you can be confident that it is the real, original singleton because they cannot be duped or faked.

If you have a puzzle which changes state frequently, it will not have a permanent puzzle has or permanent coin ID. This makes it difficult to tell people where to look for it. 
Singletons can be used to give things permanent addresses that are easy to track. 

## How they work

To ensure that a coin is unique, we give it the following rules:
- I can only create one coin, which is my singleton successor
- I can only be spent if I am legitimate
- My predecessor must follow the same rules as me, or I am the original first coin
- Note: Singletons always have an odd mojo value, else their puzzle fails. This guarantees that if someone tries to create a singleton as an even output, it is unspendable. 

## Creating a Singleton
If we set our launcher puzzle to announce the puzzle that has been passed in, and we spend our launcher coin in the same spend bundle it's created in, we can asser that its ammouncement
exists as part of the spend of the launcher's parent. Because all conditions in spend bundle are evaluated at the same time, it means that if someone tries to interfere with the
launcher's solution, then the launcher coin will never be born. 

## Working Examples
- [TBA]

## Related Topics

Singletons are a fundamental concept in Chia. In this video, Chia developer Matthew Howard explains what Singletons are and how they're involved in creating Ethereum-like contracts in Chia.:

[![Singletons and Ethereum-like Contracts in Chia](static/img/video-singletons.png)](https://chialisp.com/docs/tutorials/singletons)

**Next Topic > [Deploying to Testnet](05-Deploying-to-Testnet.md)**
