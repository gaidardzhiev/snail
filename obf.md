## Obfuscation techniques

- **Minimal, overloaded identifiers**  
  Types, functions, and globals use 1–2 letter names (`A`, `H`, `V`, `nt`, `ev`, `blk`), forcing readers to infer roles from usage rather than names.

- **Macro based indirection**  
  Macros like `X`, `is`, `VN`, `VB`, `TV`, and `PR` hide core semantics (exit, token tests, value construction, precedence) behind short, opaque names.

- **Encoded booleans and tagged values**  
  Booleans are encoded as negative integers via `VB(b)` and decoded through `TV(v)`, so the meaning of a value depends on subtle arithmetic rather than types.

- **Single struct for multiple concepts**  
  The `V` struct stores either a plain integer or a function + environment “closure”, with no explicit tag field, so interpretation depends entirely on context.

- **Mixed token representation**  
  Token kinds combine enum values (e.g., `I`, `N`, `B`, `F`, `W`, `U`) and raw character codes (`'+'`, `'-'`, `'{'`, `'}'`), making the parser logic harder to follow.

- **Compressed recursive descent parser**  
  Parsing is split into short functions (`P0`, `J`, `B1`, `P`, `K`, `If`, `S`) that each handle several grammar cases, using minimal branching and many early returns.

- **Precedence encoded in a macro**  
  Operator precedence is encoded by the `PR(t)` macro and the loop in `B1` instead of a clear table, so understanding expression parsing requires tracing macro expansion.

- **Tight environment / scope representation**  
  Environments are linked lists (`H`) manipulated by short helpers (`ne`, `fd`, `df`, `gv`, `as`), with variable binding and lookup hidden behind pointer walks.

- **Error handling via tiny macro**  
  All parse/runtime errors funnel through `X(1)` (a macro for `exit(1)`), obscuring where the interpreter can fail and collapsing many cases into one behavior.

- **Dense control flow in the evaluator**  
  The main evaluator `ev` is a single large `switch` with many `case`s and early `return`s, so reconstructing the language semantics requires tracing many branches.
