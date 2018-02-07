* = $801
; https://www.reddit.com/r/c64/comments/5zcaa3/learning_c64_assembler_with_vice_on_ubuntu_where/?st=jdd7t22z&sh=2f0c2f71#bottom-comments
; acme -f cbm -o test.prg test.s
; x64 test.prg
; this is a sample BASIC program required to start our code
!byte $0c,$08,$0a,$00
!byte $9e ; sys
!text "2068 :-)"
!byte $00,$00,$00,$00

*=$0814

; our code starts here
; put color 0 into border color
ldy #$0a
ldx #$00
start:
sty $d020  ; border color
stx $d021  ; bg color around text
inx
dey
jmp start
rts
