	.NLIST

	.MACRO	$PROPN	FLAGS,OPCODE,BLOCK
	.NARG	ARGNO.			;ARGNO.=NO. OF ARG SPECIFIED.
	KRTARG	2,ARGNO.		;WAS ENOUGH ARG. SPECIFIED
	CNFL	BLOCK,R0		;IS THERE A CONFLICT IN REGISTERS
	GNCD2	FLAGS,OPCODE,R0		;GEN. CODE FOR REG 0
	GNCD	BLOCK,R1		;PUT DATA INTO R1
	EMT	^O20
	.ENDM


	.MACRO	$PRRCV	OPCODE,CONID
	.NARG	ARGNO.
	KRTARG	1,ARGNO.
	GNCD2	OPCODE,CONID,R0
	EMT	^O21
	.ENDM

	
	.MACRO	$PRSND	CONID,PKT
	.NARG	ARGNO.
	KRTARG	1,ARGNO.
	CNFL	PKT,R0
	GNCDB	CONID,R0
	GNCD	PKT,R1
	EMT	^O22
	.ENDM


	.MACRO	$PRCLS	OPCODE,CONID
	.NARG	ARGNO.
	KRTARG	1,ARGNO.
	GNCD2	OPCODE,CONID,R0
	EMT	^O23
	.ENDM



	.MACRO	$DFDOF			;DEFINE DISPATCH OPTION FLAGS

DF.TRN	=	1			; TRANSPARENT CONNECTION
DF.NTP	=	2			; DON'T SEND TOP FOR THIS LOCAL ID
DF.LSN	=	4			; LISTENING DISPATCH CONNECTION
DF.ARQ	=	10			; ASK FOR E-T-E ACK
DF.DFC	=	20			; USE DEFAULT FUNCTION ID & MASK VALUES
DF.HSP	=	40			; HEADER IS SUPPLIED WITH PKT ON SENDS
DF.SNK	=	100			; SINK PACKETS RECEIVED ON CONNECTION
DF.FWD	=	200			; FORWARD PACKETS THROUGH STATION

	.ENDM


	.MACRO	$DFDSC			; DEFINE DISPATCH STATUS CODES

SC.NST	=	201			; NO STORAGE
SC.COP	=	202			; CONNECTION ALREADY OPEN
SC.CNO	=	203			; CONNECTION NOT OPEN
SC.NXC	=	204			; NON-EXISTENT CONNECTION
SC.CLR	=	206			; CLOSED REMOTELY
SC.RTT	=	210			; RETRANSMISSION TIMEOUT
SC.MXR	=	211			; MAXIMUM OUTSTANDING RECEIVES EXCEEDED
SC.CLD	=	212			; CONNECTION BEING CLOSED
	
	.ENDM	$DFDSC
	.LIST
