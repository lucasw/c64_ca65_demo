;http://www.cbmhardware.de/c64/acmes4.php
;--------------------------------------------------------------------------
;
; Sprite - wir lassen einen fliegen ....
;
;
; Quelle : http://www.minet.uni-jena.de/~andreasg/c64/c64_vic_html.htm
; Sehr empfehlenswerte Seite zum Thema VIC 6569
;
; Erweitert : 03/2004 M. Sachse http://www.cbmhardware.de
;
;--------------------------------------------------------------------------
; acme -f cbm sprite.s
!to "sprite.prg"
;--------------------------------------------------------------------------
; sys-Zeile fuer den Basicstart
;--------------------------------------------------------------------------

*= $0800
!byte $00,$0c,$08,$0a,$00,$9e,$32,$30,$36,$34,$00,$00,$00,$00

;--------------------------------------------------------------------------
* =$0810; start address
;--------------------------------------------------------------------------
start  sei
       jsr $e544        ; clrscr
       lda #12         ; grey background and border
       sta $d020
       sta $d021

; load sprite data in loop
       ldx #$3f
sprin  lda car_sprite,x
       sta $3000,x      ; ... einlesen
       dex
       bpl sprin
; set using multi color on sprite 0
lda #%00000001
sta $d01c
; set sprite colors todo store them in car_sprite at car_sprite,63 and 64
lda #11
sta $d025
lda #10
sta $d026
lda #8
sta $d027
; position
       lda #$80         ; X-Position  #128
       sta $d001
       lda #$c0         ; Spritepointer Sprite 0
       sta $07f8        ;  $3000 = $c0*$40 - sprite pointer must be 64 aligned addr / 64
       lda #$01         ;
       sta $d017        ; X-Zoom
       sta $d01d        ; Y-Zoom
       sta $d015        ; Sprite 1 an
       ldx #$00         ;
loop:  txa              ; X-Reg. in Akku
       sta$d000         ; Psition setzen
dir:   inx              ; Main Loop  : Richtung
       jsr space        ; Space Taste abfragen
       jsr Delay        ; etwas Zeit verschwenden (Delay)
loc:   cpx #$e9         ; Position abfragen
       bne loop         ; loop bei nicht erreicht
       jsr finit        ; ansonsten Daten fuer Move nach links und Zoom (X/Y)
       cpx #$30         ; Position abfragen
       bne loop         ; loop bei nicht erreicht
       jsr binit        ; ansonsten Daten fuer Move nach rechts und kein Zoom (X/Y)
       jmp loop         ; und weiter im Loop

; end if space pressed
space  lda $dc01
       and #$10
       beq end
       rts

end :  lda #$00
       sta $d015        ; sprite 0 disable
       jmp $ea81        ; wieder ins Basic
       rts

finit  lda #$ca         ; $ca = dex
       sta dir          ; schreiben
       lda #$30         ; neue Koordinate
       sta loc+1        ; schreiben
       lda #$01         ; X/Y Zoom an
       sta $d017
       sta $d01d
       rts

binit lda #$e8          ; $e8 = inx
      sta dir           ; schreiben
      lda #$e9          ; neue Koordinate
      sta loc+1         ; schreiben
      lda #$00          ; X/Y Zoom aus
      sta $d017
      sta $d01d
      rts

;---------------------------------------------------------------------------
; A bit of delay by waiting for the raster beam
;---------------------------------------------------------------------------

Delay:
      ldy #$00
      lda $d012
      cmp #$00
      bne Delay
      iny
      cpy #$03
      bne Delay+2
      rts

car_sprite
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $aa,$00,$00,$bf,$80,$00,$82,$e0
!byte $02,$82,$38,$2a,$aa,$aa,$2a,$ba
!byte $aa,$2a,$aa,$aa,$2a,$aa,$aa,$2a
!byte $aa,$aa,$3f,$ff,$d7,$15,$7f,$55
!byte $15,$40,$55,$05,$00,$14,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$83
