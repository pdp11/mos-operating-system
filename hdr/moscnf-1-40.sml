	.TITLE	DEFINE SOME SYSTEM CONFIGURATION PERAMETERS



	.MACRO	$CNFIG			;DEFINE THE SYSTEM CONFIGURATION


; PROCESSOR TYPE; SET ONE TO 1, THE REST TO 0

P1140	=	1			;PROCESSOR IS AN 11/34-40-45
P1120	=	0			;PROCESSOR IS NOT AN 11/10-20
P1103	=	0			;PROCESSOR IS NOT AN 11/03 (LSI-11)
P11E	=	1			;HAS EIS CHIP/BOARD/INSTS

	.IF NE	P1140+P1120+P1103-1
	.ERROR	ERROR IN PROCESSOR SPECIFICATION
	.ENDC


; LOCATION OF SYSTEM TERMINAL
;
	DLLOC = 177560			; USUAL

	.IF NDF	DLLOC
	.ERROR	NO SYSTEM DL LOCATION
	.ENDC


; VARIOUS RANDOM SYSTEM PARAMETERS

NBLKS	=	40.			;ALLOCATE 40 KERNEL STORAGE BLOCKS
BLKLEN	=	5*2			; EACH 5 WORDS LONG
STKLEN	=	100.*2			;DEFAULT PROCESS STACK IS 70. WORDS 
STKINT	=	30.*2			;INTERRUPT STACK MUST BE THIS LONG
NUEMTS	=	20.			;NUMBER OF USER EMT EXITS DESIRED



; THE KF.PWR EQUATE CONTROLS ASSEMBLY OF THE POWER-FAIL ROUTINE.
;	KF.PWR = 0 - PUT TRAP CATCHER IN POWER-FAIL VECTOR
;	       = 1 - HALT ON POWER-FAIL, RESTART ON POWER RESTORATION
;	       = 2 - HALT ON POWER-FAIL, CONTINUE ON POWER RESTORATION
;	       = 3 - HALT ON POWER-FAIL, ENTER INTBOT ON POWER UP

KF.PWR	=	0			;HALT SINCE PROGRAM AREA IN RAM


; THE KF.DDT EQUATE CONTROLS ASSEMBLY OF CODE TO SUPPORT DDT DEBUGGING.
;	SPECIFICALLY, ERROR HALTS ARE CONVERTED TO BREAKPOINT INSTRUCTIONS
;	AND THE KERNEL DOESN'T ZAP THE BREAKPOINT, IOT, ETC TRAP VECTORS
;	KF.DDT	= 0 - NO DDT, HALT ON ERROR
;		= 1 - ENTER DDT ON ERROR

KF.DDT	=	1			;DEBUGGING W/ DDT


; THE KF.DBG EQUATE CONTROL ASSEMBLE OF THE ROUTINES NECESSARY FOR
;    PER-PROCESS DEBUGGING, SUCH AS WITH THE XNET DEBUG PROCESS.
;	KF.DBG = 0 - NO PER-PROCESS OR REMOTE DEBUGGING
;	       = 1 - SUPPORT XNET DEBUGGING

KF.DBG	=	0


; THE KF.SCD EQUATE CONTROL ASSEMBLE OF THE ROUTINES FOR
;    EXAMING THE OPERATION OF THE MOS SCHEDULER WHICH PRINT
;    TRACES OF ALL SCHED EVENTS.
;	KF.SCD = 0 - NO TRACE PRINTING
;	       = 1 - SUPPORT TRACE PRINTING

KF.SCD	=	0


; THE KF.TRC EQUATE CONTOL ASSEMBLE OF LOCATION MODIFICATION TRACE
; CHECKING. THIS DOESN'T WORK AT THE MOMENT.
;	KF.TRC = 0 - NO TRACE SUPPORT
;	       = 1 - TRACE SUPPORT

KF.TRC	=	0


; THE KF.CSM EQUATE CONTROLS ASSEMBLE OF CODE SPACE CHECHSUMMING CODE
; THIS DOESN'T WORK AT THE MOMENT.
;	KF.CSM = 0 - NO CHECKSUMMING
;	       = 1 - CHECKSUMMING ALLOWED IN IDLE PROCESS

KF.CSM	=	0


	.ENDM				