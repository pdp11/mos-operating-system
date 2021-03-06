	.TITLE	MACRO DEFINITIONS FOR MOS STRUCTURES


	.MACRO	$LABEL	LBL,NUM
LBL'NUM::
	.ENDM


	.MACRO	$ASSGN	LABEL,OFFSET
	.LIST
LABEL	=	OFFSET
	.NLIST
	.ENDM


	.MACRO	BYTE	LABEL
	.NLIST
	.IF NB,	LABEL
	$ASSGN	LABEL,\..OFST
	.ENDC
..OFST	=	..OFST+1
	.LIST
	.ENDM

	.MACRO	WORD	LABEL
	.NLIST
	.IF NE,	..OFST&1		;ODD ADDRESS?
	.ERROR	..OFST			;WORD FIELD ALIGNMENT ERROR
	.ENDC
	.IF NB,	LABEL
	$ASSGN	LABEL,\..OFST
	.ENDC
..OFST	=	..OFST+2
	.LIST
	.ENDM

	.MACRO	DWORD	LABEL
	.NLIST
	.IF NE,	..OFST&1		;ODD ADDRESS?
	.ERROR	..OFST			;DOUBLE WORD ALIGNMENT ERROR
	.ENDC
	.IF NB,	LABEL
	$ASSGN	LABEL,\..OFST
	.ENDC
..OFST	=	..OFST+4
	.LIST
	.ENDM

	.MACRO	BUFFER	LABEL,LENGTH
	.NLIST
	$ASSGN	LABEL,\..OFST
..OFST	=	..OFST+<LENGTH>
	.LIST
	.ENDM


	.MACRO	$DFPCT			;DEFINE FORMAT OF PROCESS CONTROL TABLE
PCTRLN	=	9.
PCTNLN	=	6
..OFST=0
	WORD	PCTLNK			;LINK TO NEXT PCT INN LIST
	BYTE	PCTPID			;PROCESS ID
	BYTE	PCTNUL			;UNUSED
	WORD	PCTFLG			;PROCESS CONTROL FLAGS
PS.FZN	=	1			;PROCESS FROZEN
PS.BPT	=	2			;PROCESS STOPPED AT BREAKPOINT
PS.IO	=	10			;PROCESS WAITING FOR I/O 
PS.DET	=	20			;PROCESS DETACHED FROM I/O TERMINAL
PS.SPN	=	PS.FZN!PS.BPT!PS.IO!PS.DET	;PROCESS SUSPENDED FLAGS
PS.NPL	=	100			;PROCESS INSIDE SYSTEM CALL
PS.NDB	=	200			;PROCESS NOT BEING DEBUGGED
PS.PMT	=	1000			;ALLOWED TO PREEMPT THIS PROCESS
PS.MMS	=	2000			;ALLOWED TO RUN ALL MESSAGES
PS.RDY	=	100000			;PROCESS ON RUN-QUEUE
	WORD	PCTMQH			;MESSAGE QUEUE HEAD POINTER
	WORD	PCTMQT			;MESSAGE QUEUE TAIL POINTER
	WORD	PCTSP			;STACK POINTER SAVE AREA
	BUFFER	PCTREG,<2*PCTRLN>	;REGISTER SAVE AREA
	WORD	PCTDBG			;OPC/PID OF DEBUGGER OF THIS PROCESS
	WORD	PCTDBF			;DEBUGGER FLAGS
	WORD	PCTENT			;PROCESS ENTRY POINT
	BUFFER	PCTNAM,PCTNLN		;PROCESS NAME
	WORD	PCTDPI			;DEFAULT PRIMARY INPUT DEVICE
	WORD	PCTDPO			;DEFAULT PRIMARY OUTPUT DEVICE
	WORD	PCTPRI			;PRIMARY INPUT DEVICE NUMBER
	WORD	PCTPRO			;PRIMARY OUTPUT DEVICE NUMBER
	WORD	PCTUS1			;USER AVAILABLE
	WORD	PCTUS2			;USER AVAILABLE
	WORD	PCTUS3			;USER AVAILABLE
	BUFFER	PCTIBR,IORBL		;SYNCHRONOUS I/O REQUEST BLOCK
	WORD	PCTSGD			;STACK GUARD WORD
	BUFFER	PCTSTK,STKLEN		;PROCESS STACK AREA
PCTLEN	=..OFST				;LENGTH OF PROCESS CONTROL TABLE
	.ENDM


	.MACRO	$DFIOR			;DEFINE FORMAT OF I/O REQUEST INFO BLK
..OFST=0
	WORD	IRLINK			;LINK TO NEXT IORB ON QUEUE
	WORD	IRDEV			;ADDRESS OF DEVICE CONTROL TABLE
	BYTE	IROPC			;I/O COMPLETION SIGNAL OPCODE
	BYTE	IRPID			;REQUESTOR'S PCT ADDRESS
	WORD	IRUVA			;BUFFER ADDRESS
	BYTE	IRXM			;EXTENDED MEMORY ADDRESS
	BYTE	IRUS1			;UNUSED
	WORD	IRBR			;BUFFER LENGTH (BYTE REQUESTED)
	WORD	IRSTA			;TRANSFER STATUS
	WORD	IRBX			;BYTES TRANSFERRED
	WORD	IRUS2			;UNUSED
	WORD	IRUS3			;UNUSED
	WORD	IRUS4			;UNUSED
	WORD	IRUS5			;UNUSED
	WORD	IRUS6			;UNUSED
IORBL	=	..OFST			;LENGTH OF I/O REQUEST BLOCKS
	.ENDM


	.MACRO	$DFDCT			;DEFINE FORMAT OF DEVICE CONTROL TABLE
..OFST=-4
	WORD	DCTIHX			;INTERRUPT HANDLER XFR, JSR R0,@(PC)+
	WORD	DCTIHA			;INTERRUPT HANDLER ADDRESS
	.IF NE,	..OFST
	.ERROR	..OFST			;BAD DCT FORMAT
	.ENDC
	WORD	DCTQH			;DEVICE QUEUE HEAD, INDEX OF 0
	WORD	DCTQT			;  AND TAIL
	WORD	DCTLNK			;ADDR OF ASSOCIATED (LINKED) DCT
	WORD	DCTIVA			;INTERRUPT VECTOR ADDRESS
	WORD	DCTINA			;DEVICE INITIALIZE ROUTINE ADDRESS
	WORD	DCTCSR			;DEVICE COMMAND/STATUS REG ADDRESS
	WORD	DCTBUF			;DEVICE DATA BUFFER ADDRESS
	WORD	DCTDVA			;DRIVER XFR START ADDRESS
	WORD	DCTDVN			;SYSTEM DEVICE NUMBER
	WORD	DCTDV			;DEVICE NUMBER WITHIN DEVICE GROUP
	WORD	DCTFLG			;DEVICE INDICATOR FLAGS
DF.OFL	=	100000			;DEVICE OFF-LINE
DF.INI	=	40000			;DEVICE INITIALIZED
DF.HLD	=	1			;HOLD OUTPUT
DF.STP	=	2			;OUTPUT BEING HELD
DF.DWN	=	4			;INTERFACE DOWN
DF.RUN	=	40			;SET TO INDICATE INTERFACE RUNNING
DF.ACT	=	100			;INTERFACE ACTIVE
DF.DV1	=	1000			;PER DEVICE FLAG BITS
DF.DV2	=	2000
	WORD	DCTUVA			;DRIVER BUFFER POINTER 
	WORD	DCTBR			;DRIVER BYTE COUNT
	WORD	DCTDV1			;UNUSED
	WORD	DCTDV2			;UNUSED
	WORD	DCTDV3			;UNUSED
DCTBLN	=	..OFST			;LENGTH OF MAIN PART OF DCT
	BYTE	DCTCRF			;CARRIAGE RETURN PADDING COUNTER
	BYTE	DCTNUL			;UNUSED
	WORD	DCTRC			;RING BUFFER CHARACTER COUNT
	WORD	DCTFNT			;TTY INPUT RING BUFFER FRONT
	WORD	DCTEND			;  AND ENDING ADDRESSES
	WORD	DCTHD			;RING BUFFER HEAD POINTER
	WORD	DCTTL			;  AND TAIL POINTER
	BUFFER	DCTRNG,20.		;TTY INPUT RING BUFFER, 20 CHARS LONG
DCTTLN	=	..OFST
	.ENDM


	.MACRO	$DFSD			;DEFINE FORMAT OF STORAGE DESCRIPTOR
..OFST=0
	WORD	SDSIZ			;SIZE OF EACH BLOCK
	WORD	SDLNK			;LINK TO NEXT FREE BLOCK
SDLEN	=	..OFST			;LENGTH OF STORAGE DESCRIPTOR ENTRY
	.ENDM


	.MACRO	$DFIST
;
;I/O STATUS WORD
;
I.ERR	=	^O100000		;I/O ERROR
I.DONE	=	^O200			;I/O COMPLETE
;
;
;ERROR CATEGORIES(LO-BYTE)
;
I.NOP	=	0			;NOP
I.UER	=	2			;USER ERROR
I.DER	=	4			;DEVICE ERROR
;
;DEVICE CODES(HI-BYTE)
;
I.OFLN	=	^O1*^O400		;DEVICE OFF-LINE
I.EOM	=	^O2*^O400		;END OF MEDIUM
I.DAT	=	^O3*^O400		;DATA ERROR
I.OVFL	=	^O4*^O400		;DATA OVERFLOW(OVERRUN) ERROR
I.HRDE	=	^O5*^O400		;HARD DEVICE ERROR
I.EOF	=	^O6*^O400		;END OF FILE MARK
I.OTER	=	^O7*^O400		;OUTPUT ERROR
I.IPPE	=	^O10*^O400		;IPP MATE ERROR
I.RNGE	=	^O11*^O400		;RING BUFFER ERROR
I.NXME	=	^O12*^O400		;NON-EXISTENT MEMORY ERROR
I.ATTN	=	^O13*^O400		;ATTENTION ON
I.DEAD	=	^O14*^O400		;DEVICE ADDRESS ERROR
I.FLSH	=	^O15*^O400		;DEVICE OUTPUT FLUSHED
;
;
;USER CODES(HI-BYTE)
;
I.NDEV	=	^O1*^O400		;NON-EXISTENT DEVICE
I.UNDF	=	^O2*^O400		;UNDEFINED DEVICE
I.ALER	=	^O3*^O400		;DEVICE ALRDY ALLOCATED ERROR
I.FNER	=	^O4*^O400		;ILLEGAL FUNCTION ERROR
I.UNPV	=	^O5*^O400		;UNPRIVILEGED I/O REQ ERROR
I.WPER	=	^O6*^O400		;WRITE PROTECT ERROR
I.ODAD	=	^O7*^O400		;ODD ADDRESS ERROR
I.DAER	=	^O10*^O400		;DEVICE ADDRESS ERROR
;
	.ENDM


	.MACRO	$DFMQE			;DEFINE MESSAGE QUEUE ELEMENT FORMAT
..OFST=0
	WORD	MQLINK			;LINK TO NEXT MQ ELEMENT
	BYTE	MQOPC			;MESSAGE SIGNAL OPCODE
	BYTE	MQPID			;SIGNALLER'S PID
	WORD	MQDATA			;SIGNAL DATA
MQELEN	=	..OFST
	.ENDM



	.MACRO	$DFTQE			;DEFINE TIMER QUEUE ELEMENT FORMAT
..OFST=0
	WORD	TQLINK			;LINK TO NEXT TIMER QUEUE ELEMENT
	BYTE	TQPID			;ID OF PROCESS TO SIGNAL
	BYTE	TQOPC			;OPCODE TO SIGNAL WITH
	WORD	TQDATA			;TIMER SIGNAL DATA
	WORD	TQINT			;TIMER SIGNAL INTERVAL
	WORD	TQCNT			;TIMER WORKING COUNTER
TQELEN	=	..OFST
	.ENDM


	.MACRO	$DFCHR			;DEFINE CHARACTER EQUATES
NUL	=	0			;NULL
CNTRLA	=	1			;BACKSPACE (CONTROL A)
CNTRLC	=	3			;COMMAND ABORT (CONTROL C)
CNTRLG	=	7			;BELL (CONTROL G)
BEL	=	7			;BELL (CONTROL G)
CNTRLH	=	10			;BACKSPACE (CONTROL H)
BS	=	10			;BACKSPACE (CONTROL H)
LF	=	12			;LINE FEED
CR	=	15			;CARRIAGE RETURN
CNTRLO	=	17			;OUTPUT FLUSH (CONTROL O)
CNTRLP	=	20			;OPCON INTERRUPT CHARACTER			
CNTRLQ	= 	21			;LOSING VT52'S
CNTRLS	=	23
CNTRLU	=	25			;COMMAND ABORT (CONTROL U)
SPACE	=	40			;SPACE
DEL	=	177			;DELETE
	.ENDM	$DFCHR
