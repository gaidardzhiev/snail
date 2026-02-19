### SNAIL

Snail is a minimalist, interpreted programming language that features a lexical analyzer, parser, environment management, and an interpreter capable of evaluating expressions and statements including control flow, functions, and recursion.

Designed to be simple yet powerful, Snail supports higher order functions, closures, conditionals, and looping constructs. Through examples such as the factorial function, the deeply recursive Ackermann function, and advanced recursion patterns, Snail demonstrates its ability to express any computable function and is therefore **Turing complete**.

The interpreter runs at snail speed, but at least it leaves a slimy trace of logic behind.


#### Features

- Lexical tokenizer supporting keywords, identifiers, literals, operators, and symbols.
- Recursive descent parser producing an Abstract Syntax Tree (AST).
- Environment model with variable scoping and constants.
- Primitive data types: numbers and booleans.
- Functions.
- Control flow constructs: `if`, `elif`, `else`, `while`.
- Built in output function `outn` for printing values.
- Runtime error handling with descriptive messages.
- Interpreter that evaluates the AST directly.


#### Language Overview

The language supports:

- Variable declarations with `var` and `const`.
- Arithmetic operators (`+`, `-`, `*`, `/`, `%`).
- Comparison and equality operators (`<`, `>`, `==`,).
- Logical operators (`&&`, `||`, `!`).
- Function declarations via `func(params) => expression`.
- Control structures: `if`, `elif`, `else`, `while`.
- Statements end with semicolons `;`.
- Output via `outn(expression);`.

#### Core Language Features

###### Arithmetic, Variables, and Conditionals (`core_language_test.snl`)
```
{
    var a = 10;
    const b = 5;
    var c = a + b * 2;
    outn(c);

    if (c > 15) {
        outn(1);
    } elif (c > 10) {
        outn(2);
    } else {
        outn(3);
    }

    var count = 0;
    while (count < 5) {
        outn(count);
        count = count + 1;
    }

    var multiply = func (x, y) => {
        x * y;
    };

    var result = multiply(4, 5);
    outn(result);

    var outer = func (x) => {
        func (y) => {
            x + y;
        };
    };
    var add5 = outer(5);
    outn(add5(10));

    var val = true && false || true;
    if (val == true) {
        outn(42);
    }
}
```

- Supports variables (mutable `var` and immutable `const`).
- Arithmetic operations and operator precedence.
- Conditional `if`, `elif`, and `else` blocks.
- Loops using `while`.
- Function declarations, including closures and nested functions.
- Boolean logic operations.


##### Simple Recursion (`turing.snl`)
```
var factorial = func(n) => {
    if (n == 0) {
        1;
    } else {
        n * factorial(n - 1);
    }
};

var result = factorial(5);
outn(result);
```
- Demonstrates recursion and function calls.
- Computes factorial demonstrating non trivial mathematical functions.


##### Anonymous Functions (`anon_func.snl`)
```
var increment = func(x) => { x + 1; };
outn(increment(7));
```
- Supports anonymous functions (lambdas).
- Direct application of function values.


##### Advanced Recursion: Ackermann Function (`ackermann.snl`)
```
var ackermann = func(m, n) => {
    if (m == 0) {
        n + 1;
    } else {
        if (n == 0) {
            ackermann(m - 1, 1);
        } else {
            ackermann(m - 1, ackermann(m, n - 1));
        }
    }
};

var result = ackermann(3, 7);
outn(result);
```
- A classic computationally intensive recursive function.
- Demonstrates deep recursion and complex control flow capabilities.
- Running this successfully shows the language supports computations beyond simple loops.


##### Loop Control without break (`unbounded_loop.snl`)
```
var i = 0;
var done = false;
while (!done) {
    i = i + 1;
    if (i == 10) {
        outn(i);
        done = true;
    }
}
```
- Demonstrates looping and condition controlled termination without `break`.
- Shows language handles boolean variables and `while` loops effectively.


##### Higher Order Functions and Closures (`hofac.snl`)
```
var apply = func(f, x) => {
    f(x);
};

var square = func(n) => {
    n * n;
};

outn(apply(square, 5));
```
- Supports functions as first class values.
- Demonstrates passing functions as arguments and returning values.


##### Tail Recursive Function (`recursion.snl`)
```
var fact = func(n, acc) => {
    if (n == 0) {
        acc;
    } else {
        fact(n - 1, acc * n);
    }
};

outn(fact(5, 1));
```
- Shows support for tail recursion style functions with parameters as accumulators.
- Demonstrates ability to write efficient recursive code patterns.


##### Truth Tables (`truth_table_testing.snl`)
```
var not = func(b) => {
        if (b) { false; } else { true; }
};

var and = func(a, b) => a && b;
var or = func(a, b) => a || b;

var get_bit = func(num, bit) => {
        if ((num / bit) % 2 == 0) { false; } else { true; }
};

var truth_table = func(f) => {
        var i = 0;
        while (i < 4) {
                var a = get_bit(i, 2);
                var b = get_bit(i, 1);
                outn(f(a, b));
                i = i + 1;
        }
};

var de_morgan_1 = func(a, b) => {
        not(and(a, b)) == or(not(a), not(b));
};

truth_table(de_morgan_1);
```
- Defines basic boolean logic functions `not`, `and`, `or`.
- Programmatically generates all possible Boolean input pairs using `get_bit`.
- Automates truth table testing with the `truth_table` function by evaluating `f` over all input pairs.
- Tests De Morgan's Law, outputting `true` or `false` for each case.


##### De Morgan's Law (`demorgan_law.snl`)
```
var not = func(b) => {
    if (b) { false; } else { true; }
};

var and = func(a, b) => { a && b; };
var or = func(a, b) => { a || b; };

var de_morgan_1 = func(a, b) => {
    not(and(a, b)) == or(not(a), not(b));
};

outn(de_morgan_1(true, true));
outn(de_morgan_1(true, false));
outn(de_morgan_1(false, true));
outn(de_morgan_1(false, false));
```
- Implements the boolean negation, AND, and OR functions.
- Defines the De Morgan equivalence function `de_morgan_1`.
- Outputs the result of the equivalence on all possible two boolean inputs manually.
- Demonstrates the fundamental logic identity holds for every input.


##### Halting Paradox (`halting_paradox.snl`)
```
var halts = func(prog, input) => {
    false;
};

var diagonal = func(f) => {
    if (halts(f, f)) {
        diagonal(f);
    } else {
        0;
    }
};

var paradox = func(haltFunc) => {
    diagonal(haltFunc);
};

var result = paradox(diagonal);

outn(result);
```
- Defines a false halting oracle `halts` always returning `false`.
- Defines `diagonal` applying oracle to function applied to itself, recursing infinitely if halting predicted.
- Sets up `paradox` to apply `diagonal` to a halting oracle itself.
- Outputs `0`, illustrating the contradiction proving halting problem undecidable.


##### Halting Problem Diagonalization (`pure_diag.snl`)

```
var loops = func(f) => {
    if (f(loops)) {
        loops(loops);
    } else {
        0;
    }
};

outn(loops(loops));
```

**Result**: Segmentation fault (stack overflow)

This implements the diagonalization argument from Turing's halting problem proof. The `loops` function receives itself as input and behaves oppositely to its own prediction:

- If `loops(loops)` halts, it takes the `else` branch and returns `0`
- If `loops(loops)` loops, it takes the `if` branch and recurses

The contradiction forces infinite recursion, exhausting the call stack until the interpreter crashes. This demonstrates the halting problem's undecidability empirically through stack overflow.

**Significance**: Confirms the language can express self referential constructions that prove fundamental computability limits.


#### Proof of Turing Completeness

Snail language supports:

- **Mutable state (variables)**
- **Conditional branching** (`if`, `else`, `elif`)
- **Loops** (`while`)
- **Function definitions, recursion, and higher order functions**

By these properties alone, it meets the minimal criteria to be Turing complete.

Furthermore, the implementation of:

- The **factorial function** (`turing.snl`),
- The **Ackermann function** (`ackermann.snl`), and
- Tail recursion with accumulators (`recursion.snl`),

demonstrate the ability to compute any computable function given enough memory and time.

These scripts prove Snail can simulate the core logic patterns of a Turing machine, thereby being **Turing complete**.


#### Obfuscation techniques

This entry compresses a full recursive descent parser, AST builder, lexical analyzer with hashed keywords, nested environment scopes, and expression evaluator using layered macro indirection, self referential data encoding, polymorphic operator dispatch, and runtime structure allocation disguised as arithmetic. Keywords vanish into a 28 entry perfect hash collision table, resolved via multiplicative hashing and token type enums. Parsing leverages continuation style AST chaining with void star punning and zero initialized sentinels for block termination. Evaluation fuses binary ops into a single switch cascade, with closures via environment cloning and function pointers embedded as tagged nodes. Dense `#define` chains bootstrap the lexer without visible strings, while error paths masquerade as arithmetic exits. The result: a slimy trail of logic that crawls at interpretable speed...

> *I watched a snail crawl along the edge of a straight razor. This is my dream; this is my nightmare. Crawling, slithering, along the edge of a straight razor, and surviving.*
> 
> - Colonel Kurtz, *Apocalypse Now*
