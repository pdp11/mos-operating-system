	.NLIST


ER.CID	=	1			;Connection ID out of range
ER.TCB	=	2			;Connection invalid (no TCB)
ER.NOX	=	3			;Packet on non-existant connection
ER.PRO	=	4			;Wrong protocol number
ER.HDL	=	5			;Header length too short
ER.SIZ	=	6			;Packet too long
ER.CHK	=	7			;Checksum failed
ER.RST	=	10			;Invalid RST received
ER.SYN	=	11			;Invalid SYN received
ER.ACK	=	12			;Invalid ACK received
ER.OPT	=	13			;Option not found
ER.OPF	=	14			;Option format error
ER.MEM	=	15			;Can't allocate memory error
ER.NOP	=	16			;Pkt on un-established connection 



TCB	=	R5			;TCB pointer in R5
HDR	=	R4			;TCP header pointer in R4


SG.EST	=	0			;Connection established
SG.ERR	=	1			;Connection error
SG.DD	=	2			;Destination not responding
SG.CC	=	3			;Close complete
SG.DAT	=	4			;Data received on connection
SG.RFS	=	5			;Connection refused
SG.SC	=	6			;Send complete
SG.RC	=	7			;Remote close
SG.URG	=	SG.DAT			;Urgent data received


TF.RCV	=	1			;Trace received packet
TF.SND	=	2			;...sent packet
TF.ERR	=	4			;packet in error
TF.ADR	=	10			;Full INET address
TF.SWB	=	20			;Word fields already swapped
TF.OPT	=	40			;Display TCP options
TF.TXT	=	100			;Data length field already adjusted


	.MACRO	$LOG	CNTR
	.ENDM


	.LIST

