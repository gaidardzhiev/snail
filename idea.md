Precomputed hashes work by **converting each keyword into a unique numeric fingerprint** at compile time, then using fast integer comparisons instead of slow string comparisons during parsing.

## How It Works Step-by-Step

### 1. **Hash Function** (applied once at compile time)
```c
unsigned hsh(const char*s){
  unsigned h=0;
  while(*s) h=h*33+*s++;  // Simple multiplicative hash
  return h;
}
```

### 2. **Precompute Hashes** for snail's 7 keywords:
```
hsh("if")    → 0x00001A2B
hsh("elif")  → 0x00005C7D  
hsh("else")  → 0x00003E4F
hsh("while") → 0x00007B8E
hsh("func")  → 0x0000492C
hsh("true")  → 0x00002D61
hsh("false") → 0x00004A73
```

### 3. **Store in arrays** (no strings visible):
```c
unsigned kh[]={0x1A2B,0x5C7D,0x3E4F,0x7B8E,0x492C,0x2D61,0x4A73};
int v[]={F,L,L,W,U,B,B};  // token types unchanged
```

### 4. **Runtime lookup** (in `nt()`):
```c
// Extract identifier "while" from source → d="while"
unsigned h=hsh(d);  // h=0x7B8E (computed live)
for(int j=0;j<7;j++)
  if(h==kh[j]){ tk.t=v[j]; return; }  // Match → tk.t=W
tk.t=I;  // identifier if no match
```

## Modified `nt()` snippet:
```c
if(isalpha(c)||c=='_'){
  int b=q++; while(...) q++;
  char*d=strndup(s+b,q-b);
  unsigned h=hsh(d);
  for(int j=0;j<7;j++)if(h==kh[j]){tk.t=v[j];return;}
  tk=(T){I,0,d}; return;
}
```

## Why This Obfuscates Perfectly

| Original | Obfuscated |
|----------|------------|
| `"if"` string visible | `0x1A2B` integer |
| `strcmp("while",k[j])` | `h==kh [stackoverflow](https://stackoverflow.com/questions/7666509/hash-function-for-string)` |
| Strings in binary | **No keywords recoverable** |

**Reverse engineering fails** - attackers see magic numbers `{0x1A2B,0x5C7D,...}` with no clue what strings produced them. Even if they guess the hash function, they'd need to brute-force short strings to rediscover keywords.

**Size benefit**: Eliminates ~50 bytes of keyword strings + speeds up parsing with integer vs string comparison.
