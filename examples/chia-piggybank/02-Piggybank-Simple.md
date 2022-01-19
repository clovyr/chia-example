# Example: Piggybank (My first CAT): A Gentle Introduction

If you're new to building on Chia, this is a great place to start!

- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Defining Arguments](#defining-arguments)
- [Setting Constants](#setting-constants)
- [Main Control Flow](#main-control-flow)
  - [Function: Recreate Self](#function-recreate-self)
  - [Include Chialisp OP Codes](#include-chialisp-op-codes)
  - [Function: Recreate Self (con't)](#function-recreate-self-cont)
  - [Function: Cash Out Piggybank](#function-cash-out-piggybank)
- [Final Contract](#final-contract)

## Introduction

This tutorial shows how to make a “piggybank": a "custom coin" that increases in value when mojos are sent to it, without allowing any withdrawals until a pre-set savings target is met. Once the goal is met, the piggybank creates a new, spendable coin of that value and resets itself to zero so you can start saving again. 

This piggybank example is a simple version of something like a Kickstarter model, where funds are collected in an escrow account until the project reaches a goal, at which point a pre-specified recipient receives the total amount. Unlike Kickstarter, in our example we know the rules of the game up front, and that they won’t be altered mid-stream. Out of scope for this example are some features like returning funds in the event that a goal isn’t reached, and some security considerations (covered in another example). 

The [puzzle hash](https://chialisp.com/docs/coins_spends_and_wallets#puzzles-and-solutions) where funds will eventually end up is defined at the outset as a constant, so that everyone knows there won't be any funny business. The target puzzle hash may be accessible by you, or it could belong to a third party (for example, we can choose ahead of time to donate funds to a predetermined charity). Once set in motion, a piggybank like this could be active forever - collecting deposits and moving them to the specified puzzle hash when the goal is met each time. That's pretty neat!

We are also going to let anyone who wants to contribute to the piggybank do so, regardless of whether they have a valid signature or not - that means that no permission or pre-knowledge of who will participate is required. This is useful for cases like charity donations and project crowd funding.

## Getting Started

1. Open the Piggybank Project folder
2. Make a new folder called `piggybank`. This will keep all our new work in one place. 
3. Create a file in the new folder called `piggybank.clsp` (clsp is the chialisp extension)

## Defining Arguments
Chialisp files begin with a `mod` section, which will define arguments, functions, and included files. This lets the runtime know we are passing chialisp, which will need to be compiled to CLVM to be stored on the blockchain ([docs](https://chialisp.com/docs/high_level_lang#compiling-to-clvm-with-mod)). 

First we define the arguments we will refer to later in our functions.
   * `my_amount` - current balance in the piggybank
   * `new_amount` - proposed new balance after this transaction. Later on, we'll ensure we only process deposits by verifying that the difference between `new_amount` and `my_amount` is positive
   * `my_puzzlehash` - this piggybank smart coin or "contract". Each time we accept a new deposit, we recreate the piggybank containing a CAT with the new balance value.
   
```clojure
(mod ( 
    ; define arguments
    my_amount
    new_amount
    my_puzzlehash	
  )
 )
```

## Setting Constants

Constants are where we, as creators of the contract, define some static values that will not change over the life of the contract. 

The constants we need for this example are 
* `TARGET_AMOUNT` - our savings goal, in mojos
* `CASH_OUT_PUZZLE_HASH` - the address that the saved mojos will be sent to, when the target amount is reached. Presumably we can put in an address that we control, but we could also send the mojos somewhere else, like to a friend or a charity, as long as we have their puzzle hash address. For this example we are going to make up filler text, but you might want to [generate your own puzzle hash address] first. If you use this one, the mojos will be lost forever!

```clojure
(mod ( 
    ; define arguments
    my_amount
    new_amount
    my_puzzlehash	
  )
  
  ; define constants
  (defconstant TARGET_AMOUNT 500)
  (defconstant CASH_OUT_PUZZLE_HASH 0xcafef00d)
 )
```

## Main Control Flow 

Whenever we create the main entry point to the application, we like to leave a comment stating as much, with the comment `;main`. Usually the control flow is found at the bottom of the contract, after arguments, constants, and functions. 

This contract will be evaluated everytime someone attempts to change the balance at the puzzle hash address. First we will check if the `new amount` is greater than the prior amount (`my_amount`). If so, continue on. If not (someone is attempting to reduce the balance), we will raise an [error](https://chialisp.com/docs/debugging#using-x-to-log). 

```clojure
; main
(if (> new_amount my_amount)
  ; if yes, do stuff 
  ; if no, raise error 
  (x) 
  )
```

Assuming we pass check one, now we check if we have reached the target amount. If yes, we'll cash out the piggybank. If no, we'll recreate a new copy of the piggybank with the new balance including this deposit.

```clojure
; main

; first check if transaction is a deposit
(if (> new_amount my_amount)
  ; if yes, do stuff 
  (if (> new_amount TARGET_AMOUNT)
    ; if yes, cash out 
    ; if no, recreate_self 
  )
  ; if no, raise error 
  (x)
)
```

### Function: Recreate Self
Let’s flesh out the most common case first: that the new amount is still below the target amount, so we recreate the piggybank including the most recent deposit, to await future deposits.

First we pass it the three arguments of the `recreate_self` function, which were previously defined.

```clojure
; main

; first check if transaction is a deposit
(if (> new_amount my_amount) 
  ; if yes, evaluate if savings target is reached
  (if (> new_amount TARGET_AMOUNT) 
     ; if yes, cash out
    ; if no, accept deposit
    (recreate_self my_amount new_amount my_puzzlehash) 
  )
  ; if transaction is not a deposit, abort
  (x) 
  )
```
    
Now we define the `recreate_self` function that uses these parameters. Functions are defined in the `mod`. (We use inline functions for optimization, unless you’re doing something like recursion or recalculating values.) 

```clojure
(defun-inline recreate_self (my_amount new_amount my_puzzlehash)

)
```


When we run a Chialisp program, we expect a list of conditions to come up. So all this is going to do is return a list of conditions. Let’s start with a list of lists. 

```clojure
(defun-inline recreate_self (my_amount new_amount my_puzzlehash)
  (list
    (list )
  )
)
```

### Include Chialisp OP Codes

Conditions each have their own OP codes. These are defined in another library file, easily accessible via clsp dev tools. Running help will show the available clsp tools.

```$ cdv clsp --help ```

We will use `retrieve`, which will copy the specified .clib file that already exists in the virtual environment, into the current directory so we can use it. This will add an /includes folder into our project, and inside that folder will be the condition_codes.clib file

```$ cdv clsp retrieve condition_codes```

Opening that file allows us to peruse all the available OP codes, handily aliased so that we can refer to them by their friendly name rather than their op code number in our contract. 

Now we navigate back to our piggybank.clsp file and add an include statement so that our contract knows about the op codes, too. When our dev tool builds this, it’s going to know to look in the include folder. Includes are added to the `mod` section. (Note that [run] and [brun] don’t know about this, so if you are using those, make sure to specify what paths to search for to include from.)

```clojure
(mod (
  my_amount
  new_amount
  my_puzzlehash	
  )
  
  (include condition_codes.clib)
  
  (defconstant TARGET_AMOUNT 500)
  (defconstant CASH_OUT_PUZZLE_HASH 0xcafef00d)
)
```

### Function: Recreate Self (con't)

Now we can complete our `recreate_self` function using the existing OP code for `CREATE_COIN`, at a location of `my_puzzlehash`, with a value of `new_amount`. 

If we’re not being secure, this is all we’d need to do. (We’ll talk about security later.)

```clojure
(defun-inline recreate_self (my_amount new_amount my_puzzlehash)
  (list
    (list CREATE_COIN my_puzzlehash new_amount)
  )
)
```
### Function: Cash Out Piggybank

The next function is a bit more complex. In this scenario, we have reached out savings goal, so not only do we need to recreate a new empty piggybank, but we need to pay everything that we’ve saved so far, to our `CASH_OUT_PUZZLE_HASH`. 

```clojure
; main

; first check if transaction is a deposit
(if (> new_amount my_amount) 
  ; if yes, evaluate if savings target is reached
  (if (> new_amount TARGET_AMOUNT) 
     ; if yes, cash out
    (cash_out CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
    ; if no, accept deposit
    (recreate_self my_amount new_amount my_puzzlehash) 
  )
  ; if transaction is not a deposit, abort
  (x) 
  )
```

Now let’s define another inline function to support this. First we copy over the same arguments

```clojure
(defun-inline cash_out (cash_out CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
  (list
    (list )
  )
)
```

Next, we write the logic to cash out to our puzzle hash. 

In this example, once we have determined that the target amount has been reached, we will dump everything in the piggybank immediately to the target puzzle hash. If there is a surplus, it will be sent as well, so we may end up with more in our destination than just the exact target amount. (We could choose to burn any overage as a fee or redirect it elsewhere, or leave it in the existing piggy bank, but that would be a bit more complicated than we want for this example.)

So, we will create a new coin at the cashout puzzle hash destination using `CREATE_COIN`, with the total value of `new_amount`:

(Question: What happens if there is already a coin at this destination, with a positive value?)

```clojure
(defun-inline cash_out (cash_out CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
  (list
    (list CREATE_COIN CASH_OUT_PUZZLE_HASH new_amount)
  )
)
```

Then we recreate our piggybank with a new starting amount of zero. 

```clojure
(defun-inline cash_out (cash_out CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
  (list
    (list CREATE_COIN CASH_OUT_PUZZLE_HASH new_amount)
    (list CREATE_COIN my_puzzlehash 0)
  )
)
```

That's it!

## Final contract:

```clojure
(mod ( 
    ; define arguments
    my_amount
    new_amount
    my_puzzlehash	
  )
  
  ; include op codes
  (include condition_codes.clib)
  
  ; define constants
  (defconstant TARGET_AMOUNT 500)
  (defconstant CASH_OUT_PUZZLE_HASH 0xcafef00d)
  
  ; define function to cash out piggy bank when target is reached & recreate new empty piggybank
  (defun-inline cash_out (CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
    (list
      (list CREATE_COIN CASH_OUT_PUZZLE_HASH new_amount)
      (list CREATE_COIN my_puzzlehash 0)
    )
  )

  ; define function to accept deposit and recreate piggybank with new balance
  (defun-inline recreate_self (my_amount new_amount my_puzzlehash)
    (list 
      (list CREATE_COIN my_puzzlehash new_amount)
    )
  )

; main control flow

; first check if transaction is a deposit
(if (> new_amount my_amount) 
  ; if yes, evaluate if savings target is reached
  (if (> new_amount TARGET_AMOUNT) 
     ; if yes, cash out
    (cash_out CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
    ; if no, accept deposit
    (recreate_self my_amount new_amount my_puzzlehash) 
  )
  ; if transaction is not a deposit, abort
  (x) 
  )
)
