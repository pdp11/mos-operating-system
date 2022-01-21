.NLIST

	.MACRO	$DFHDR			;DEFINE LOCAL NETWORK HEADER FORMAT
..OFST=0
	BYTE	HHDRL			;SPP HEADER LENGTH
	BYTE	HPKTL			;SPP PACKET LENGTH, WORDS
	WORD	HSRC			;SPP SOURCE
	WORD	HDSTN			;SPP DESTINATION
	WORD	HSEQ			;SPP SEQUENCE NUMBER
HS.RCF	=	7			;SPP RETRANSMIT FIELD MASK IN SEQ. NO.
	WORD	HCNTL			;SPP PACKET ID AND FUNCTION
HC.FCN	=	7			;PACKET FUNCTION
 HF.NC	=	0			;  =0, NON-CONNECTION PACKET
 HF.SPP	=	4			;  SPP CONNECTION PACKET
 HF.SYN	=	1			;  SPP OPEN CONNECTION REQUEST
 HF.FIN	=	2			;  SPP CLOSE CONNECTION REQUEST
HC.DIR	=	10			;PACKET DIRECTION, 1= TOWARDS STATION
HC.ACK	=	20			;END-TO-END ACKNOWLEDGE
HC.TYP	=	340			;PACKET TYPE
 HT.ROP	=	0*40			;  =0, ROP PACKET
 HT.LBL	=	1*40			;  =1, LABEL PACKET
 HT.CP	=	2*40			;  =2, PR CONTROL PACKET
 HT.IP	=	3*40			;  =3, INFORMATION PACKET
 HT.CPD	=	4*40			;  =4, CONTROL PACKET DATA
HC.LVL	=	17*400			;HOP POINTER
HC.ACT	=	20*400			;ACTIVE ACKNOWLEDGE PACKET
HC.ARP	=	40*400			;ALTERNATE ROUTING IN PROGRESS
HC.ARQ	=	100*400			;END-TO-END ACKNOWLEDGE REQUESTED
HC.ART	=	200*400			;ALTERNATE ROUTED
	WORD				;WORKING HOP COUNT
	WORD				;MEASUREMENT STUFF
	WORD	HPRW0			;PACKET ROUTE WORD 0
	WORD	HPRW1			;PACKET ROUTE WORD 1
	WORD	HPRW2			;PACKET ROUTE WORD 2
	WORD	HPRW3			;PACKET ROUTE WORD 3
SPPHDL	=	..OFST			;LENGTH OF SPP HEADER
	BUFFER	PKTTXT,<127.*2-SPPHDL>	;SPP PACKET TEXT
	WORD	PKTTMH			;TIME-STAMP ON OUTPUT, HI
	WORD	PKTTML			;  AND LOW ORDER
CHKLEN	=	2.			;NO. OF CHECKSUM WORDS
PKTLEN	=	..OFST			;LENGTH OF A PACKET
	.ENDM

	.MACRO	$DFMDB			; DEFINE MATCH DESCRIPTOR BLOCL

..OFST	=	0

	WORD	MDLCLM			; LOCAL ID MASK WORD
	WORD	MDLCLC			; LOCAL ID COMPARE WORD
	WORD	MDFGNM			; FOREIGN ID MASK WORD
	WORD	MDFGNC			; FOREIGN ID COMPARE WORD
	WORD	MDCTLM			; CONTROL WORD MASK WORD
	WORD	MDCTLC			; CONTROL WORD COMPARE WORD
MDBLEN	=	..OFST
	.NLIST
	$DFHDR
	.LIST
DFSPPM	=	HF.SPP!HC.TYP		; DEFAULT SPP CONN. MASK WORD
DFSPPC	=	HF.SPP!HT.IP		; DEFAULT SPP CONN. COMPARE WORD
DFTRNM	=	HC.FCN!HC.TYP		; DEFAULT TRANSPARENT CONN. MASK WORD
DFTRNC	=	HF.NC!HT.IP		; DEFAULT TRANSPARENT CONN. MASK WORD

	.ENDM	$DFMDB

	.MACRO	$DFPKD			; DEFINE PACKET DESCRIPTOR BLOCK
..OFST	=	0
	WORD	PDLINK			; LINK TO NEXT PACKET DESCRIPTOR
	WORD	PDDEV			; DEVICE NO. FOR I/O REQUEST
	WORD	PDOP			; EVENT OP-CODE FOR SIGNALING I/O COMPLETE
	WORD	PDADDR			; ADDRESS OF PACKET HDR
	WORD	PDFLAG			; OPTION FLAG (TIMESTAMPING)
	WORD	PDPKLN			; PACKET LENGTH (HDR+TEXT+CHECKSUMS)
	WORD	PDSTAT			; I/O COMPLETE STATUS
	WORD	PDBX			; BYTES TRANSFERRED
	WORD	PDRTX			; RETRANSMISSION QUEUE LINK
	WORD	PDCON			; POINTER TO CONNECTION TABLE

PDLEN	=	..OFST
	.ENDM	$DFPKD


	.MACRO	$DFCCB			;DEFINE CONNECTION CONTROL BLOCK
	.NLIST
	$DFDCN
	.LIST
..OFST=0

	WORD	CLCLMK			; LOCAL ID MASK
	WORD	CLCLID			; LOCAL ID COMPARE WORD
	WORD	CFGNMK			; FOREIGN ID MASK
	WORD	CFGNID			; FOREIGN ID COMPARE WORD
	WORD	CCTLMK			; CONTROL WORD MASK
	WORD	CCTLWD			; CONTROL WORD COMPARE VALUE
	WORD	CVTPTR			; CONNECTION VECTOR TABLE POINTER
	BYTE	CONNID			; CONNECTION ID
	BYTE	COPFLG			; CONNECTION OPTION FLAGS
	BYTE	CURPID			; CONNECTION USER PID
	BYTE	CUROPC			; CONNECTION USER OP-CODE (OPEN/CLOSE)
	WORD	COPTIM			; TIME CONNECTION OPENED MSW
	WORD				; LSW 
	WORD	CSTATE			; CONNECTION STATE
	WORD	CSSNDC			; SEND COUNT
	WORD	CSNDQH			; SEND QUEUE HEAD
	WORD	CSNDQT			; SEND QUEUE TAIL
	WORD	CSEQNO			; SEND SEQUENCE NUMBER (LAST ONE USED)
	WORD	CSDLWE			; SEND LEFT WINDOW EDGE
	WORD	CRTXQH			; RETRANSMISSION QUEUE HEAD
	WORD	CRTXQT			; RETRANSMISSION QUEUE TAIL
	WORD	CRTXCT			; RETRANSMISSION COUNT
	WORD	CACKSQ			; ACK SEQUENCE NUMBER
	WORD	CSACKT			; TIME FOR ACK PKT 
	WORD				; 
	WORD	CRSQNO			; RECEIVE SEQ. NO. (LWE)
	WORD	CRCVCT			; RECEIVE COUNT (NO. OF RECEIVES ISSUED)
	WORD	CRCVQH			; RECEIVE QUEUE HEAD
	WORD	CRCVQT			; RECEIVE QUEUE TAIL
	WORD	CWRKCT			; CONNECTION WORK LEFT COUNT
	WORD	CLSTDT			; LAST PKT DELAY TIME
	BYTE	CSNDOP			; OP-CODE TO USE WHEN SENDS COMPLETE
	BYTE	CRCVOP			; OP-CODE TO USE WHEN RECEIVES COMPLETE
	WORD	CSDRPB			; "DROP PKT NO BUFFERS" COUNT
	WORD	CSLNK			; LINK TO STATISTIC TABLE IN NEXT LEVEL OF PROTOCOL
;
;	STATISTICS SECTION
;
	CSTBL	=	CSLNK+2
	WORD	CSBYTS			; NO. OF BYTES SENT (INCLUDES HEADER)
	WORD
	WORD	CSBYTR			; NO. OF BYTES RECEIVED (INCLUDES HEADER)
	WORD
	WORD	CSRTXB			; NO. OF RETRANSMITTED BYTES (INCLUDE HDR)
	WORD
	WORD	CSCUMD			; CUMMULATIVE DELAY TIME (ETE TIMES)
	WORD
	WORD	CSPKTX			; NO. OF PACKETS TRANSMITTED
	WORD	CSPKRC			; NO. OF PACKETS RECEIVED
	WORD	CSRTXP			; NO. OF PACKETS RETRANSMITTED
	WORD	CSACKS			; NO. OF ACK'S SENT
	WORD	CSACKR			; NO. OF ACK'S RECEIVED
	WORD	CSDUPA			; NO. OF DUPLICATE ACK'S RECEIVED
	WORD	CSBFRW			; NO. OF PACKETS RECEIVED BEFORE WINDOW
	WORD	CSDUPP			; NO. OF DUPLICATE PACKETS RECEIVED
	WORD	CSBYDW			; NO. OF PACKETS RECEIVED BEYOND WINDOW
	WORD	CSARQS			; NO. OF PACKETS SENT WITH ARQ SET
	WORD	CSRTFS			; DISCRETE RETRANSMISSION FREQUENCY SPRECTRUM
	.REPT	NRTXBK-1
	WORD				; 
	.ENDR
	WORD	CSETES			; END-TO-END DELAY (ACK TIME) TIME SPECTRUM
	.REPT	NETEBK-1
	WORD				; 
	.ENDR

CSLEN	=	..OFST - CSTBL		; STATISTICS SECTION LENGTH
CCBLEN	=	..OFST			; CCB LENGTH
	.ENDM	$DFCCB

	.MACRO	$DFDCN			; DEFINE DISPATCH CONSTANTS
	.MACRO	WIDTH
	.IF NE	..VAL-1
..VAL	=..VAL_-1
..WID	=..WID+1
	WIDTH
	.ENDC
	.ENDM	WIDTH

	.MACRO	LOG2	ARG,VAL
..VAL	=ARG
..WID	=0
	WIDTH
VAL	=..WID
	.ENDM	LOG2


	.NLIST
	$DFHDR
	LOG2	HS.RCF+1,VALUE		; DETERMINE WIDTH OF HS.RCF MASK
	.LIST
RCFWID	=	VALUE			; WIDTH OF HS.RCF FIELD
MAXCON	=	8.			; MAXIMUM CONNECTIONS ALLOWED
MAXRTX	=	10.			; MAXIMUM NO. OF RETRANSMISSIONS BEFORE TIMEOUT
RCVMAX	=	4.			; MAXIMUM NO. OF RECEIVES OUTSTANDING ALLOWED
RTXDLY	=	3.*60.			; RETRANSMIT DELAY OF 3. SECONDS
NRTXBK	=	10.			; NO. OR RETRANSMIT BUCKETS
RTXBKS	=	<MAXRTX+NRTXBK-1>/NRTXBK; BUCKET SIZE FOR RTX FREQ. SPECTRUM
NETEBK	=	20.			; NO. OF BUCKETS IN E-T-E DELAY SPECTRUM
ORTDLY	=	6.*60.			; ONE-ROUND-TRIP TIME DELAY 6. SECONDS

	.ENDM	$DFDCN


	.MACRO	$DFDOP			; DEFINE DISPATCH/LABLER OP-CODES

;
;	DISPATCH
;
SG.RCV	=	0			; PACKET RECEIVED FROM PRU
SG.OPN	=	1			; SEND OPEN PACKET
SG.SND	=	2			; SEND NORMAL PKT ON SEND QUEUE
SG.SNT	=	3			; PACKET JUST SENT TO PRU
SG.ACK	=	4			; SEND ACK PACKET ON SEND QUEUE
SG.CLS	=	5			; SEND CLOSE PACKET
SG.RTX	=	6			; RETRANSMIT TIMER EXPIRED
SG.ORT	=	7			; ORT TIMER EXPIRED
SG.RFA	=	10			; REFLECTED OR ACK PKT JUST SENT
SG.UP	=	11			; IMP UP SIGNAL
;
;	LABLER
;
SG.TOP	=	2			; SEND A TOP

	.ENDM

	.MACRO	$DFDST			; DEFINE DISPATCH STATES

;
;	DISPATCH STATE DEFINITION
;

ST.OPS	=	1			; OPEN PACKET HAS BEEN SENT
ST.OPA	=	2			; OPEN PACKET HAS BEEN ACKED (SEND OPEN)
ST.CLS	=	4			; CLOSE PACKET SEND (CONNECTION CLOSING)

ST.ROP	=	10			; RECEIVE SIDE OPEN (OPEN PKT BEEN RCVD)
ST.RCR	=	20			; RECEIVED CLOSE PACKET
ST.ORT	=	40			; ORT TIMER EXPIRED
ST.DEL	=	100			; CONNECTION SHOLD BE DELETED WHEN NO
					; MORE WORK LEFT ON CONNECTION
ST.ACK	=	400			; ACK RECEIVED PENDING PROCESSING
	.ENDM	$DFDST
	.LIST