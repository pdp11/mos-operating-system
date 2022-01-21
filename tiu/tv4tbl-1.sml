

;
; Define the TCP's Transmission Control Block
;
..OFST=0
	DWORD	LINK			;Link to next/previous TCBs
	WORD	STATE			;Connection state flags
ST.SR	=	1			;SYN received flag
ST.SS	=	2			;SYN sent flag
ST.SA	=	4			;SYN acked flag
ST.FW	=	10			;FIN waiting to be processed
ST.FR	=	20			;FIN received (and processed) flag
ST.FS	=	40			;FIN sent flag
ST.FA	=	100			;FIN acked flag
ST.RCV	=	1000			;Connection usable for receiving data
ST.SND	=	2000			;Connection usable for sending data
ST.SPN	=	4000			;Connection suspended flag
ST.LSN	=	10000			;Listening connection
ST.USP	=	20000			;Connection in unspecified state
ST.WLD	=	40000			;Foreign addr wildcard match flag
ST.DEL	=	100000			;TCB marked for deletion

	WORD	WORK			;TCP work-to-do flags
FL.SYN	=	1			;Send SYN control function
FL.TXT	=	2			;Send some user data as text
FL.FIN	=	4			;Send FIN control function
FL.ACK	=	10			;Force ack for packet received
FL.NUL	=	100			;Null (ack-only) packet
FL.DUP	=	200			;Packet is a duplicate flag
FL.WDW	=	400			;Need to update send window
FL.DEL	=	2000			;Delete connection/tcb

	WORD	USECNT			;TCB use count
;
; Local address info
;
	DWORD	LADDR			;Local NET/TCP address
	WORD	LPORT			;Local port number
;
; Foreign address info
;
	DWORD	FADDR			;Foreign NET/TCP address
	WORD	FPORT			;Foreign port number
;
; Receive-side state info
;
	DWORD	INISEQ			;Initial receive sequence number
	DWORD	RCVSEQ			;Seq number of next octet expected
	WORD	RCVWS			;Receive window size
	WORD	RCVBS			;Receive buffer size
	WORD	RCVUP			;Receive URGENT pointer
	DWORD	FINSEQ			;Received FIN sequence number
;
; Send-side state info
;
	DWORD	SNDSEQ			;Seq number of next octet to send
	DWORD	LWESEQ			;Left send window edge, sequence
					;  number of first un-acked octet
	WORD	SNDWS			;Send window size
	WORD	SNDBS			;Send buffer size
	WORD	SNDUP			;Send URGENT pointer
	WORD	SNDCNT			;Number of octets waiting to be ACKed
					;Difference between SNDSEQ & LWESEQ
;
; Retransmission parameters
;
	BYTE	RTXDLY			;Retransmission interval
	BYTE	WAKEUP			;Count of retransmission wakeups
	BYTE	MRETRY			;Max number of retries before 
					;  declaring 'TCP NOT RESPONDING'
	BYTE	RETRY			;Number of rtx w/o receiving an ack
;
; Network interface information
;
	WORD	RCVIOR			;Address of input iorb
	WORD	SNDIOR			;Address of output iorb
;
; Operating system information
;
	BYTE	USRPID			;User process' PID
	BYTE
;
; User interface information
;
	WORD	RSMFNT			;Pointer to front of reassembly buf
	WORD	RSMEND			;Pointer to end of reassembly buffer
	WORD	RSMHD			;Pointer to head of circular buffer
	WORD	RSMTL			;Pointer to tail of circular queue

	WORD	RTXFLG			;Retransmission conrol flags
RX.SYN	=	1			;Need to RTX a SYN
RX.TXT	=	2			;Need to RTX some text
RX.FIN	=	4			;Need to RTX a FIN
	WORD	RTXCNT			;Number of bytes in RTX buffer
	WORD	RTXFNT			;Pointer to front of retransmit buf
	WORD	RTXEND			;Pointer to end of retransmission buf
	WORD	RTXHD			;Pointer to head of circular queue
	WORD	RTXTL			;Pointer to tail of circular queue

	WORD	SNDUVA			;User address of send buffer
	WORD	SNDBR			; and the buffer byte count

	BUFFER	RSMBUF,RSMLEN*2		;Reassembly flag & data buffer
	BUFFER	RTXBUF,RTXLEN*2		;Retransmission flag & data buffer
RF.EOL	=	100			;Byte is end of a letter
RF.TXT	=	200			;Byte contains text
;
; Per-connection measurement area
;

TCBLEN	=	..OFST			;Length of TCB



