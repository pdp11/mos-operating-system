
;
; Field definitions for all protocol headers
;

;Define internetwork v4 header
..OFST=0
	BYTE	IH.VER			;Version and header length
IH.HL	=	17			;Mask for extracting header length
IH.VSN	=	36			;Mask for extracting version number
	BYTE	IH.TOS			;Type of service
	WORD	IH.FL			;Total fragment length
	WORD	IH.ID			;Segment ID
	WORD	IH.FRG			;Fragmentation info
IH.MF	=	100000			;  More fragments flag
IH.DF	=	20000			;  Don't fragment flag
IH.OFF	=	17777			;  Fragment offset
	BYTE	IH.TTL			;Time to live
	BYTE	IH.PRO			;Protocol number
	WORD	IH.CHK			;Inet header checksum
	DWORD	IH.SRC			;Source INET ID
	DWORD	IH.DST			;Destination INET ID
IH.LEN	=	..OFST			;Length of INET header



;Define the pseudo header
..OFST=0
	DWORD	PH.SRC			;Source INET ID
	DWORD	PH.DST			;Destination INET ID
	BYTE	PH.PAD			;Pseudo-header padding
	BYTE	PH.PRO			;Protocol number
	WORD	PH.DL			;Amount of INET data
PH.LEN	=	..OFST			;Length of pseudo header



;Define format of INET address field
..OFST=0
	BYTE	ID.NET			;Network ID
	BYTE	ID.HI			;Tcp ID, high byte
	BYTE	ID.MID			;  middle byte
	BYTE	ID.LO			;  & low byte


	
;Define format of TCP v4 header
..OFST=PH.LEN				;Start after pseudo-header
	WORD	TH.SP			;Source port id
	WORD	TH.DP			;Destination port id
	DWORD	TH.SEQ			;Sequence number
	DWORD	TH.ACK			;Acknowledgement sequence number
	BYTE	TH.HLN			;Header length (hi nibble)
	BYTE	TH.CTL			;Control flags
TC.FIN	=	1			;Finished 
TC.SYN	=	2			;Sync request
TC.RST	=	4			;Reset this connection
TC.EOL	=	10			;End of letter
TC.ACK	=	20			;Acknowledgement present
TC.URG	=	40			;Urgent data present
	WORD	TH.WDW			;Window size
	WORD	TH.CHK			;Checksum
	WORD	TH.URG			;Urgent pointer offset
TH.LEN	=	..OFST			;Length of fixed tcp header


;Define ARPANET 96-bit leader format
..OFST=0
	BYTE	AH.FMT			;ARPANET new format flags (=17)
	BYTE	AH.NET			;Destination NET - unused
	BYTE	AH.FLG			;Flags
	BYTE	AH.TYP			;Message type
	BYTE	AH.HND			;Handling type
	BYTE	AH.HID			;Host number
	WORD	AH.IMP			;IMP number
	BYTE	AH.LNK			;Link number
	BYTE	AH.SBL			;Sub-link & sub-type
	WORD	AH.ML			;Message length
AH.LEN	=	..OFST			;ARPANET leader length 


;Define PRNET header format
..OFST=0
	BYTE	PR.HL			;PRNET header length
	BYTE	PR.PL			;Packet length, words
	WORD	PR.SID			;Source id
	WORD	PR.DID			;Destination id
	WORD	PR.SEQ			;Sequence number
	WORD	PR.CTL			;Control word
	WORD	PR.MEA			;Measurement word
	BUFFER	PR.RID,10.		;Route ID #1 through #5
PR.LEN	=	..OFST			;PRNET header length


;Define XNET debugger header format
..OFST=0
	BYTE	XN.CMD			;XNET command opcode
	BYTE	XN.PID			;XNET destination PID
	WORD	XN.A1			;Command arg 1 (not byte swapped)
	WORD	XN.A2			;Command arg 2 (not byte swapped)
XN.LEN	=	..OFST			;Length of fixed part of packet


;Define LNI header format
..OFST=0
	WORD	LNI.DPNM1
	WORD	LNI.DPNM2
	BYTE	LNI.DPN1	
	BYTE	LNI.DPN2
	BYTE	LNI.DPN3
	BYTE	LNI.DPN4
	WORD	LNI.OPN1
	WORD	LNI.OPN2
	WORD	LNI.LEN
LNI.LEN	=	..OFST			;Length of LNI header
