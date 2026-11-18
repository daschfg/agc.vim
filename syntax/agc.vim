" Vim syntax file
" Language:    AGC (Apollo Guidance Computer) assembly / YUL
" Maintainer:  Daniel Schubert
"
" Covers AGC/YUL assembly source (Block I and Block II), as assembled by
" yaYUL.
"
" Token information was researched using the VirtualAGC project:
"   https://github.com/virtualagc/virtualagc
"
"   * yaYUL/Pass.c
"   * Contributed/SyntaxHighlight/jEdit/
"   * Contributed/SyntaxHighlight/Kate/
"   * Contributed/SyntaxHighlight/Vim/

" Only one syntax file per buffer.
if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'agc'

" AGC source is conventionally upper-case, but the assembler accepts either,
" so highlighting is case-insensitive.
syntax case ignore

" Treat AGC symbol punctuation as keyword characters for the syntax engine, so
" that a symbol such as 'VN-FLSH' or 'CM/SWIC2' is not partially matched by a
" shorter instruction/pseudo-op keyword (e.g. 'VN').  This is syntax-local and
" does not change the 'iskeyword' option.
syntax iskeyword clear
syntax iskeyword @,48-57,_,-,/,.,+,$

" Operators are defined first so that longer tokens defined below win when
" they start at the same column (e.g. '-CCS', '=MINUS', 'STODL*').
" Arithmetic/relative operators are not matched when embedded between keyword
" characters, so the '-' in a symbol such as 'VN-FLSH' stays unhighlighted.
" Parentheses are not operators here: they are legal symbol characters
" (e.g. 'V(32K)').
syntax match agcOperator "[=,]"
syntax match agcOperator "\%(\k\)\@<![-+*/]\%(\k\)\@!"

" ---------------------------------------------------------------------------
" Block I + Block II basic instructions
" ---------------------------------------------------------------------------
syntax keyword agcBasicOp
      \ AD ADS CA CAE CAF CCS COM CS DAS DDOUBL DOUBLE DTCB DTCF DXCH EXTEND
      \ INDEX NDX INHINT LXCH MASK MSK NOOP OVSK OVIND RELINT RESUME RETURN
      \ TC TCR TCAA TCF TS XCH XLQ XXALQ XAQ ZL

" ---------------------------------------------------------------------------
" Extended (extracode) instructions (require a preceding EXTEND)
" ---------------------------------------------------------------------------
syntax keyword agcExtOp
      \ AUG BZF BZMF DCA DCOM DCS DIM DV EDRUPT MP MSU QXCH RAND READ ROR
      \ RXOR SQUARE SU WAND WOR WRITE ZQ

" ---------------------------------------------------------------------------
" Interpretive instructions (executed by the interpreter, entered via TC INTPRET)
" ---------------------------------------------------------------------------
syntax keyword agcInterpOp
      \ ABS ABVAL ARCCOS ACOS ARCSIN ASIN BDDV BDSU BHIZ BMN BOFCLR BOF BOFF
      \ BOFINV BOFSET BON BONCLR BONINV BONSET BOV BOVB BPL BVSU BZE CALL
      \ CALRB CCLRB CCALL CGOTO CLEAR CLR CLRGO COMP COS COSINE CROSS DAD
      \ DCOMP DBSU DDV DLOAD DMOVE DMP DMPR DOT DSQ DSU DTS EXIT GOTO INVERT
      \ INVGO ITA ITC ITCI ITCQ LOAD LODON MXV NOLOD NORM PDDL PDVL PUSH ROUND
      \ RTB RVQ SET SETGO SETPD SHIFTL SHIFTR SIGN SIN SINE SL SLOAD SL1 SL1R
      \ SL2 SL2R SL3 SL3R SL4 SL4R SLR SMOVE SQRT SR SR1 SR1R SR2 SR2R SR3
      \ SR3R SR4 SR4R SRR SSP STADR STCALL STODL STORE STOVL STQ STZ SWITCH
      \ TAD TEST TLOAD TMOVE TRAD TSLC TSU TTS UNIT VAD VCOMP VDEF VLOAD
      \ VMOVE VPROJ VSL VSL1 VSL2 VSL3 VSL4 VSL5 VSL6 VSL7 VSL8 VSQ VSR VSR1
      \ VSR2 VSR3 VSR4 VSR5 VSR6 VSR7 VSR8 VSU VTS VXM VXSC VXV

" Interpretive instructions carrying a trailing '*'.
syntax match agcInterpOp
      \ "\<\%(ABS\|BDDV\|BDSU\|BVSU\|CCALL\|CGOTO\|COMP\|COS\|DAD\|DDV\|DLOAD\|DMP\|DMPR\|DMOVE\|DOT\|ITC\|MXV\|NORM\|PDDL\|PDVL\|SIGN\|SLR\|SL\|SLOAD\|SMOVE\|SRR\|SR\|SSP\|STODL\|STOVL\|TAD\|TLOAD\|TSLT\|TSRT\|V/SC\|VAD\|VLOAD\|VMOVE\|VPROJ\|VSLT\|VSL\|VSRT\|VSR\|VSU\|VXM\|VXSC\|VXV\)\*"

" INCR is a basic opcode, but INCR,1 / INCR,2 are interpretive index ops.
" Use a match so the longer comma form below can take precedence.
syntax match agcBasicOp "\<INCR\>"

" Interpretive index instructions taking a ",1" / ",2" index suffix.
syntax match agcInterpOp "\<\%(AXC\|AXT\|INCR\|LXA\|LXC\|SXA\|TIX\|XAD\|XCHX\|XSU\),[12]\>"

" Vector scalar divide (contains a slash, no index suffix).
syntax match agcInterpOp "\<V/SC\*\?"

" ---------------------------------------------------------------------------
" Pseudo-ops / directives
" ---------------------------------------------------------------------------
syntax keyword agcPseudo
      \ BANK BLOCK SETLOC LOC COUNT OCT OCTAL DEC MM EQUALS ERASE MEMORY SUBRO
      \ BNKSUM BBCON CADR FCADR XCADR ADRES ECADR GENADR REMADR SECSIZ NV VN
      \ 2CADR 2FCADR 2BCADR 2DEC 2OCT

" Pseudo-ops carrying a trailing '*'.
syntax match agcPseudo "\<\%(COUNT\|DEC\|2DEC\|BBCON\)\*"

" Equate-form directives and pseudo-ops.
syntax match agcPseudo "\<\%(EBANK\|SBANK\|CHECK\)="
syntax match agcPseudo "\%(^\|\s\)\@<==\%(MINUS\|ECADR\)\>"

" Dash-prefixed variants.
syntax match agcBasicOp  "\%(^\|\s\)\@<=-CCS\>"
syntax match agcPseudo   "\%(^\|\s\)\@<=-\%(CADR\|2CADR\|GENADR\)\>"
syntax match agcDownlink "\%(^\|\s\)\@<=-\%(1DNADR\|2DNADR\|3DNADR\|4DNADR\|5DNADR\|6DNADR\|DNCHAN\|DNPTR\)\>"

" ---------------------------------------------------------------------------
" Downlink directives
" ---------------------------------------------------------------------------
syntax keyword agcDownlink 1DNADR 2DNADR 3DNADR 4DNADR 5DNADR 6DNADR DNCHAN DNPTR

" ---------------------------------------------------------------------------
" Special registers
" ---------------------------------------------------------------------------
syntax keyword agcRegister
      \ A L Q Z EB FB BB ARUPT LRUPT QRUPT ZRUPT BBRUPT BRUPT CYL EDOP

" ---------------------------------------------------------------------------
" Symbols, numbers, operators
" ---------------------------------------------------------------------------

" Labels: any non-blank, non-comment run beginning in column 1.
syntax match agcLabel "^[^#[:space:]]\+"
" Relative labels (' +1', '-2').
syntax match agcRelativeLabel "^\s\+[+-]\d\+\>"

" '$'-prefixed symbols and relative references ($2, $450, $/EXTVB).
syntax match agcDollar "\$\S\+"
" '$'-prefixed source includes in column 1.  Defined after agcLabel/agcDollar
" so it wins on a bare include line.
syntax match agcInclude "^\$.*$"

" Decimal (trailing 'D') and octal numbers.  The explicit terminator set keeps
" numbers from being swallowed by, or swallowing, longer tokens such as
" '2DEC', '1DNADR', or '02/ALARM' now that symbol punctuation is a keyword char.
" Plain digit runs are highlighted as numbers whatever their base (an octal
" literal cannot contain 8/9, but 'DEC 8' is common and should still match).
syntax match agcNumber "\<[+-]\?\d\+D\ze\%(\s\|$\|#\|[,/.()+-]\)"
syntax match agcNumber "\<[+-]\?\d\+\ze\%(\s\|$\|#\|[,/.()+-]\)"

" Double-quoted strings (rare, but harmless to support).
syntax match agcString /"[^"]*"/

" ---------------------------------------------------------------------------
" Comments
" ---------------------------------------------------------------------------
syntax match agcComment "#.*$"
" Doubled/tripled '#' mark page and file sections.
syntax match agcPageComment "^#\{2,}.*$"

" ---------------------------------------------------------------------------
" Highlighting
" ---------------------------------------------------------------------------
highlight def link agcComment       Comment
highlight def link agcPageComment   SpecialComment
highlight def link agcLabel         Function
highlight def link agcRelativeLabel Label
highlight def link agcBasicOp       Statement
highlight def link agcExtOp         Keyword
highlight def link agcInterpOp      Type
highlight def link agcPseudo        PreProc
highlight def link agcDownlink      PreCondit
highlight def link agcRegister      Identifier
highlight def link agcNumber        Number
highlight def link agcDollar        Special
highlight def link agcOperator      Operator
highlight def link agcInclude       Include
highlight def link agcString        String

" vim: ts=8 sw=2 et
