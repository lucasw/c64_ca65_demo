* = $801
; https://www.reddit.com/r/c64/comments/5zcaa3/learning_c64_assembler_with_vice_on_ubuntu_where/?st=jdd7t22z&sh=2f0c2f71#bottom-comments
; acme -f cbm -o test.prg test.s
; x64 test.prg
; this is a sample BASIC program required to start our code
!byte $0c,$08,$0a,$00
!byte $9e ; sys
!text "2068 :-)"
!byte $00,$00,$00,$00

; generated with spritemate on 2/8/2018, 5:07:09 PM


*=$0814


; our code starts here

; load car_sprite to ram $3000
; http://www.cbmhardware.de/c64/acmes4.php
ldx #$3f
load_car_row:
lda car_sprite, x
sta $3000, x
dex
bpl load_car_row

lda #$c0  ; $3000/64 = $3000/$40 = $c0
sta $07f8

; put sprite 0 in to multicolor mode
; lda $d01c
lda #%00000001
sta $d01c

lda #0 ; sprite multicolor 1
sta $d025
lda #6 ; sprite multicolor 2
sta $d026

; put color 0 into border color
; ldx #$ff
; start:
; sty $d020  ; border color
; stx $d021  ; bg color around text
; txa
; jsr $ffd2  ; output character in a to screen
; dex
; iny
; cpx #$00
; bne start

; enable sprite 0
; lda $d015
lda #%00000001
sta $d015

; TODO(lucasw) this is clobbering d015 and d01c
; set xy coordinata sprite 0
lda #$00
ldx #$10
move_sprite:
sta $d020  ; border color
stx $d000
ldy #20
sty $d001
inx
ina
; cpx #$ff
; bne move_sprite
; jmp move_sprite

lda #$01
sta $d020  ; border color

car_sprite
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $aa,$00,$00,$bf,$80,$00,$82,$e0
!byte $02,$82,$38,$2a,$aa,$aa,$2a,$ba
!byte $aa,$2a,$aa,$aa,$2a,$aa,$aa,$2a
!byte $aa,$aa,$3f,$ff,$d7,$15,$7f,$55
!byte $15,$40,$55,$05,$00,$14,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$83
