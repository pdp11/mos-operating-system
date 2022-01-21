; Define tcp configuration

;    $DEBUG OR $MONTR = 1 - Various counters are included ($tcpms table)
$DEBUG	=	1			;Debugging routines conditional
$MONTR	=	1			;Performance monitoring conditional

;    $SWAPF = 1 - generates code for a word-at-a-time interface
;	    = 0 - generates code for a byte-at-a-time interface
;
$SWAPF	=	0			;SRI interface is byte-at-a-time

;
;    $NTCON - number of tcp connections allowed
;
$NTCON	=	2

;
; Type of end-of-letter processing desired
;    $EOL = 0 - no processing
;         = 1 - each send is 1 letter
;
$EOL	=	0			;No eol processing

;
; Buffer size equates
;

RSMLEN	=	500.			;Reassembly buffer length, octets
MAXRWS	=	RSMLEN			;Max receive window size
RTXLEN	=	80.			;Retransmission buffer length

;
; The following equates control the number of retransmissions and the
;    interval between retransmissions

;    RTXBKO = 0 - no retransmission interval back-off
;	    = 1 - increase the rtx interval linearally with number of rtxs
;	    = 2 - increase the rtx interval exponentially with number of rtxs
;
RTXBKO	=	0			;no rtx interval back-off

;    RTXTMO - time delay of first retransmission after original transmission
;
RTXTMO	=	3.			;initial rtx timeout = 3 secs

;    RTXMAX - maximum time delay between retransmissions when using back-off
;
RTXMAX	=	60.			;Maximum rtx interval when using back-off
					; = 1 minute

;    MAXTY - maximum number of times a packet is retransmitted before
;	declaring the remote 'tcp not responding' and suspending the
;	connection.  the packet will continue to be transmitted until the
;	connection closes
;
MAXTRY	=	20.			;RTX at most 20. times

;    MAXRFS - maximum number of trys at establishing a connection when
;	remote site refuses
;
MAXRFS	=	3.			;Try 3 times


