; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		dereference.asm
;		Purpose:	Dereference ... references
;		Created:	29th November 2023
;		Reviewed:	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Dereference a term
;
; ************************************************************************************************

DereferenceTOS:	
		lda 	XSControl,x 				; check if reference ?
		and 	#XS_ISREFERENCE
		beq 	_DRTExit 					; no, exit
		;
		lda 	XSNumber0,x 				; copy address to zTemp0
		sta 	zTemp0
		lda 	XSNumber1,x
		sta 	zTemp0+1
		;
		lda 	XSControl,x 				; clear reference bits.
		pha 								; preserve ref bits so we can check byte.
		and 	#$FF-XS_ISREFERENCE-XS_ISBYTEREFERENCE
		sta 	XSControl,x
		pla
		and 	#XS_ISBYTEREFERENCE
		bne 	_DRTByteRef

		phy 								; word reference.
		lda 	(zTemp0)
		sta 	XSNumber0,x
		ldy 	#1
		lda 	(zTemp0),y
		sta 	XSNumber1,x
		iny
		lda 	(zTemp0),y
		sta 	XSNumber2,x
		iny
		lda 	(zTemp0),y
		sta 	XSNumber3,x
		ply
		bra 	_DRTExit

_DRTByteRef:		 						; byte reference
		lda 	(zTemp0)
		sta 	XSNumber0,x
		stz 	XSNumber1,x
		stz 	XSNumber2,x
		stz 	XSNumber3,x
_DRTExit:		
		rts

		.send 		code

; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;
; ************************************************************************************************

