	.NLIST


	.MACRO	$DFNCT			;Define network characteristics table
..OFST=0
	WORD	NT.UP			;Network initialization routine
	WORD	NT.IN			;Network input transfer init routine
	WORD	NT.INC			;Network input transfer completion 
	WORD	NT.OT			;Network output transfer init routine
	WORD	NT.DWN			;Network down routine
	WORD	NT.HL			;Header length, bytes
	WORD	NT.TL			;Trailer length bytes
	WORD	NT.RL			;Maximum receive packet size
	WORD	NT.SL			;Maximum send packet size
	WORD	NT.DVI			;Input device number
	WORD	NT.DVO			;Output device number
	.ENDM	$DFNCT


	.MACRO	GWAY	A,B,C		;Define gateway table entry
	.BYTE	0
	.BYTE	A
	.IF NB,	B
	.BYTE	B
	.IFF
	.BYTE	0
	.ENDC
	.IF NB,	C
	.BYTE	C
	.IFF
	.BYTE	0
	.ENDC
	.ENDM	GWAY


ER.INH	=	100			;INET header problems
ER.FRG	=	101			;INET segment fragmented
ER.SIZ	=	102			;Size is wrong
ER.DWN	=	103			;Network is down
ER.LNH	=	104			;Local network header problems
ER.CTL	=	105			;Local netowkr control msg


	.LIST

