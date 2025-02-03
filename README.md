# Lambda Calculus in Haskell

By Dominic Satnoianu

A simple implementation of λ-Calculus in Haskell for learning purposes. If you want to learn more about Lambda Calculus, this project is a good starting point to test out some basic operations and play with Church encodings such as booleans and natural numbers, as well as β-reduction.

The project is a work in progress, and I plan to add more features and tests in the future.

I initially created this project as a learning exercise, but I plan to expand it further and use it as a reference for future projects. I also plan to add a REPL for interactive use.

## Features

- Basic lambda calculus expression representation
- Church encodings for:
    - Boolean values (`True`, `False`)
    - Logical operations (`And`, `Or`, `Not`)
    - Conditionals (`If/Else`)
    - Natural numbers
    - Arithmetic operations (successor, predecessor, addition, multiplication, exponentiation)
- Beta reduction evaluation (step and fully reduce)

## Project Structure

```
lambda-calculus/
├── src/
│   ├── LambdaCalc.hs    # Core lambda calculus types and operations
│   ├── Church.hs        # Church encodings implementation
│   ├── Eval.hs          # Beta reduction and substitution
│   └── REPL.hs          # Soon, WIP - Interactive REPL
└── app/
    └── Main.hs          # Example usage and tests
```

## Usage

The project uses Cabal for building. To build and run:

```bash
cabal build
cabal run
```

Example output shows Church encoding operations:

```
True AND False: ((True False) False)
True OR False: ((True True) False)
Not True: ((True False) True)
If True then 'true' else 'false': ((True true) false)
Beta reduction tests:
True AND False: False
True OR False: True
Not True: False
If True then 'true' else 'false': true
```

Note that, for reading convenience, the Church encoding operations are displayed in a more human-readable format. They can be disabled from the `LambdaCalc` module, and the output would look something like this:

```
True AND False: ((λx. λy. x λx. λy. y) λx. λy. y)
True OR False: ((λx. λy. x λx. λy. x) λx. λy. y)
Not True: ((λx. λy. x λx. λy. y) λx. λy. x)
If True then 'true' else 'false': ((λx. λy. x true) false)
Beta reduction tests:
True AND False: λx. λy. y
True OR False: λx. λy. x
Not True: λx. λy. y
If True then 'true' else 'false': true
```

Because `True AND False` is `False`, we can use beta reduction (function application) to check if it is correct. Church boolean `True` is represented as `λx. λy. x`, and `False` is `λx. λy. y`. The `AND` operation is defined as `λp. λq. p q p`, so `True AND False` should reduce to `False`:

```
True AND False: ((λx. λy. x λx. λy. x) λx. λy. y)

(1) Reduce (λx. λy. x λx. λy. y). This can be seen as a function that takes two arguments and returns the first one: `λx. λy. x`. Provide `λx. λy. x` as the first argument.

(2) We then get a function that is waiting for a single argument (the second one needed to be provided earlier), and will not be taken into account in the reduction, because the first function discards it. This is `λx. λy. y`.

(3) So the answer, reduced, is `λx. λy. y`, which is `False`.
```

## Dependencies

- Base package (^>=4.17.2.1)
- GHC 9.4.8

## Author

This project was created by Dominic Satnoianu.