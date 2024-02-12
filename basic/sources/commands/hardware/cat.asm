; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		cat.asm
;		Purpose:	Display directory
;		Created:	18th December 2023
;		Reviewed:   No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;										CAT Command
;
; ************************************************************************************************

		.section code

Command_CAT:	;; [cat]
		lda 	(codePtr),y
		cmp 	#KWD_SYS_END
		beq 	_CATDefault
		cmp 	#KWD_COLON
		beq 	_CATDefault
		;
		jsr 	EXPEvalString
		lda 	zTemp0
		sta 	ControlParameters
		lda 	zTemp0+1
		sta 	ControlParameters+1
		DoSendMessage
		.byte 	3,32
		rts


_CATDefault:		
		DoSendMessage
		.byte 	3,1
		rts


		.send code

; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;		10-02-24 		Modifications to support wildcard
;
; ************************************************************************************************
