/* Structure definitions for MOS datatypes - see the MOS stuff
 * in mostbl.sml (/src/mos/mos) for the field definitions.
 */


/* Basic MOS datatypes */

#define	opc	unsb
#define	pid	unsb
#define	dev	intw


/* Signals (user code, actually) */

#define	sig	struct	sigstr

sig	{	opc	s_opc;
		pid	s_pid;
		word	s_data;
		};

#define	mksig(x)	((sig *) (x))


/* I/O request block */

#define	iorb	struct	iorbstr

iorb	{	iorb	*i_link;
		dev	i_dev;
		opc	i_opc;
		pid	i_pid;
		byte	*i_addr;
		byte	i_xmem;
		byte	i_usr1;
		unsw	i_breq;
		bitw	i_stat;
		unsw	i_bxfr;
		word	i_usr2;		/* ptr to net struct (netp) for inter-
					face on which pkt rcved or xmitted */
		word	i_usr3;
		word	i_usr4;
		word	i_usr5;
		word	i_usr6;
		};

#define	mkiorb(x)	((iorb *) (x))

#define	I_DONE	0200
#define	I_ERR	0100000

#define	I_ECAT	0176
#define	IE_NOP	0
#define	IE_UER	2
#define	IE_DER	4

#define	I_ECOD	077400
#define	I_ESHFT	8

#define	ID_OFLN	(01 << I_ESHFT)
#define	ID_EOM	(02 << I_ESHFT)
#define	ID_DAT	(03 << I_ESHFT)
#define	ID_OVFL	(04 << I_ESHFT)
#define	ID_HRDE	(05 << I_ESHFT)
#define	ID_EOF	(06 << I_ESHFT)
#define	ID_OTER	(07 << I_ESHFT)
#define	ID_IPPE	(010 << I_ESHFT)
#define	ID_RNGE	(011 << I_ESHFT)
#define	ID_NXME	(012 << I_ESHFT)
#define	ID_ATTN	(013 << I_ESHFT)
#define	ID_DEAD	(014 << I_ESHFT)
#define	ID_FLSH	(015 << I_ESHFT)

#define	IU_NDEV	(01 << I_ESHFT)
#define	IU_UNDF	(02 << I_ESHFT)
#define	IU_ALER	(03 << I_ESHFT)
#define	IU_FNER	(04 << I_ESHFT)
#define	IU_UNPV	(05 << I_ESHFT)
#define	IU_WPER	(06 << I_ESHFT)
#define	IU_ODAD	(07 << I_ESHFT)
#define	IU_DAER	(010 << I_ESHFT)


/* Device control table */

#define	dct	struct	dctstr

dct	{	iorb	*d_qhd;
		iorb	*d_qtl;
		dct	*d_lnk;
		word	*d_iva;
		word	*d_ina;
		word	*d_csr;
		word	*d_buf;
		word	*d_strt;
		dev	d_sdvn;
		dev	d_dvn;
		bitw	d_flg;
		word	*d_addr;
		unsw	d_breq;
		word	d_dev1;
		word	d_dev2;
		word	d_dev3;
		unsb	d_crf;
		byte	d_null;
		unsw	d_rc;
		byte	*d_rfnt;
		byte	*d_rend;
		byte	*d_rhd;
		byte	*d_rtl;
		byte	d_rbuf[20];
		};

#define	mkdct(x)	((dct *) (x))

#define	D_HLD	01
#define	D_STP	02
#define	D_DWN	04
#define	D_RUN	040
#define	D_ACT	0100
#define	D_DV1	01000
#define	D_DV2	02000
#define	D_INI	040000
#define	D_OFL	0100000


/* Message queue entry */

#define	mqe	struct	mqestr

mqe	{	mqe	*m_link;
		sig	m_sig;
		};

#define	mkmqe(x)	((mqe *) (x))


/* Process control table */

#define	MPRSALEN	9
#define	MPNMLEN		6

#define	pct	struct	pctstr

pct	{	pct	*p_lnk;
		pid	p_pid;
		byte	p_null;
		bitw	p_flg;
		mqe	*p_mqh;
		mqe	*p_mqt;
		word	p_sp;
		word	p_regs[MPRSALEN];
		opc	p_dbgopc;
		pid	p_dbgpid;
		bitw	p_dbgflg;
		word	*p_ent;
		char	p_name[MPNMLEN];
		dev	p_dpi;
		dev	p_dpo;
		dev	p_prii;
		dev	p_prio;
		word	p_usr1;
		word	p_usr2;
		word	p_usr3;
		iorb	p_iorb;
		word	p_stkgd;
		word	p_stk[];
		};

#define	mkpct(x)	((pct *) (x))

#define	P_FZN	01
#define	P_BPT	02
#define	P_IO	010
#define	P_DET	020
#define	P_NPL	0100
#define	P_NDB	0200
#define	P_PMT	01000
#define	P_MMS	02000
#define	P_RDY	0100000

#define	P_STKG	0123456
