# [Chia Dev Sandbox](../README.md) > Getting Started with Developing on Chia

This guide introduces the main tools and processes you'll encounter when building with Chialisp. 

Visit chialisp.com for a deeper dive into Chia fundamentals: [docs](https://chialisp.com/docs/) | [video tutorials](https://chialisp.com/docs/tutorials/why_chia_is_great/)

## Tools

Each of these tools is already installed in this Clovyr Code environment. Go ahead, try them out! 
(`` CTRL+` `` to show/hide the terminal).

 - Chia CLI - `chia --help` - Interact with the chia network | [Full Reference](https://github.com/Chia-Network/chia-blockchain/wiki/CLI-Commands-Reference)
 - Chia Developer Tools - `dev --help` - A suite of helpful tools | [Full Reference](https://github.com/Chia-Network/chia-blockchain/wiki/CLI-Commands-Reference)
 - CLVM Tools | [Full Reference](https://github.com/Chia-Network/clvm_tools)
    - `run --help` - Compile and execute chialisp to clvm 
    - `brun --help` - Execute clvm code, especially useful for local testing [Tips](https://chialisp.com/docs/high_level_lang)

### Terms to know
 - CLVM - the compiled, low-level language which runs on the Chia blockchain | [Docs](https://chialisp.com/docs/), [Glossary Reference](https://chialisp.com/docs/ref/clvm)
 - Chilisp - the more human-readable version of CLVM which has extra operators and features, and compiles to CLVM | [Docs](https://chialisp.com/docs/high_level_lang), [Common Functions](https://chialisp.com/docs/common_functions)
 - Puzzle - Programs that define the behavior of coins and tokens
 - Solution - Arugments passed to a puzzle that unlock the program's ability to run succesfully
 - Spend - Destruction of a coin (aka completion of a puzzle), usually with creation of new coin(s) to replace it
 - Spend Bundle - One or more coins grouped together into an aggregate value coin, used in conjunction with announcements to securely link a coin spend with its resulting new coin | [Docs](https://chialisp.com/docs/coin_lifecycle#spend-bundles)
 - Signature - Chia uses BLS Signatures which support signature aggregation | [Docs](https://chialisp.com/docs/coins_spends_and_wallets#bls-aggregated-signatures)
 - Conditions - A defined interface that allows puzzles inside coins to communicate with the blockchain. Conditions can both place restrictions on what can happen ("this spend is only valid if X" and define what happens as a result of a successful spend ("If this spend is valid, then X"). Also called OP codes. | [Full list](https://chialisp.com/docs/coins_spends_and_wallets#conditions)
 - Wallet - `chia wallet --help` - A view of the Chia blockchain from the reference point of a single keypair, tracking all puzzles to which it is part of a solution. Wallets can sign things and also generate puzzles and solutions. | [Docs](https://chialisp.com/docs/coins_spends_and_wallets#wallets)

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

# Video Introductions:

### Why Chia is Great
[![Why Chia is Great](static/img/video-why_chia_is_great.png)](https://www.youtube.com/watch?v=jRyTNdqP07Y)

### An Overview of Developing Applications on Chia
[![An Overview of Developing Applications on Chia](static/img/video-an_overview_of_developing_applications_on_chia.png)](https://www.youtube.com/watch?v=lh9spX6Qv8I)

### Programming in Chialisp
[![Programming in Chialisp](static/img/video-programming_in_chialisp.png)](https://www.youtube.com/watch?v=JcC1_igwSmA)


**Next Topic > [Creating a Chia Asset Token](03-Creating-a-Chia-Asset-Token.md)**
