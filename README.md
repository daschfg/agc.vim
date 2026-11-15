# agc.vim

Syntax highlighting for **AGC (Apollo Guidance Computer) assembly** - the
YUL language used to program the Apollo Guidance Computer - for Vim and
Neovim.

It highlights the full instruction set (Block I and Block II), the extended /
interpretive instructions, pseudo-ops and directives, downlink directives,
special registers, labels, numbers, operators, `$`-prefixed symbols and
includes, and comments.

The syntax definitions were developed with reference to AGC/YUL language
information from the [VirtualAGC](https://github.com/virtualagc/virtualagc/) project.

Special thanks to everyone involved in the VirtualAGC project for their
remarkable work in preserving, documenting and making the Apollo Guidance
Computer's software and history accessible.

## Supported filetypes

| Extension | Filetype | Description |
|-----------|----------|-------------|
| `*.agc`   | `agc`    | AGC (Command Module / Lunar Module) assembly source |
| `*.yul`   | `agc`    | YUL assembly source (same language) |

## Installation

### lazy.nvim

```lua
{ 'daschfg/agc.vim' }
```

### vim-plug

```vim
Plug 'daschfg/agc.vim'
```

## What gets highlighted

| Group | Meaning | Default link |
|-------|---------|--------------|
| `agcBasicOp` | Basic instructions (`TC`, `CAF`, `TS`, `DXCH`, `EXTEND`, …) | `Statement` |
| `agcExtOp` | Extended / interpretive instructions (`STORE`, `STODL`, `DLOAD`, `VXV`, `GOTO`, …) | `Keyword` |
| `agcPseudo` | Pseudo-ops / directives (`OCT`, `DEC`, `2CADR`, `SETLOC`, `EBANK=`, …) | `PreProc` |
| `agcDownlink` | Downlink directives (`1DNADR`…`6DNADR`, `DNCHAN`, `DNPTR`) | `PreCondit` |
| `agcRegister` | Special registers (`A`, `L`, `Q`, `Z`, `EB`, `FB`, `BB`, `ARUPT`, …) | `Identifier` |
| `agcLabel` | Column-1 statement labels | `Function` |
| `agcRelativeLabel` | Relative labels (` +1`, `-2`) | `Label` |
| `agcNumber` | Numeric literals (octal and `D`-suffixed decimal; 8/9 allowed) | `Number` |
| `agcDollar` | `$`-prefixed symbols / relative refs (`$2`, `$450`, `$/EXTVB`) | `Special` |
| `agcOperator` | `=`, `=+`, `=-`, `+`, `-`, `*`, `/`, `,` (not inside symbols) | `Operator` |
| `agcInclude` | `$FILE.agc` include lines | `Include` |
| `agcComment` | `#` comments | `Comment` |
| `agcPageComment` | `##` page / `###` file banners | `SpecialComment` |
| `agcString` | Double-quoted strings | `String` |

Recolour any of these in your colourscheme, e.g.:

```vim
highlight agcLabel guifg=#e5c07b
```

## Editing defaults

The bundled `ftplugin` applies the VirtualAGC convention of **hard tabs every
8 columns**:

- `tabstop=8`, `shiftwidth=8`, `softtabstop=0`, `noexpandtab`
- `commentstring=# %s`
- `formatoptions-=t` (no auto-wrapping of long comment lines)

## How it was built

The syntax definitions were researched using AGC/YUL language information from
the [VirtualAGC](https://github.com/virtualagc/virtualagc/) project and
cross-checked against the assembler implementation and existing syntax
definitions:

- `yaYUL/Pass.c` - reference for the assemblers basic, interpretive, pseudo-op
  and downlink instruction tables.
- `Contributed/SyntaxHighlight/jEdit/assembly-agc.xml` - reference for
  instruction and directive coverage.
- `Contributed/SyntaxHighlight/Kate/agc.xml`,
  `Contributed/SyntaxHighlight/Vim/agc.vim` and
  `Contributed/SyntaxHighlight/Prettify/lang-agc.js` - additional references
  for labels, numbers, comments and the basic instruction set.

## License

[MIT](LICENSE)
