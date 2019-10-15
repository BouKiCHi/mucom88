;==========================================================================
; MUSICLALF Ver.1.0 �v���O�����\�[�X
; �t�@�C���� : muc88.asm
; �@�\ : �R���p�C��(���C��)
; PROGRAMED BY YUZO KOSHIRO
;==========================================================================
; �w�b�_�ҏW/�\�[�X�C�� : @mucom88
; ���{�\�[�X��MUSICLALF Ver.1.1��muc88.asm���獷���C���ɂč쐬�������ł��B
;==========================================================================
	
	
	ORG	09600H
	
COMWK:	EQU	0F320H	;���߲� ܰ�į��
SUBWK:	EQU	0C400H	;GOSUBֳ ���� (VRAM0�¶�)
LOOPSP:	EQU	0F260H  ;ٰ�߽���
CURSOR:	EQU	0EF86H	;����ܰ�
	
MDATA:	EQU	COMWK	;���߲ٻ�� �ް��޵��� ��ݻ޲� ���ڽ
DATTBL:	EQU	MDATA+4	;��ݻ޲ ���߲���� � MUSIC DATA TABLE TOP
OCTAVE:	EQU	DATTBL+2
SIFTDAT:EQU	OCTAVE+1
CLOCK:	EQU	SIFTDAT+1
SECCOM:	EQU	CLOCK+1
KOTAE:	EQU	SECCOM+1
LINE:	EQU	KOTAE+2
ERRLINE:EQU	LINE+2
COMNOW:	EQU	ERRLINE+2
COUNT:	EQU	COMNOW+1
MOJIBUF:EQU	COUNT+1
SEC:	EQU	MOJIBUF+4
MIN:	EQU	SEC+1
HOUR:	EQU	MIN+1
ALLSEC:	EQU	HOUR+1
T_FLAG:	EQU	ALLSEC+2
SE_SET:	EQU	T_FLAG+1
VOLINT:	EQU	SE_SET+2
FLGADR:	EQU	VOLINT+1
ESCAPE:	EQU	FLGADR+1
MINUSF:	EQU	ESCAPE+1
BEFRST:	EQU	MINUSF+1;��ݶ� �� 'r' �ޱٺĦ�ҽ �׸� �� ����
BEFCO:	EQU	BEFRST+1;��ݶ� � ����
BEFTONE:EQU	BEFCO+2	;��ݶ� � İ� �ް�
TIEFG:	EQU	BEFTONE+9;��ݶ� �� ���ޱٺĦ �ҽ
COMNO:	EQU	TIEFG+1	;��ݶ�� ����ޡ İ��ķ� 0
ASEMFG:	EQU	COMNO+1
VDDAT:	EQU	ASEMFG+1
OTONUM:	EQU	VDDAT+1; ¶��ò� �ݼ�� � ���
VOLUME:	EQU	OTONUM+1; NOW VOLUME
LINKPT:	EQU	VOLUME+1; LINK POINTER
ENDADR:	EQU	LINKPT+2
OCTINT:	EQU	ENDADR+2
	
MWRITE:	EQU	9000H
MWRIT2:	EQU	MWRITE+3
ERRT:	EQU	MWRIT2+3
ERRSN:EQU	ERRT+3
ERRIF:EQU	ERRSN+3
ERRNF:EQU	ERRIF+3
ERRFN:EQU	ERRNF+3
ERRVF:EQU	ERRFN+3
ERROO:EQU	ERRVF+3
ERRND:EQU	ERROO+3
ERRRJ:EQU	ERRND+3
STTONE:	EQU	ERRRJ+3
STLIZM:	EQU	STTONE+3
REDATA:	EQU	STLIZM+3
MULT:	EQU	REDATA+3
DIV:	EQU	MULT+3
HEXDEC:	EQU	DIV+3
HEXPRT:	EQU	HEXDEC+3
ROM:	EQU	HEXPRT+3
RAM:	EQU	ROM+3
FMCOMC:	EQU	RAM+3
T_RST:	EQU	FMCOMC+3
ERRNE:EQU	T_RST+3
ERRDC:EQU	ERRNE+3
ERRML:EQU	ERRDC+3
MCMP:	EQU	ERRML+3
ERRVO:EQU	MCMP+3
ERRMD:EQU	ERRVO+3
ERRNMC:	EQU	ERRMD+3*5
ERREMC:	EQU	ERRNMC+3
	
MSTART:	EQU	0B000H
MSTOP:	EQU	MSTART+3
START:	EQU	MSTART+3*6
WORKINIT:EQU	START+3
AKYOFF:	EQU	START+3*2
SSGOFF:	EQU	START+3*3
MONO:	EQU	START+3*4
DRIVE:	EQU	START+3*5
TO_NML:	EQU	START+3*6
WKGET:	EQU	START+3*8
STVOL:	EQU	START+3*9
ENBL:	EQU	START+3*10
INFADR:	EQU	START+3*12
	
MU_NUM:	EQU	0C200H	;���߲���� � MUSIC���ް
OTODAT:	EQU	MU_NUM+1;FM�ݼ�� �� ��ɳ��� ���ڽį�� �� ʲ�ò�
SSGDAT:	EQU	MU_NUM+3;SSG...
MU_TOP:	EQU	MU_NUM+5; Э��ޯ� �ް� (���ڽð��� ̸�) ���� ���ڽ
MAXCHN:	EQU	11	; ¶��� �ݹ�ݽ� � MAX
FMLIB:EQU	6000H	; �ݼ��ײ���� ���ڽ
SSGLIB:	EQU	5E00H
	
CLS1:	EQU	05F0EH
KBD:	EQU	09A00H
DSPMSG:	EQU	0AB00H
FOUND:	EQU	DSPMSG+3
PRNFAC:	EQU	FOUND+3
FVTEXT:	EQU	PRNFAC+3
COLOR:	EQU	FVTEXT+3
REPLACE:EQU	COLOR+6
CULPTM:	EQU	REPLACE+3
	
PRNWK:	EQU	0DE00H
PRNWKI:	EQU	PRNWK+3
CONVERT:EQU	PRNWK+3*2
CONVERT2:EQU	PRNWK+3*3
GETPARA:EQU	PRNWK+3*4
OPEX:	EQU	PRNWK+3*5
OTOWK:	EQU	8B00H+60H+60H	;25BYTE�ް��� ʲ�ĺ�
PARAM:	EQU	OTOWK+32	;38BYTE�ް���ʲ�ĺ�
TEXT:	EQU	0F3C8H
	
; -- CLEAR FROM COMPI1	-->
	
T_CLK:	EQU	08C10H
BEFMD:	EQU	T_CLK+4*11+1	;+1���
PTMFG:	EQU	BEFMD+2
PTMDLY:	EQU	PTMFG+1
TONEADR:EQU	PTMDLY+2
SPACE:	EQU	TONEADR+2	;2*6BYTE �� �� ��
DEFVOICE:EQU	SPACE+2*6
DEFVSSG:EQU	DEFVOICE+32
JCLOCK:	EQU	DEFVSSG+32
JPLINE:	EQU	JCLOCK+2
	
;-<
	JP	CINT
	JP	GETADR
CINT:
	LD	HL,COMPIL
	LD	A,0C3H
CI2:
	LD	(0EEA7H),A
	LD	(0EEA8H),HL
	RET
COMPIL:
	PUSH	HL
	CALL	INIT0
	POP	HL
	LD	A,1
	LD	(BFDAT),A
	
	LD	A,(HL)
	INC	HL
	PUSH	HL
COM1:
	LD	HL,ASEMFG
	CP	0CAH	;MON
	JR	Z,CHECK
	CP	'F'
	JP	Z,WFOUND
	CP	'R'
	JP	Z,REPST
	CP	0CEH
	JR	Z,FDO
	PUSH	AF
	PUSH	HL
	CALL	INFADR
	LD	(IX+2),0
	CALL	TO_NML
	CALL	MONO
	CALL	MSTOP
	POP	HL
	POP	AF
	CP	'E'
	JR	Z,CHGPMD
	CP	'I'
	JP	Z,INITFG
	CP	'K'
	JP	Z,KBDSUB
	CP	'D'
	JP	Z,DEBFCH
	CP	'V'
	JP	Z,VICMKE
	CP	'L'
	JP	Z,LINC
	CP	'S'
	JP	Z,M_ST
	CP	'P'
	JP	Z,COMPI1
	CP	'Z'
	JP	Z,CMP1
	INC	(HL)
	CP	'A'	;���߲ٵ�ذ
	JP	Z,COMPI1
	POP	HL
	LD	E,2
	JP	03B3H
FDO:
	CALL	INFADR
	LD	(IX+8),16
	POP	HL
	RET
CHGPMD:
	LD	A,(PSGMD)
	CPL
	LD	(PSGMD),A
	CALL	PRMODE
	POP	HL
	RET
CHECK:
	LD	HL,(CURSOR)
	PUSH	HL
	CALL	CLS1
	LD	HL,0A8H*256+40
	LD	(TEXT+120*6+80),HL
	LD	(TEXT+120*7+80),HL
	LD	(TEXT+120*8+80),HL
	LD	HL,88H*256+40
	LD	(TEXT+120*9+80),HL
	LD	HL,0C8H*256+40
	LD	(TEXT+120*13+80),HL
	CALL	PRNWKI
CC2:
	CALL	PRNWK
	IN	A,(9)
	BIT	0,A
	JR	NZ,CC2
	CALL	CLS1
	POP	HL
	LD	(CURSOR),HL
	POP	HL
	RET
WFOUND:
	CALL	FOUND
	POP	HL
	RET
INITFG:
	LD	A,(UDFLG)
	CPL
	LD	(UDFLG),A
	LD	HL,IFGM
	OR	A
	JR	Z,IFG2
	LD	HL,IFGM2
IFG2:
	CALL	DSPMSG
	POP	HL
	RET
REPST:
	CALL	REPLACE
	POP	HL
	RET
	
; --	SYSTEM KBD	--
	
KBDSUB:
	DI
	CALL	RAM
	LD	HL,4800H
	LD	DE,09A00H
	LD	BC,1600H
	PUSH	DE
	PUSH	HL
	PUSH	BC
	CALL	EXCG
	CALL	ROM
	EI
	CALL	KBD
	DI
	CALL	RAM
	POP	BC
	POP	DE
	POP	HL
	CALL	EXCG
	CALL	ROM
	EI
	POP	HL
	RET
EXCG:
	LD	A,(HL)
	EX	AF,AF'
	LD	A,(DE)
	EX	AF,AF'
	LD	(DE),A
	EX	AF,AF'
	LD	(HL),A
	INC	HL
	INC	DE
	DEC	BC
	LD	A,C
	OR	B
	JR	NZ,EXCG
	RET
	
	
; *	Ҳ�	*
	
DEBFCH:
	LD	A,(DEBFLG)
	CPL
	LD	(DEBFLG),A
	POP	HL
	RET
CMP1:
	DI
	LD	HL,VPCO
	INC	(HL)
	JR	CMP2
COMPI1:
	DI
	XOR	A
	LD	(VPCO),A
CMP2:
	LD	A,(LINCFG)
	OR	A
	JR	NZ,COMPI4
	
	LD	BC,239
	LD	HL,T_CLK
	CALL	MEMCLR
	
COMPI4:
	POP	HL		; TEXT POINTER
	CALL	REDATA
	JR	C,COMPI2
	PUSH	HL
	LD	A,E
	OR	A
	JR	Z,COMP42
	LD	A,(LINCFG)
	OR	A
	LD	A,E
	JR	NZ,COMPI3
	POP	HL
	JP	ERRMD
COMP42:
	POP	HL
COMPI2:
	PUSH	HL
	LD	A,1
COMPI3:
	CALL	WORKGET		; EXIT: (MU_NUM)<= MUSIC NUMBER
				;	DATTBL INIT
	XOR	A
	LD	(REPCOUNT),A
	CALL	AKYOFF
	CALL	SSGOFF
	CALL	TEXTINIT
	
	CALL	RAM
	
	LD	HL,(MDATA)
	CALL	TBLSET
	
	LD	HL,LOOPSP-10	; LOOP ֳ ����
	LD	(POINTC),HL
	LD	HL,1		; TEXT START ADR
	
	
; *   ���߲� ����   *
	
CSTART:
	LD	A,0FFH
	LD	(MACFG),A
	CALL	COMPST
	LD	HL,(MDATA)
	CALL	TBLSET
	LD	HL,1
CSTART2:
	XOR	A
	LD	(MACFG),A
	CALL	COMPST
	JP	CMPEND	; �ݸ �߲��=0 -> BASIC END
COMPST:
	LD	E,(HL)
	INC	HL
	LD	D,(HL)		; DE=LINK POINTER
	INC	HL
	LD	(LINKPT),DE	; STORE LINK POINTER
	LD	A,E
	OR	D
	RET	Z
	
	LD	(LINE),HL
	INC	HL		;
	INC	HL		; SKIP LINE NUMBER
	LD	A,(HL)
	CP	03AH		; BASIC COM.
	JP	NZ,RECOM
	INC	HL
	LD	A,(HL)
	CP	08FH		; BASIC COM. (REM)
	JP	NZ,RECOM
	INC	HL
	LD	A,(HL)
	CP	0E9H		; BASIC COM. (')
	JP	NZ,RECOM
	INC	HL
	
	LD	A,(MACFG)
	INC	A
	JR	Z,MACPRC
	LD	A,(HL)		; A=Ch.NUMBER (A-F)
	INC	HL
	
	LD	C,A
	PUSH	HL
	LD	HL,0C800H
	LD	DE,(ADRSTC)
	AND	A
	SBC	HL,DE
	EX	DE,HL
	POP	HL
	LD	A,E
	OR	D
	JR	NZ,CST3		;ϸ������ ͯ�������߽
	
	LD	A,C
	OR	A
	JR	Z,RECOM
	PUSH	AF
	LD	A,(MAXCH)
	ADD	A,'A'
	LD	C,A
	POP	AF
	CP	C
	JP	NC,RECOM
	CP	'A'
	JP	C,RECOM
	
	LD	C,A
	LD	A,(HL)
	OR	A
	JP	Z,RECOM
	LD	A,C
	
	AND	00001111B
	DEC	A		; A=Ch.NUMBER (0-5)
	LD	C,A
	
	LD	A,(COMNOW)
	CP	C
	JR	NZ,RECOM	; ��ݻ޲ ���߲���� � �����
				;  ��Ź� �� ·�ɷޮ�
CST3:
	CALL	FMCOMP		; TO FM COMPILE
	JR	COMPST
RECOM:
	LD	HL,(LINKPT)	;�ݸ�߲�� �����
	JP	COMPST		;·� � �ޮ��
	
; *	ϸ� ���	*
	
MACPRC:
	LD	C,'*'
	LD	DE,0C000H	;VRAMSTAC
	LD	(TST2+1),DE
	CALL	MPC1
	JR	RECOM
	
; --	÷�Ķ� Creg����� ���޽	--
	
MPC1:
	LD	A,(HL)
	INC	HL
	CP	'#'
	JR	NZ,MPNON
MPC2:
	LD	A,(HL)
	INC	HL
	CP	20H
	JR	Z,MPC2
	OR	A
	JR	Z,MPNON
	CP	';'
	JR	Z,MPNON
	CP	'{'
	JR	Z,MPNON
	CP	C
	JR	NZ,MPNON
	
	CALL	REDATA	;MAC NO.
	JP	C,ERRNE
	OR	A
	JP	NZ,ERRIF
	LD	A,(HL)
	INC	HL
	CP	'{'
	JP	NZ,ERRSN
	
	LD	A,(MACFG)
	INC	A
	JR	Z,MPC3
	AND	A
	RET
MPC3:
	CALL	TOSTAC
	AND	A
	RET
MPNON:
	SCF	;Ų�
	RET
	
; *	MACRO STAC	*
	
TOSTAC:
	OUT	(5CH),A
	PUSH	HL
	LD	L,E
	LD	H,0
	LD	D,H
	ADD	HL,DE
	ADD	HL,HL	;*4
TST2:
	LD	DE,0C000H
	ADD	HL,DE
	POP	DE
	LD	(HL),E
	INC	HL
	LD	(HL),D
	INC	HL
	LD	DE,(LINKPT)
	LD	(HL),E
	INC	HL
	LD	(HL),D
	OUT	(5FH),A
	RET
	
	
; *   LINC OBJECT FLAG SET  *
	
LINC:
	LD	A,(LINCFG)
	CPL
	LD	(LINCFG),A
	CALL	PRMODE
	LD	HL,(MDATA+2)
	LD	(MDATA),HL
	
	LD	HL,DEFVOICE
	LD	BC,63
	CALL	MEMCLR
	POP	HL
	RET
	
PRMODE:
	LD	HL,MESNML
	LD	A,(PSGMD)
	OR	A
	JR	Z,PRM0
	LD	HL,MESNML+16
PRM0:
	LD	A,(LINCFG)
	OR	A
	JR	Z,PRM1
	LD	HL,MESNML+8
PRM1:
	LD	DE,TEXT+70
	LD	BC,8
	LDIR
	RET
	
; *	BASIC END	*
	
CMPEND:
	CALL	TCLKADR
	LD	A,(HL)
	INC	HL
	LD	E,(HL)
	OR	E
	JR	NZ,CMPE2
	LD	A,(COMNOW)
	CALL	CHTBL
	INC	HL
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0
CMPE2:
	LD	HL,(MDATA)
	XOR	A
	LD	(HL),A		; SET END MARK = 0
	INC	HL
	LD	(MDATA),HL
	
	LD	A,(COMNOW)
	INC	A
 	LD	(COMNOW),A		; Ch.=Ch.+ 1
	
	CALL	TBLSET
	
 	LD	A,(COMNOW)
	LD	L,A
	LD	A,(MAXCH)
	CP	L
 	JP	Z,CMPEN1
	
 	LD	HL,1		; TEXT START ADR
	CALL	INIT
	
	LD	A,(REPCOUNT)
	OR	A
	JP	NZ,ERRFN	; [] � �бܾ �� ��Ų
	
	XOR	A
	LD	(REPCOUNT),A
	LD	(TV_OFS),A
	LD	(SIFTDAT),A
	LD	(BEFRST),A
	LD	(TIEFG),A
	JP	CSTART2
	
TBLSET:
	CALL	TBOFS
	EX	DE,HL
	LD	A,(COMNOW)
	CALL	CHTBL
	LD	(HL),E
	INC	HL
	LD	(HL),D
	RET
TBOFS:
	LD	DE,MU_TOP
	AND	A
	SBC	HL,DE
	RET
	
; --	Areg CH � ð��ٱ��ڽ�����	--
	
	;OUT:HL
CHTBL:
	LD	HL,(DATTBL)
	ADD	A,A
	ADD	A,A
	ADD	A,L
	LD	L,A
	ADC	A,H
	SUB	L
	LD	H,A
	RET
	
; *	���� � ch � ��� ���خ�	*
	
CMPEN1:
	LD	A,(REPCOUNT)
	OR	A
	JP	NZ,ERRFN
	
	LD	HL,(MDATA)
	
	LD	(ENDADR),HL
	PUSH	HL
	LD	DE,MU_NUM
	AND	A
	SBC	HL,DE
	LD	(OTODAT),HL
	POP	HL		;HL=��DATA��END+1
	
	LD	HL,MU_NUM
	CALL	HEXPRT		; PRINT START ADR
	LD	HL,MOJIBUF
	LD	DE,TEXT+31
	LD	BC,4
	LDIR
	
; --   25 BYTE VOICE DATA � ����   --
	
	LD	HL,(ENDADR)
	PUSH	HL
	INC	HL
	LD	(ENDADR),HL
	LD	(VICADR),HL
CMPEN3:
	LD	DE,DEFVOICE
	LD	B,32
	XOR	A
	
VOICECONV1:
	
	PUSH	AF
	PUSH	BC
	
	LD	A,(DE)	; GET VOICE NUMBER
	OR	A
	JR	Z,VCON2
	LD	C,A
	LD	A,(VPCO)
	ADD	A,C
	INC	DE
	DEC	A
	LD	(VCON0+1),A
	PUSH	DE
	PUSH	HL
	CALL	FVTEXT
	POP	HL
	POP	DE
	JR	C,VCON0
	LD	HL,FMLIB+1
	JR	VCON01
VCON0:
	LD	A,0
	CALL	GETADR
	INC	HL	; HL= VOICE INDEX
VCON01:
	PUSH	DE
	LD	BC,12
	LD	DE,(ENDADR)
	LDIR
	LD	B,4
VCON1:
	LD	A,(HL)
	OR	10000000B	; SET AMON FLAG
	LD	(DE),A
	INC	HL
	INC	DE
	DJNZ	VCON1
	LD	BC,9
	LDIR
	LD	(ENDADR),DE
	
	POP	DE
	POP	BC
	POP	AF
	INC	A
	DJNZ	VOICECONV1
	JR	VCON3
VCON2:
	POP	BC
	POP	AF
VCON3:
	LD	(OTONUM),A	; ¶���� �ݼ�� � ���
	POP	HL
	LD	(HL),A
	
	LD	HL,(ENDADR)
	PUSH	HL
	LD	DE,MU_NUM
	AND	A
	SBC	HL,DE
	LD	(SSGDAT),HL
	POP	HL
SCON4:
	;LD	HL,(ENDADR)
	PUSH	HL
	CALL	HEXPRT		;PR END ADR
	LD	HL,MOJIBUF
	LD	DE,TEXT+36
	LD	BC,4
	LDIR
	LD	DE,MU_NUM
	POP	HL
	SBC	HL,DE
	INC	HL
	CALL	HEXPRT		;PR LENGTH
	LD	HL,MOJIBUF
	LD	DE,TEXT+41
	LD	BC,4
	LDIR
	
	LD	A,(ASEMFG)
	DEC	A
	JP	Z,CMPEN2
	
	CALL	ROM
	
	LD	A,(DEBFLG)
	OR	A
	JP	Z,PGMEND
	
	LD	HL,VNMESS
	CALL	DSPMSG
	LD	A,5
	CALL	COLOR
	LD	A,(OTONUM)
	LD	E,A
	LD	D,0
	CALL	PRNFAC
	LD	A,7
	CALL	COLOR
	
	LD	A,4
	CALL	COLOR
	LD	HL,TCMESS
	CALL	DSPMSG
	LD	A,7
	CALL	COLOR
	LD	HL,T_CLK
	CALL	VCONX
	
; --	ٰ�� ���� ����	--
	
	LD	HL,T_CLK
	LD	A,(MAXCH)
	LD	B,A
VCON4:
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	INC	HL
	PUSH	HL
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	OR	H
	JR	NZ,VCON5
	LD	DE,0
	JR	VCON6
VCON5:
	DEC	HL
	EX	DE,HL
	AND	A
	SBC	HL,DE
	EX	DE,HL
VCON6:
	POP	HL
	LD	(HL),E
	INC	HL
	LD	(HL),D
	INC	HL
	DJNZ	VCON4
	
	LD	A,6
	CALL	COLOR
	LD	HL,LCMESS
	CALL	DSPMSG
	LD	A,7
	CALL	COLOR
	LD	HL,T_CLK+2
	CALL	VCONX
	LD	A,(VPCO)
	OR	A
	JR	Z,PGMEND
	PUSH	AF
	LD	HL,ADMES
	CALL	DSPMSG
	POP	AF
	LD	E,A
	LD	D,0
	CALL	PRNFAC
PGMEND:
	DI
	CALL	INIT
	CALL	WORKINIT
	
	LD	HL,(JCLOCK)
	LD	A,H
	OR	L
	JR	Z,PGME2
	PUSH	HL
	LD	HL,JPLMES
	LD	DE,TEXT+23
	LD	BC,25
	LDIR
	LD	HL,(JPLINE)
	CALL	HEXDEC
	LD	DE,TEXT+48
	LD	BC,5
	LDIR
	
	CALL	START
	CALL	MSTOP
	POP	HL
	DI
PGME1:
	PUSH	HL
	CALL	DRIVE
	POP	HL
	DEC	HL
	LD	A,H
	OR	L
	JR	NZ,PGME1
	EI
	CALL	ENBL
	CALL	REDOF
	POP	HL
	RET
PGME2:
	CALL	REDOF
	CALL	START
	CALL	T_RST	; RESET TIME
	POP	HL
	RET
	
; --	İ��/ٰ�߶��� ˮ���	--
	
	; IN:HL
	
VCONX:
	LD	A,(MAXCH)
	LD	B,A
	LD	C,'A'
VCONX2:
	PUSH	BC
	LD	A,C
	CALL	03E0DH
	LD	A,':'
	CALL	03E0DH
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	INC	HL
	INC	HL
	INC	HL
	PUSH	HL
	CALL	PRNFAC
	LD	A,' '
	CALL	03E0DH
	POP	HL
	POP	BC
	INC	C
	DJNZ	VCONX2
	RET
	
; --	Areg� �ݼ�����ڽ�����	--
	
	;EXIT:HL
	
GETADR:
	PUSH	DE
	
	RRCA
	RRCA
	RRCA
	LD	E,A
	AND	00011111B
	LD	D,A
	LD 	A,E
	AND	11100000B
	LD	E,A   	; BC=A*32
	LD	HL,FMLIB
	ADD	HL,DE
	
	POP	DE
	RET
	
; --	COMPILE ONLY	--
	
CMPEN2:
	CALL	ROM
	POP	HL
	
	LD	A,1
	LD	(ESCAPE),A
	EI
	RET
	
; *	FM COMPILED	*
	
FMCOMP:
	LD	A,(HL)
	CP	020H	; ONE SPACE?
	JP	Z,FCOMP0
	INC	HL
	JP	FMCOMP
FCOMP0:
	INC	HL	; SKIP SPACE
FCOMP1:
	XOR	A
	LD	(BEFRST),A
	LD	(TIEFG),A
FCOMP12:
	LD	A,(HL)
	INC	HL
	OR	A	; DATA END?
	RET	Z	; ·� � �ޮ��
	CP	020H	; CHECK SPACE
	JR	Z,FCOMP12
	
	DEC	HL
	CALL	FMCOMC  ; COM CHECK
	LD	A,C
	LD	(COMNO),A
	OR	A     	; COM?
	JP	NZ,COMPRC	; ����� �� COMPRC
	
	LD	A,(HL)
	CALL	STTONE	; TONE SET
	JP	C,ERRSN
	
	LD	C,A
	LD	A,(BEFTONE)
	CP	C
	LD	A,C
	JR	Z,FC11
	LD	DE,(MDATA)
	LD	(TONEADR),DE
	JR	FCOMP16
FC11:
	LD	A,(TIEFG)
	OR	A
	LD	A,C
	JR	Z,FCOMP16
	INC	HL
FCOMP13:
	LD	DE,(MDATA)
	DEC	DE
	DEC	DE
	DEC	DE
	LD	(MDATA),DE
	
	LD	(FCP18+1),A	; STORE TONE
	CALL	STLIZM
	CALL	TCLKSUB
	LD	C,A
	LD	A,(BEFCO)
	ADD	A,C
	JR	NC,FC14
	LD	A,(BEFCO)
	LD	B,A
	LD	A,127
	SUB	B
	LD	B,A
	LD	A,C
	SUB	B
	LD	C,A
	LD	A,127
	CALL	MWRIT2
	LD	A,(FCP18+1)
	CALL	MWRIT2
	LD	A,0FDH
	CALL	MWRIT2
	LD	A,C
FC14:
	CALL	FCOMP17
	JP	FCOMP1
FCOMP16:
	INC	HL
	CALL	FC162
	JP	FCOMP1
; --
	
FC162:
	LD	(FCP18+1),A	; STORE TONE
	CALL	STLIZM	; LIZM SET
	CALL	TCLKSUB	; İ�ٸۯ� ���
	CALL	FCOMP17
	RET
;
	
FCOMP17:
	LD	(BEFCO+1),A
	CP	128
	JR	C,FCOMP2
	
; --	���� ���ް ���	--
	
	SUB	127
	LD	C,A	; STORE
	
	LD	A,127	; FIRST COUNT
	CALL	MWRIT2
	LD	A,(FCP18+1)	; TONE DATA
	CALL	MWRIT2
	
	LD	A,0FDH	; COM OF COUNT OVER (SOUND)
	CALL	MWRIT2
	
	LD	A,C	; RESTORE SECOND COUNT
	LD	(BEFCO),A
	CALL	MWRIT2
	EXX
	LD	HL,BEFTONE+7
	LD	DE,BEFTONE+8
	LD	BC,8
	LDDR
	EXX
FCP18:
	LD	A,0
	LD	(BEFTONE),A
	CALL	MWRIT2
	RET
	
; --	ɰ�� ���	--
FCOMP2:
	LD	DE,(MDATA)
	LD	(DE),A		; SAVE LIZM
	LD	(BEFCO),A
	INC	DE
	LD	A,(FCP18+1)
	LD	(DE),A		; SAVE TONE
	EXX
	LD	HL,BEFTONE+7
	LD	DE,BEFTONE+8
	LD	BC,8
	LDDR
	EXX
	LD	(BEFTONE),A
	INC	DE
	LD	(MDATA),DE	; SET NEW SAVING ADR
	RET
	
; *	COM PROCESS (FM)	*
	
COMPRC:
	DEC	C
	LD	A,C
	
	ADD	A,A
	ADD	A,C	; *3
	LD	DE,COMTBL
	ADD	A,E
	LD	E,A
	ADC	A,D
	SUB	E
	LD	D,A
	PUSH	DE
	RET
	
COMTBL:
	JP	SETLIZ
	JP	SETOCT
	JP	SETDT
	JP	SETVOL
	JP	SETCOL
	
	JP	SETOUP
	JP	SETODW
	JP	SETVUP
	JP	SETVDW
	JP	SETTIE
	
	JP	SETREG
	JP	SETMOD
	JP	SETRST
	JP	SETLPS
	JP	SETLPE
	
	JP	SETSE
	JP	SETJMP
	JP	SETQLG
	JP	SETSEV
	JP	SETMIX
	
	JP	SETWAV
	JP	TIMERB
	JP	SETCLK
	JP	COMOVR
	JP	SETKST
	
	JP	SETRJP
	JP	TOTALV
	JP	SETBEF
	JP	SETHE
	JP	SETHEP
	
	JP	SETDCO
	JP	SETLR
	JP	SETHLF
	JP	SETTMP
	JP	SETTAG
	
	JP	SETMEM
	JP	SETRV
	JP	SETMAC
	JP	STRET
	JP	SETTI2
	
	JP	SETSYO
	JP	ENDMAC
	JP	SETPTM
	JP	SETFLG
NTMN3:
	INC	HL
	JP	FCOMP1
	
; *	!	*
	
COMOVR:
	POP	HL
	POP	HL
	JP	CMPEND
	
; --	�����  CHECK	--
	
	;EXIT:SCF as SSG
	;	A=0-5 as FM
	;	6 as RHYTHM
	;	7 as pcm
	
CHCHK:
	LD	A,(COMNOW)
	CP	3
	JR	NC,CHE2
	AND	A
	RET
CHE2:
	SUB	3
	CP	3
	RET	C
	JR	NZ,CHE3
	LD	A,6
	AND	A
	RET
CHE3:
	CP	7
	RET	NC
	DEC	A
	AND	A
	RET
	
; --	�� Ch� İ�ٸۯ�(ܰ�) � ��ݽ�	--
	
	;IN:A<=CLOCK
	;AF,HL,DE� ο��
	
TCLKSUB:
	EXX
	PUSH	AF
	CALL	TCLKADR
	LD	E,L
	LD	D,H
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	POP	AF
	PUSH	AF
	ADD	A,L
	LD	L,A
	ADC	A,H
	SUB	L
	LD	H,A
	EX	DE,HL
	LD	(HL),E
	INC	HL
	LD	(HL),D
	DEC	HL
	EX	DE,HL
	POP	AF
	EXX
	RET
	
;	OUT:HL<=ADR
	
TCLKADR:
	LD	A,(COMNOW)
	ADD	A,A
	ADD	A,A
	LD	HL,T_CLK
	LD	E,A
	LD	D,0
	ADD	HL,DE
	RET
TCLKCLS:
	CALL	TCLKADR
	XOR	A
	LD	(HL),A
	INC	HL
	LD	(HL),A
	RET
	
; *	FLAGDATA SET	*
	
SETFLG:
	INC	HL
	CALL	REDATA
	JP	NC,STF2
	LD	E,0FFH
STF2:
	LD	A,0F9H
	CALL	MWRITE
	JP	FCOMP1
	
; *	ϸ۾��	*
	
SETMAC:
	INC	HL
	CALL	REDATA
	LD	A,E
	LD	(STM2+1),A
	LD	DE,(ADRSTC)
	EX	DE,HL
	OUT	(5CH),A
	LD	(HL),E
	INC	HL
	LD	(HL),D	;TEXTPOINTER
	INC	HL
	LD	DE,(LINKPT)
	LD	(HL),E
	INC	HL
	LD	(HL),D	;LINKPOINTER
	INC	HL
	LD	(ADRSTC),HL
	LD	HL,(LINE)
	LD	(EMAC2+1),HL
STM2:
	LD	E,0
	LD	H,0
	LD	D,H
	LD	L,E
	ADD	HL,DE
	ADD	HL,HL
	LD	DE,0C000H
	ADD	HL,DE
	LD	E,(HL)
	INC	HL
	LD	D,(HL)	;DE=MACROSTART.ADR
	LD	A,E
	OR	D
	JR	Z,STMERR
	INC	HL
	PUSH	DE
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	LD	(LINKPT),DE
	POP	HL	;ϸ�÷���HL��½
	OUT	(5FH),A
	JP	FCOMP1
STMERR:
	OUT	(5FH),A
	POP	HL
	JP	ERRNMC
STMER2:
	POP	HL
	JP	ERREMC
ENDMAC:
	LD	A,(MACFG)
	CP	0FDH	;GOSUB?
	JR	NZ,EMAC2
	INC	A
	LD	(MACFG),A
	INC	HL
	RET		;FMCOMP��ض�ǹ�
	
EMAC2:
	LD	HL,0
	LD	(LINE),HL
	LD	HL,(ADRSTC)
	OUT	(5CH),A
	DEC	HL
	LD	D,(HL)
	DEC	HL
	LD	E,(HL)
	LD	(LINKPT),DE
	DEC	HL
	LD	D,(HL)
	DEC	HL
	LD	E,(HL)
	LD	(ADRSTC),HL
	EX	DE,HL
	OUT	(5FH),A
	JP	FCOMP1
STRET:
	RET
	
; *	����st	*
	
SETPTM:
	PUSH	HL
	LD	DE,(MDATA)
	LD	HL,PTMDAT
	LD	BC,4
	LDIR
	LD	(BEFMD),DE
	INC	DE
	INC	DE
	LD	A,255
	LD	(DE),A
	INC	DE
	LD	(MDATA),DE
	POP	HL
	INC	HL
	LD	A,(HL)
	CALL	STTONE
	JP	C,ERRSN
	INC	HL
	CALL	FC162	;SET TONE&LIZ
	
	PUSH	HL
	LD	DE,(MDATA)
	LD	A,0F4H
	LD	(DE),A
	INC	DE
	LD	A,(LFODAT)
	DEC	A
	JR	Z,STP1
	XOR	A
	LD	(DE),A
	INC	DE
	LD	HL,LFODAT+1
	LD	BC,5
	LDIR
	JR	STP2
STP1:
	LD	A,1
	LD	(DE),A
	INC	DE
STP2:
	LD	(MDATA),DE
	POP	HL
STP22:
	LD	A,(HL)
	OR	A
	JP	Z,ERRSN
	CP	'}'
	JP	Z,ERRNE
	CP	'>'
	CALL	Z,SOU1
	CP	'<'
	CALL	Z,SOD1
	CALL	CULPTM
	JP	C,ERRSN
	
	PUSH	HL
	LD	HL,(BEFMD)
	LD	(HL),E
	INC	HL
	LD	(HL),D
	INC	HL
	POP	HL
	INC	HL
	LD	A,(HL)
	CP	'}'
	JP	NZ,ERRSN
	INC	HL
	JP	FCOMP1
	
PTMDAT:
	DB	0F4H,0,1,1
	
; *	�����ϰ�	*
	
SETSYO:
	INC	HL
	JP	FCOMP1
	
; *	��ް��	*
	
SETRV:
	CALL	CHCHK
	CP	6
	JP	NC,ERRDC
	INC	HL
	LD	A,(HL)
	CP	'm'
	JR	Z,SRV3
	CP	'F'
	JR	Z,SRV4
	DEC	HL
	
	LD	A,0FFH
	LD	E,0F3H
SRV2:
	CALL	MWRITE
	CALL	ERRT
	LD	A,E
	CALL	MWRIT2
	JP	FCOMP1
SRV3:
	LD	A,0FFH
	LD	E,0F4H
	JR	SRV2
SRV4:
	LD	A,0FFH
	LD	E,0F5H
	JR	SRV2
	
; *	���Ը	*
	
SETMEM:	LD	A,(HL)
	INC	HL
	OR	A
	JP	NZ,SETMEM
	RET
	
; *	SET TAG & JUMP TO TAG	*
	
SETTAG:
	PUSH	HL
	CALL	TCLKADR
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	LD	(JCLOCK),DE
	LD	HL,(LINE)
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	LD	(JPLINE),HL
	POP	HL
	INC	HL
	JP	FCOMP1
	
; *	HARD LFO	*
	
SETHLF:
	CALL	CHCHK
	JP	C,ERRDC
	CP	6
	JP	NC,ERRDC
	LD	A,0FCH
	CALL	MWRIT2
	CALL	ERRT
	LD	A,E
	CALL	MWRIT2
	CALL	ERRT
	LD	A,E
	CALL	MWRIT2
	CALL	ERRT
	LD	A,E
	CALL	MWRIT2
	JP	FCOMP1
	
; *	STEREO PAN	*
	
SETLR:
	CALL	ERRT
	LD	A,0F8H	; COM OF 'p'
	CALL	MWRITE
	JP	FCOMP1
	
; *	DIRECT COUNT	*
	
SETDCO:
	CALL	ERRT
	LD	A,E
	LD	(COUNT),A
	JP	FCOMP12
	
; *	SET HARD ENVE TYPE/FLAG	*
	
SETHE:
	INC	HL
	LD	A,0FFH
	LD	E,0F1H	; 2nd COM
	CALL	MWRITE
	CALL	REDATA
	LD	A,E
	CALL	MWRIT2
	JP	FCOMP1
SETHEP:
	INC	HL
	LD	A,0FFH
	LD	E,0F2H
	CALL	MWRITE
	CALL	REDATA
	LD	A,E
	LD	E,D
	CALL	MWRITE	; 2�޲��ް� ��
	JP	FCOMP1
	
; *	BEFORE CODE	*
	
SETBEF:
	INC	HL
	LD	A,(HL)
	CP	'='
	JR	NZ,STBF3
	CALL	ERRT
	LD	A,E
	CP	10
	JP	NC,ERRIF
	OR	A
	JR	NZ,STBF2
	INC	A
STBF2:
	DEC	A
	LD	(BFDAT),A
	LD	A,(HL)
	CP	','
	JR	Z,STBF21
	JP	FCOMP1
STBF21:
	CALL	ERRT
	LD	A,E
	LD	(VDDAT),A
	JP	FCOMP1
STBF3:
	LD	A,(VDDAT)
	NEG
	LD	E,A
	LD	A,0FBH
	CALL	MWRITE
	LD	A,(BEFCO)
	CALL	MWRIT2
	LD	A,(BEFCO)
	CALL	TCLKSUB
	LD	A,(BFDAT)
	PUSH	HL
	LD	HL,BEFTONE
	LD	E,A
	LD	D,0
	ADD	HL,DE
	LD	A,(HL)
	CALL	MWRIT2
	POP	HL
	LD	A,(VDDAT)
	LD	E,A
	LD	A,0FBH
	CALL	MWRITE
	JP	FCOMP1
	
BFDAT:	DB	1
	
; *	TOTAL VOLUME	*
	
TOTALV:
	CALL	ERRT
	LD	A,E
	LD	(TV_OFS),A
	JP	FCOMP1
TV_OFS:
	DB	0		; TOTAL V. OFFSET
	
; *	KEY SHIFT	*
	
SETKST:
	CALL	ERRT
	LD	A,E
	LD	(SIFTDAT),A
	
	JP	FCOMP1
	
; *	CLOCK SET	*
	
SETCLK:
	CALL	ERRT
	LD	A,E
	LD	(CLOCK),A
	JP	FCOMP1
	
; **	Q	**
	
SETQLG:
	CALL	ERRT
	LD	A,0F3H	; COM OF 'q'
	CALL	MWRITE
	JP	FCOMP1
	
; **	JUMP ADDRESS SET	**
	
SETJMP:
	INC	HL
	PUSH	HL
	
	LD	HL,(MDATA)
	CALL	TBOFS
	EX	DE,HL
	
	LD	A,(COMNOW)
	CALL	CHTBL
	INC	HL
	INC	HL
	
	LD	(HL),E
	INC	HL
	LD	(HL),D
	
	CALL	TCLKADR
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	INC	DE	; +1('L'�׸�� ���)
	INC	HL
	LD	(HL),E
	INC	HL
	LD	(HL),D
	
	POP	HL
	JP	FCOMP1
	
; **	TEMPO(TIMER_B) SET	**
	
TIMERB:
	CALL	ERRT	;E<=DATA
TIMEB2:
	PUSH	HL
	LD	HL,(DATTBL)
	DEC	HL	; TIMER_B � �ܾ�
	LD	(HL),E
	POP	HL
	LD	A,(COMNOW)
	SUB	3
	CP	3
	JP	C,FCOMP1
	PUSH	DE
	LD	A,0FAH
	LD	E,26H
	CALL	MWRITE
	POP	DE
	LD	A,E
	CALL	MWRIT2
	JP	FCOMP1
SETTMP:
	CALL	ERRT	;T
	LD	A,E
	OR	A
	JP	Z,ERRSN
	PUSH	HL
	PUSH	DE
	LD	A,(CLOCK)
	LD	L,A
	LD	H,0
	LD	DE,4
	CALL	DIV	; L
	POP	DE
	CALL	MULT	; T*L
	EX	DE,HL
	
	LD	HL,60000
	LD	BC,0
STTMP2:
	INC	BC
	AND	A
	SBC	HL,DE
	JR	NC,STTMP2
	
	LD	E,C
	LD	HL,346
	CALL	MULT
	LD	DE,25600
	AND	A
	SBC	HL,DE
	JR	C,STTMP3
	LD	HL,-100
STTMP3:
	EX	DE,HL
	LD	HL,0
	AND	A
	SBC	HL,DE	; HL=-(346*SEC-256)
	LD	DE,100
	CALL	DIV
	EX	DE,HL
	POP	HL
	JP	TIMEB2
	
	
; **	NOIZE WAVE	**
	
SETWAV:
	CALL	CHCHK
	JP	NC,ERRDC
	
	CALL	ERRT
	
	LD	A,0F8H	; COM OF 'w'
	CALL	MWRITE
	JP	FCOMP1
	
	
; **	MIX PORT	**
	
SETMIX:	CALL	CHCHK
	JP	NC,ERRDC
	
	CALL	ERRT
	
	LD	A,E
	CP	1
	LD	E,8
	JR	Z,SETMI2
	CP	2
	LD	E,1
	JR	Z,SETMI2
	CP	3
	LD	E,0
	JR	Z,SETMI2
	
	OR	A
	LD	E,9
	JR	Z,SETMI2
	
	JP	ERRSN
	
SETMI2:
	LD	A,0F7H	; COM OF 'P'
	CALL 	MWRITE
	JP	FCOMP1
	
; **	SOFT ENVELOPE	**
	
SETSEV:	CALL	CHCHK
	JP	NC,ERRDC
	CALL	ERRT
	LD	A,0FAH    ; COM OF 'E'
	CALL	MWRITE
	LD	B,5	; ɺ� 5 PARAMETER
	JP	SETSE1
	
; **	REST	**
	
SETRST:
	INC	HL
;	LD	A,(HL)		;���폜
;	CP	'%'		;��
;	JR	NZ,SRS2		;��
;	INC	HL		;��
;	CALL	REDATA		;��
;	JR	C,SETRS2	;��
;	OR	A		;��
;	JP	NZ,ERRIF	;��
;	LD	A,E		;��
;	JR	SETRS3		;��
SRS2:
	CALL	REDATA
;	JR	C,SETRS2	; NON DATA	;���C���O
	JP	C,SETRS2	; NON DATA	;���C����
	OR	A
	JP	NZ,ERRIF
	
	PUSH	HL
	LD	A,(CLOCK)
	LD	L,A
	LD	H,0
	CALL	DIV
	POP	HL
	
	LD	A,(KOTAE)
SETRS0:
	LD	C,A	; STORE
	
	LD	A,(HL)
	CP	'.'
	
	LD	A,C		; RESTORE
	JR	NZ,SETRS3	; ��� �ެŹ��� SETRS3
	INC	HL
	LD	B,A
	SRL	A	; /2
	LD	C,A
	LD	A,B
	JR	SETRS4
SETRS3:
	LD	C,0
SETRS4:
	ADD	A,C
	LD	C,A
	CALL	TCLKSUB
	
	LD	A,(BEFRST)	; ��ݶ����� ܰ�(�׸�)
	OR	A
	JR	Z,SETRS5	; ��ݶ� �� 'r'�� ·��
	LD	A,(BEFRST)
	ADD	A,C
	LD	C,A
	LD	DE,(MDATA)
	DEC	DE
	LD	(MDATA),DE
SETRS5:
	LD	A,C
	CP	70H
	JR	NC,SETRS1
	LD	(BEFRST),A
	OR	10000000B	; SET REST FLAG
	CALL	MWRIT2
	JP	FCOMP12
	
SETRS1:
	SUB	6FH
	LD	C,A
	LD	A,11101111B
	CALL	MWRIT2
	
	LD	A,C
	CP	70H
	JR	NC,SETRS1
	LD	(BEFRST),A
	OR	10000000B
	CALL	MWRIT2
	JP	FCOMP12
SETRS2:
	LD	A,(COUNT)
	JP	SETRS0
	
; **	REPEAT JUMP	**
	
SETRJP:
	INC	HL
	PUSH	HL
	
	LD	A,0FEH
	CALL	MWRIT2
	
	LD	HL,(POINTC)
	LD	DE,4
	ADD	HL,DE
	
	PUSH	HL
	LD	A,(HL)
	INC	HL
	LD	D,(HL)
	OR	D
	POP	HL
	JR	NZ,RJPER	; [] � / � ��� �޹
	
	LD	DE,(MDATA)
	LD	(HL),E
	INC	HL
	LD	(HL),D
	INC	HL
	INC	HL
	INC	HL
	INC	DE
	INC	DE
	LD	(MDATA),DE
	PUSH	HL
	CALL	TCLKADR
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	POP	HL
	LD	(HL),E
	INC	HL
	LD	(HL),D
	
	POP	HL
	JP	FCOMP1
	
RJPER:
	POP	HL
	JP	ERRRJ
	
	
; **	LOOP START	**
	
SETLPS:
	INC	HL
	PUSH	HL
	LD	A,0F5H	; COM OF LOOPSTART
	CALL	MWRIT2
	
	LD	HL,(POINTC)
	LD	DE,10
	ADD	HL,DE
	LD	(POINTC),HL
	LD	DE,(MDATA)
	LD	(HL),E		; SAVE REWRITE ADR
	INC	HL		;
	LD	(HL),D		;
	INC	HL
	INC	DE
	INC	DE
	LD	(MDATA),DE
	
	LD	(HL),E   	; SAVE LOOP START ADR
	INC	HL		;
	LD	(HL),D		;
	INC	HL
	XOR	A
	LD	(HL),A
	INC	HL
	LD	(HL),A
	INC	HL
	PUSH	HL
	CALL	TCLKADR
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	POP	HL
	LD	(HL),E
	INC	HL
	LD	(HL),D
	XOR	A
	INC	HL
	LD	(HL),A
	INC	HL
	LD	(HL),A
	CALL	TCLKCLS	;İ�� �ۯ� �ر
	
	LD	HL,REPCOUNT
	INC	(HL)
	LD	A,(HL)
	CP	17
	JR	NC,SETLPS2
	POP	HL
	JP	FCOMP1
SETLPS2:
	POP	HL
	JP	ERRML
	
POINTC:
	DW	0		; LOOPSTART ADR ��
				; ��ò��ò� ADR
REPCOUNT:
	DB	0
	
; **	LOOP END	**
	
SETLPE:
	CALL	ERRT
	
	PUSH	HL
	
	LD	A,0F6H		; WRITE COM OF LOOP
	CALL	MWRIT2
	LD	A,E
	CALL	MWRIT2		; WRITE LOOP Co.
	LD	DE,(MDATA)
	CALL	MWRIT2		; WRITE LOOP Co. (SPEAR)
	PUSH	AF
	
	LD	HL,(POINTC)
	LD	BC,LOOPSP	; STAC TOP
	AND	A
	SBC	HL,BC
	JP	C,SETLPEE    	; ']' � ��� �� ���
	
	LD	HL,(POINTC)
	PUSH	HL
	LD	BC,10
	AND	A
	SBC	HL,BC
	LD	(POINTC),HL
	POP	HL
	
	PUSH	HL
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	
	PUSH	HL
	AND	A
	EX	DE,HL
	SBC	HL,DE
	EX	DE,HL	; DE as OFFSET
	POP	HL
	
	LD	(HL),E	;
	INC	HL      ; RSKIP JP ADR
	LD	(HL),D  ;
	
	POP	HL
	INC	HL
	INC	HL
	PUSH	HL
	
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A		; HL � LOOP � ����� ���ڽ
	
	LD	DE,(MDATA)
	EX	DE,HL
	AND	A
	SBC	HL,DE		; HL as LOOP RET ADR OFFSET
	EX	DE,HL
	
        LD	HL,(MDATA)
	LD	(HL),E		;
	INC	HL		; WRITE RET ADR OFFSET
	LD	(HL),D		;
	INC	HL
	LD	(MDATA),HL
	
	POP	HL
	INC	HL
	INC	HL
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	OR	H
	JR	Z,SETLPE1
	
	LD	DE,(MDATA)
	DEC	DE
	DEC	DE
	DEC	DE
	DEC	DE
	PUSH	HL
	EX	DE,HL
	AND	A
	SBC	HL,DE
	EX	DE,HL	; DE as OFFSET
	POP	HL
	
	LD	(HL),E
	INC	HL
	LD	(HL),D
	
SETLPE1:
	LD	HL,REPCOUNT
	DEC	(HL)
	CALL	TCLKADR
	LD	(SETLPE4+1),HL
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	POP	AF
	LD	(SETLPE3+1),HL
	DEC	A
	LD	E,A
	CALL	MULT
	EX	DE,HL
	LD	HL,(POINTC)
	LD	BC,16
	ADD	HL,BC
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	ADD	HL,DE
	PUSH	HL
	LD	HL,(POINTC)
	LD	DE,18
	ADD	HL,DE
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	POP	HL
	LD	A,E
	OR	D
	JR	Z,SETLPE3	; '/'� ���Ų� ¶���Ų
	ADD	HL,DE
	JR	SETLPE4
SETLPE3:
	LD	DE,0000H
	ADD	HL,DE
SETLPE4:
	LD	(0000H),HL
	
	POP	HL
	JP	FCOMP1
	
SETLPEE:
	POP	AF
	POP	HL		; DUMMY
	JP	ERRNF
	
; **	SE DETUNE � ��ò	**
	
SETSE:
	LD	A,(COMNOW)
	CP	2
	JP	NZ,ERRDC	; 3 Ch ��޲�� ERROR
	
	CALL	ERRT
	
	LD	A,0F7H		; COM OF 'S'
	CALL	MWRIT2
	LD	A,E
	CALL	MWRIT2
	
	LD	B,3		; ɺ� 3 PARAMETER
SETSE1:
	LD	A,(HL)
	CP	','
	JP	NZ,ERRNE
	INC	HL
	CALL	REDATA
	JP	C,ERRNE	; NONDATA ��ERROR
	OR	A
	JP	NZ,ERRIF
	LD	A,E
	CALL	MWRIT2		; SET DATA ONLY
	DJNZ	SETSE1
	
	JP	FCOMP1
	
; **	LFO SET	**
	
SETMOD:
	LD	IX,LFODAT
	INC	HL
	CALL	REDATA
	
	JP	C,SETMO2; NONDATA �� 2nd COM PRC
	OR	A
	JP	NZ,ERRIF
	
	LD	(IX),0
	LD	A,0F4H	; COM OF 'M'
	CALL	MWRIT2
	LD	A,0	; 2nd COM
	CALL	MWRIT2
	LD	A,E
	LD	(IX+1),A
	CALL	MWRIT2	; SET DELAY
	
; --	���� ���	--
	
SETMO1:
	LD	A,(HL)
	CP	','
	JP	NZ,ERRNE
	INC	HL
	CALL	REDATA
	JP	C,ERRNE
	OR	A
	JP	NZ,ERRIF
	LD	A,E
	LD	(IX+2),A
	CALL	MWRIT2	; SET DATA ONLY
	
; --	SET VECTOR	--
	
	LD	A,(HL)
	CP	','
	JP	NZ,ERRNE
	INC	HL
	
	CALL	REDATA
	
	JP	C,ERRNE
	OR	A
	JP	NZ,ERRIF
	
	PUSH	HL
	LD	HL,(MDATA)
	CALL	CHCHK
	JR	NC,SETVEC2
	
	CALL	NEG16
SETVEC2:
	LD	(HL),E
	LD	(IX+3),E
	INC	HL
	LD	(HL),D
	LD	(IX+4),D
	INC	HL
	LD	(MDATA),HL
	POP	HL
	
; --	SET DEPTH	--
	
SETPLAMU:
	LD	A,(HL)
	CP	','
	JP	NZ,ERRNE
	CALL	ERRT
	LD	A,E
	LD	(IX+5),A
	CALL	MWRIT2	; SET DATA ONLY
	
	LD	A,(HL)
	CP	','
	JP	NZ,FCOMP1
	CALL	ERRT
	
	JP	FCOMP1
	
NEG16:				;DE<=NEG.DE
	PUSH	HL
	LD	HL,0
	AND	A
	SBC	HL,DE
	EX	DE,HL
	POP	HL
	RET
	
; --	LFO 2nd COM	--
	
SETMO2:
	INC	HL
	LD	A,0F4H	; COM OF 'M'
	CALL	MWRIT2	; COM ONLY
	
	LD	A,(SECCOM)
	CP	'F'
	JR	NZ,MO4
	CALL	REDATA
	JP	C,ERRSN
	OR	A
	JP	NZ,ERRIF
	
	LD	A,E
	OR	A
	JP	NZ,MO3
	INC	E	; SECOND COM
	LD	(IX),E
	LD	A,E
	CALL	MWRIT2	; 'MF0'
	JP	FCOMP1
MO3:
	DEC	A
	JP	NZ,ERRSN
	INC	E
	LD	(IX),E
	LD	A,E
	CALL	MWRIT2	; 'MF1'
	JP	FCOMP1
MO4:
	LD	IY,LFODAT+1
	CP	'W'
	JR	NZ,M05
	LD	A,3	; COM OF 'MW'
	JP	MODP2
M05:
	INC	IY
	CP	'C'
	JR	NZ,M06
	LD	A,4	; 'MC'
	JR	MODP2
M06:
	INC	IY
	CP	'L'
	JR	NZ,M07
	LD	A,5	; 'ML'
	LD	(IX),A
	CALL	MWRIT2
	CALL	REDATA
	JP	C,ERRSN
	OR	A
	JP	NZ,ERRIF
	LD	A,E
	LD	(IY),A
	LD	E,D
	LD	(IY+1),E
	LD	(IY+2),0
	CALL	MWRITE
	JP	FCOMP1
M07:
	INC	IY
	INC	IY
	INC	IY
	CP	'D'
	JP	NZ,M08
	LD	A,6
	JR	MODP2
M08:
	CP	'T'
	JP	NZ,ERRSN
	CALL	CHCHK
	JP	C,ERRDC
	CALL	REDATA
	JP	C,ERRSN
	OR	A
	JP	NZ,ERRIF
	LD	A,7
	CALL	MWRITE
	LD	E,A
	OR	A
	JP	Z,FCOMP1
M083:
	INC	HL
	CALL	REDATA
	JP	C,ERRSN
	OR	A
	JP	NZ,ERRIF
	LD	A,E
	CALL	MWRIT2
	JP	FCOMP1
	
; **	PARAMETER SET	**
	
;	IN: A<= COM No.
	
MODP2:
	LD	(IX),A
	CALL	MWRIT2
	CALL	REDATA
	JP	C,ERRSN
	
	OR	A
	JP	NZ,ERRIF
	LD	A,E
	LD	(IY),E
	CALL	MWRIT2
	JP	FCOMP1
	
	
; **	REGISTER SET	**
	
SETREG:
	INC	HL
	CALL	REDATA
	JR	C,SETR2
	OR	A
	JP	NZ,ERRIF
	
	LD	A,0B2H
	CP	E
	JP	C,ERRIF
	
SETR1:
	LD	A,0FAH	; COM OF 'y'
	CALL	MWRITE
	
	LD	A,(HL)
	CP	','
	JP	NZ,ERRSN
	INC	HL
	
	CALL	REDATA
	JP	C,ERRSN
	OR	A
	JP	NZ,ERRIF
	
	LD	A,E
	CALL	MWRIT2	; SET DATA ONLY
	
	JP	FCOMP1
	
; --	yXX(Ӽ���),OpNo.,DATA	--
	
SETR2:
	LD	DE,DMDAT
	LD	BC,7*256
SETR3:
	PUSH	HL
	PUSH	BC
	PUSH	DE
	CALL	MCMP
	POP	DE
	POP	BC
	JP	NC,SETR4
	INC	DE
	INC	DE
	INC	DE
	INC	C
	POP	HL
	DJNZ	SETR3
	
	JP	ERRSN
	
SETR4:
	POP	DE	; HL� POP�Ų!
	LD	A,C
	ADD	A,A
	ADD	A,A
	ADD	A,A
	ADD	A,A	; *16
	LD	(SETR9+1),A
	
	LD	A,(HL)
	CP	','
	JP	NZ,ERRSN
	
	CALL	ERRT	; ���ڰ�� No.
	
	LD	A,E
	OR	A
	JP	Z,ERRIF
	CP	5
	JP	NC,ERRIF
	CP	3
	JR	NZ,SETR5
	LD	A,2
	JR	SETR6
SETR5:
	CP	2
	JR	NZ,SETR6
	LD	A,3
SETR6:
	DEC	A
	ADD	A,A
	ADD	A,A	;Op*4
	LD	C,A
	LD	A,(COMNOW)
	CP	3
	JR	C,SETR8
	SUB	7
	CP	3
	JP	NC,ERRDC	; CH A-C,H-J�� �ֳ�޷�
SETR8:
	ADD	A,C	; Op*4+CH No.
	LD	C,A
SETR9:
	LD	A,0
	ADD	A,30H
	ADD	A,C
	LD	E,A
	JP	SETR1
DMDAT:
	DB	'DM',0
	DB	'TL',0
	DB	'KA',0
	DB	'DR',0
	DB	'SR',0
	DB	'SL',0
	DB	'SE',0
	
; **	TIE	**
	
SETTIE:
	CALL	SETTI1
	JP	FCOMP12
SETTI1:
	INC	HL
	LD	A,0FDH
	LD	(TIEFG),A
	CALL	MWRIT2
	RET
SETTI2:
	CALL	SETTI1
	LD	A,(BEFTONE)
	JP	FCOMP13
	
; **	OCTAVE UP & DOWN	**
	
SETOUP:
	CALL	SOU1
	JP	C,ERROO
	JP	FCOMP1
SOU1:
	INC	HL
	LD	A,(UDFLG)
	OR	A
	JR	NZ,SOD2
SOU2:
	LD	A,(OCTAVE)
	CP	7
	JR	Z,OO
	INC	A
	LD	(OCTAVE),A
	AND	A
	RET
	
SETODW:
	CALL	SOD1
	JP	C,ERROO
	JP	FCOMP1
SOD1:
	INC	HL
	LD	A,(UDFLG)
	OR	A
	JR	NZ,SOU2
SOD2:
	LD	A,(OCTAVE)
	OR	A
	JR	Z,OO
	DEC	A
	LD	(OCTAVE),A
	AND	A
	RET
OO:
	SCF
	RET
	
; **	VOL UP& DOWN SET	**
	
SETVUP:
	LD	A,(UDFLG)
	OR	A
	JR	NZ,SVD2
SVU2:
	INC	HL
	CALL	REDATA
	JR	NC,SETVU2
	LD	E,1	; �ݶ 1
SETVU2:
	LD	A,(VOLUME)
	ADD	A,E
	LD	(VOLUME),A
	LD	A,0FBH	; COM OF ')'
	CALL	MWRITE
	JP	FCOMP1
	
SETVDW:
	LD	A,(UDFLG)
	OR	A
	JR	NZ,SVU2
SVD2:
	INC	HL
	CALL	REDATA
	JR	NC,SETVD2
	LD	E,1
SETVD2:
	LD	A,(VOLUME)
	SUB	E
	LD	(VOLUME),A
	LD	A,E
	NEG		; ̺޳ ����
	LD	E,A
	LD	A,0FBH	; ')' � ���� � '('
	CALL	MWRITE
	JP	FCOMP1
	
; **	�ݼ�����	**
	
SETCOL:
	INC	HL
	LD	A,(HL)
	CP	'"'
	JP	Z,SETVN
	INC	HL
	LD	A,(HL)
	CP	'='
	JP	Z,SETEV
	DEC	HL
	DEC	HL
	CALL	ERRT
	LD	A,E
	LD	(STCL6+1),A
	
	CALL	CHCHK
	JR	C,STCL5	;STCL3
	CP	6
	JR	C,STCL2
SETCO1:			;RHY&PCM
	LD 	C,E
	PUSH 	HL
	JP 	STCL72
STCL2:		;FM
	INC	E
	PUSH HL
	LD	HL,DEFVOICE
	CALL	CCVC
	JR	C,STCL7
	LD	HL,DEFVOICE
	CALL	CWVC
	JR	NC,STCL7
	POP	HL
	JP	ERRVF
STCL3:		;SSG
	INC	E
	PUSH	HL
	LD	HL,DEFVSSG
	CALL	CCVC
	JR	C,STCL5
	LD	HL,DEFVSSG
	CALL	CWVC
	JR	NC,STCL5
	POP	HL
	JP	ERRVF
STCL5:
	LD	C,E
	CALL	STCL8
	LD	A,(PSGMD)
	OR	A
	JP	NZ,FCOMP1
STCL6:
	LD	A,0
	PUSH	HL
	LD	L,A
	LD	H,0
	LD	DE,16
	CALL	MULT
	LD	DE,SSGLIB
	ADD	HL,DE
	LD	A,0F7H
	CALL	MWRIT2
	LD	A,(HL)
	CALL	MWRIT2
	LD	DE,8
	ADD	HL,DE
	LD	A,(HL)
	DEC	A
	JR	Z,STCL73
	PUSH	HL
	LD	DE,(MDATA)
	LD	A,0F4H
	LD	(DE),A
	INC	DE
	LD	BC,6
	LDIR
	LD	(MDATA),DE
	POP	HL
	LD	DE,LFODAT
	LD	BC,6
	LDIR
	JR	STCL73
STCL7:
	DEC	C
STCL72:
	CALL	STCL8
STCL73:
	POP	HL
	JP	FCOMP1
STCL8:
	LD 	E,C
	LD 	A,0F0H		; COM OF '@'
	CALL 	MWRITE		; E as VOICE NUMBER
	RET
SETEV:
	CALL	CHCHK
	JP	NC,ERRDC
	DEC	HL
	DEC	HL
	CALL	ERRT
	LD	A,E
	CP	16
	JP	NC,ERRIF
	INC	E
	PUSH	HL
	LD	HL,DEFVSSG
	CALL	CCVC
	JR	C,STEV2
	LD	HL,DEFVSSG
	CALL	CWVC
	JR	NC,STEV2
	POP	HL
	JP	ERRVF
STEV2:
	LD	E,C
	DEC	E
	LD	A,0FCH
	CALL	MWRITE
	POP	HL
	CALL	ERRT
	LD	A,E
	CALL	MWRIT2
	LD	B,5
	JP	SETSE1
SETVN:
	CALL	CHCHK
	JP	C,ERRDC
	CP	6
	JP	NC,ERRDC
	INC	HL
	LD	DE,6020H+26
	LD	BC,0FF01H
SETVN1:
	PUSH	BC
	LD	B,6
	PUSH	HL
	PUSH	DE
SETVN2:
	LD	A,(DE)
	CP	(HL)
	JR	NZ,SETVN4
	INC	HL
	INC	DE
	LD	A,(HL)
	CP	'"'
	JR	Z,SETVN6
	DJNZ	SETVN2
	POP	DE
	POP	HL
	POP	BC
	JP	ERRVO
SETVN4:
	POP	DE
	LD	HL,32
	ADD	HL,DE
	EX	DE,HL
	POP	HL
	POP	BC
	INC	C
	DJNZ	SETVN1
	JP	ERRVO
SETVN6:
	INC	HL
	POP	AF
	POP	AF
	POP	AF
	DEC	B
	JR	Z,SETVN8
	LD	A,(DE)
	CP	20H
	JP	NZ,ERRVO
SETVN8:
	LD	E,C
	JP	STCL2
	
; --	VOICE �� ĳ۸��ж?	--
	
	;IN:HL<=BUF
CCVC:
	LD	B,32
	LD	A,E		; GET VOICE NUMBER
	LD	C,1
CCVC2:
	LD	D,(HL)
	CP	D
	JR 	Z,CCVC3	; VOICE � ���� ĳ۸���
	
	INC	HL
	INC	C
	DJNZ	CCVC2
	AND	A
	RET
CCVC3:
	SCF
	RET
	
; --	WORK � �� �� �ٶ?	--
	
	;IN:HL<=BUF
CWVC:
	LD	B,32
	LD	C,1
CWVC2:
	LD	A,(HL)
	OR	A
	JR	Z,CWVC3	; WORK � �� ��
	INC	HL
	INC	C
	DJNZ	CWVC2
	SCF
	RET
CWVC3:
	LD 	A,E		; GET VOICE NUMBER
	LD 	(HL),A
	AND	A
	RET
	
; **	VOLUME SET	**
	
SETVOL:
	LD	A,(COMNOW)
	CP	10
	JR	Z,STV4
	INC	HL
	CALL	REDATA
	JP	NC,STV1
	LD	A,(VOLINT)
	LD	E,A
	
STV1:	LD	A,E
	LD	(VOLUME),A
	LD	(VOLINT),A
	
	LD	A,(COMNOW)
	CP	6
	JR	Z,STV2
	SUB	3
	CP	3
	JR	C,STV12		;���ǋL
	LD	A,(TV_OFS)
;	JR	C,STV12		;���폜
	ADD	A,E
	ADD	A,4
	LD	E,A
;	JR	SETVOL2		;���폜
STV12:
;	ADD	A,E		;���폜
;	LD	E,A		;��
;SETVOL2:			;��
	LD	A,0F1H		; COM OF 'v'
	CALL	MWRITE
	JP	FCOMP1
	
; -	DRAM V.	-
	
STV2:
	LD	A,(TV_OFS)
	ADD	A,E
	LD	E,A
	LD	A,0F1H
	CALL	MWRITE
	
	LD	B,6
STV3:
	PUSH	BC
	LD	A,(HL)
	CP	','
	JP	NZ,ERRNE
	CALL	ERRT
	LD	A,E
	CALL	MWRIT2
	POP	BC
	DJNZ	STV3
	JP	FCOMP1
	
; -	PCMVOL	-
	
STV4:
	INC	HL
	CALL	REDATA
	JR	C,STV5
	OR	A
	JP	NZ,ERRIF
	
	JR	STV1
STV5:
	LD	A,0FFH
	LD	E,0F0H
	CALL	MWRITE
	
	LD	A,(HL)
	CP	'm'
	JP	NZ,ERRSN
	INC	HL
	
	CALL	REDATA
	JP	C,ERRSN
	OR	A
	JP	NZ,ERRIF
	
	LD	A,E
	CALL	MWRIT2	; SET DATA ONLY
	
	JP	FCOMP1
	
	
; **   DETUNE SET   **
	
SETDT:
	CALL	ERRT
	CALL	CHCHK
	JR	NC,STD2
	CALL	NEG16
STD2:
	LD	A,0F2H	; COM OF 'D'
	CALL	MWRITE
	LD	A,D
	CALL	MWRIT2
	LD	A,(HL)
	INC	HL
	CP	'+'
	JR	Z,STD5
	XOR	A
	DEC	HL
STD5:
	CALL	MWRIT2
	JP	FCOMP1
	
; **   ؽ�� ���   **
	
SETLIZ:
	CALL	ERRT
	LD	A,(CLOCK)
	CP	E
	JP	C,ERRND	; CLOCK < E �� ERR
	PUSH	HL
	LD	H,0
	LD	L,A		; HL=CLOCK : DE = LIZM
	CALL	DIV
	LD	A,(KOTAE)	; GET COUNTER
	POP	HL
	LD	(COUNT),A
	
	LD	C,A
	LD	E,0
SETLI1:
	LD	A,(HL)
	CP	'.'
	JR	NZ,SETLI2
	INC	HL
	SRL	C
	LD	A,C
	ADD	A,E
	LD	E,A
	LD	A,C
	JR	SETLI1
SETLI2:
	LD	A,(KOTAE)
	ADD	A,E
	LD	(COUNT),A
	JP	FCOMP12		; EXIT SETCOM
	
; **   ������ ���  **
	
SETOCT:
	INC	HL
	CALL	REDATA
	JR	NC,STO2
	LD	A,(OCTINT)
	LD	E,A
	INC	E
STO2:
	LD	A,E
	DEC	A
	CP	8		; OCTAVE > 8?
	JP	NC,ERROO
	LD	(OCTAVE),A
	LD	(OCTINT),A
	JP	FCOMP1		; EXIT SETCOM
	
; **   ���߲� ܰ� �ر �Ƽ�ײ��   **
	
INIT0:
	DI
	LD	A,(0E6C2H)
	RES	3,A
	LD	(0E6C2H),A
	OUT	(31H),A	;���̨�� OFF
	OUT	(5CH),A
	LD	HL,0C000H
	LD	BC,255*2
	CALL	MEMCLR
	OUT	(5FH),A
	EI
	
	XOR	A
	LD	(COMNOW),A
	LD	HL,COMWK
	LD	BC,127
	CALL	MEMCLR
	LD	A,11
	LD	(MAXCH),A
	ADD	A,A	;*4
	LD	(MAXCH_MULT4),A
	LD	HL,0C800H
	LD	(ADRSTC),HL
	CALL	INIT
	RET
INIT:
	LD	A,1
	LD	(LFODAT),A
	LD	A,5
	LD	(OCTAVE),A
	LD	A,24
	LD	(COUNT),A
	LD	A,128
	LD	(CLOCK),A
	XOR	A
	LD	(VOLUME),A
	RET
	
TEXTINIT:
	LD	HL,TEXT+80	; ����ޭ��
	LD	(HL),22
	INC	HL
	LD	(HL),01001000B
	INC	HL
	LD	(HL),80-22
	INC	HL
	LD	(HL),11101000B
	LD	HL,MESS
	LD	DE,TEXT
	LD	BC,70
	LDIR
	CALL	PRMODE
	RET
	
; --	��ظر	--
	
MEMCLR:
;IN:	HL<=ADR ,BC=LENGTH
	LD	(HL),0
	LD	E,L
	LD	D,H
	INC	DE
	LDIR
	RET
	
; **   ܰ��ر ��ĳ���� ��ò   **
	
; 	IN: A<= ASC CODE (A-Z)
	
WORKGET:
	DEC	A
	LD	(MU_NUM),A
	CALL	TBCLR4		; ð��ٸر
	LD	A,(MU_NUM)
	CALL	GETTBL
	LD	(DATTBL),HL
	LD	(MDATA),DE
	RET
	
; --	A���� � ð��پ�ĳ���ڽ � �ݶ޸�ް���ĳ���ڽ � ����	--
	
	;IN:	A<=MUSICNUM(0-N)
	;EXIT:	HL<=TABLE ADR TOP
	;	DE<=MUSIC DATA ADR TOP
	
GETTBL:
	LD	DE,MU_TOP+1
GETTB2:
	PUSH	AF
	PUSH	DE
	LD	HL,(MAXCH)
	LD	E,4
	CALL	MULT
	POP	DE
	ADD	HL,DE
	INC	HL
	INC	HL
	EX	DE,HL	;DE=MDATA
	POP	AF
	OR	A
	RET	Z
	
	DEC	A
	EX	DE,HL
	DEC	HL
	LD	D,(HL)
	DEC	HL
	LD	E,(HL)
	LD	HL,MU_TOP
	ADD	HL,DE
	EX	DE,HL
	INC	DE	; DE=·� � ��� � MU_TOP+1� ���ڽ
	JR	GETTB2
	
	
; --	ð��� � �ر��	--
	
TBCLR4:
	LD	HL,(MAXCH)
	LD	E,4
	CALL	MULT
	INC	HL
	PUSH	HL
	LD	A,(MU_NUM)
	CALL	GETTBL
	LD	D,H
	LD	E,L
	INC	DE
	LD	(HL),0
	POP	BC
	LDIR
	RET
	
	
; **	MUSIC START	**
	
;	IN: (MU_NUM)<= MUSIC NUMBER (0-3)
	
M_ST:
	DI
	POP	HL		; TEXT POINTER
	CALL	REDATA
	JR	C,MSTART2
	PUSH	HL
	LD	A,E
	OR	A
	JR	NZ,MAKEWORK
	POP	HL
MSTART2:
	PUSH	HL
	LD	A,1
MAKEWORK:
	DEC	A
	CALL	MSTART
	CALL	REDOF
	CALL	ROM
	CALL	T_RST		; RESET TIME
	POP	HL
	RET
REDOF:
	XOR A
	LD	(ESCAPE),A	; ESC�� ���ޮ
	CALL	INFADR
	LD	(IX+2),1
	RET
	
; **	�ݼ�� ¸�	**
	
VICMKE:
	DI
	CALL	RAM
	LD 	HL,NEXTPT
	LD 	BC,6
	CALL	MEMCLR
	LD	HL,DEFVOICE
	LD	(VICAD2),HL
	
	LD 	HL,1
	
VICMK1:	LD 	E,(HL)
	INC	HL
	LD	D,(HL)		; DE = LINK POINTER
	INC 	HL
	LD 	A,D
	OR	E		; BASICEND ?
	JP 	Z,VICMK2
	
	LD 	C,(HL)
	INC 	HL
	LD 	B,(HL)		; BC = LINE NUMBER
	LD	(LINENM),BC
	EX 	DE,HL
	JP 	VICMK1
	
VICMK2:	CALL 	SCHVIC		; ��ò�� ��ɶ�ަ ���
	LD 	A,(VICNUM)
	OR 	A
	JP 	Z,VICEXT
	
	LD 	B,A
	
VICMK4:	PUSH 	BC
	LD 	B,8
	CALL 	VICPRT
	LD	(NEXTVL),HL
	
VICMK3:	PUSH 	BC
	LD 	(NEXTPT),HL
	LD	DE,(LINENM)
	LD 	A,10
	ADD 	A,E
	LD	E,A
	ADC 	A,D
	SUB	E
	LD	D,A
	LD 	(LINENM),DE
	LD      (HL),E		;
	INC 	HL		; DE = LINE NUMBER
	LD 	(HL),D		;
	INC	HL
	EX 	DE,HL
	LD 	HL,LNKTXT
	LD 	BC,5
	LDIR
	EX 	DE,HL
	LD 	BC,19
	
	PUSH	DE
	LD	E,L
	LD	D,H
	INC	DE
	LD	(HL),20H
	LDIR		;SKIP&CLEAR
	POP	DE
	
	LD 	(HL),0		; LINE END MARK
	INC	HL
	EX 	DE,HL
	LD	HL,(NEXTPT)
	DEC 	HL
	LD 	(HL),D		;
	DEC 	HL		; SAVE NEW LINK PT
	LD	(HL),E		;
	EX 	DE,HL
	INC 	HL
	INC	HL
	POP 	BC
	DJNZ	VICMK3
	
	EX	DE,HL
	PUSH 	HL
	CALL 	SETVIC
	POP	HL
	INC 	HL
	INC 	HL
	
	POP 	BC
	DJNZ    VICMK4
	
	DEC 	HL
	LD	(HL),0		;
	DEC     HL		; BASIC END MARK
	LD	(HL),0		;
	INC	HL
	INC 	HL
	INC 	HL
	LD 	(0EB18H),HL
	
VICEXT:
	CALL	ROM
	POP 	HL
	RET
	
SCHVIC:	PUSH 	HL
	LD	HL,DEFVOICE
	LD	BC,32*256
	
SCHVI2:	LD	A,(HL)
	OR 	A
	JR	Z,SCHVI3
	
	INC  	C
	LD 	A,C
	LD	(VICNUM),A
	INC 	HL
	
	DJNZ    SCHVI2
SCHVI3:
	POP 	HL
	RET
	
; **	÷�� � �ݼ�����	**
	
SETVIC:	LD 	HL,(NEXTVL)
	DEC	HL
	DEC	HL		; HL=LINK PT TOP ADR
	PUSH 	BC
	
	
 	LD 	B,6		; �� 7 ����
SETVI0:
	PUSH 	BC
	PUSH	HL
	LD	DE,9
	ADD 	HL,DE		; SKIP
	EX 	DE,HL
	CALL 	SETVI1
	POP 	HL
	
	LD 	BC,29
	ADD     HL,BC
	POP 	BC
	DJNZ    SETVI0
	
	LD	DE,9
	ADD	HL,DE
	EX	DE,HL
	LD	A,1
	LD	(SETVI1+1),A
	CALL	SETVI1
	LD	A,4
	LD	(SETVI1+1),A
	
	POP 	BC
	RET
	
SETVI1:
	LD 	B,4		; ֺ 4
	LD 	HL,(VICADR)
SETVI2:
	PUSH 	BC
	PUSH 	HL
	PUSH 	DE
	LD 	L,(HL)
	LD 	H,0
	CALL 	HEXPRT
	POP 	DE
	
	LD	A,'$'
	LD	(DE),A
	INC	DE
	
	LD 	HL,MOJIBUF+1
	LD 	BC,3
	LDIR
	
	POP 	HL
	INC 	HL
	POP 	BC
	LD 	A,1
	CP	B
	JR 	Z,SETVI3
	
	LD 	A,','
	LD 	(DE),A
	INC 	DE
SETVI3:
	DJNZ 	SETVI2
	LD      (VICADR),HL
	RET
	
VICPRT:
	PUSH 	BC
	PUSH 	HL
	
	LD	DE,(LINENM)
	LD 	A,10
	ADD 	A,E
	LD	E,A
	ADC 	A,D
	SUB	E
	LD	D,A
	LD 	(LINENM),DE
	
	LD      (HL),E		;
	INC 	HL		; DE = LINE NUMBER
	LD 	(HL),D		;
	INC 	HL
	
	EX 	DE,HL
	LD 	HL,LNKTXT
	LD 	BC,5
	LDIR
	
	LD 	A,'@'
	LD 	(DE),A
	INC 	DE
	LD	A,'%'
	LD	(DE),A
	INC	DE
	LD 	HL,(VICAD2)
	LD 	A,(HL)
	INC 	HL
	LD	(VICAD2),HL
	DEC	A
	PUSH	AF
	LD	L,A
	LD	H,0
	PUSH	DE
	CALL	HEXDEC
	INC	HL
	INC	HL
	POP	DE
	LD	BC,3
	LDIR
	LD	A,';'
	LD	(DE),A
	INC	DE
	POP	AF
	CALL	GETADR
	LD	BC,32-6
	ADD	HL,BC
	LD	BC,6
	LDIR
	
	XOR 	A
	LD	(DE),A		; SET LINE END MARK
	INC 	DE
	POP 	HL
	DEC	HL
	LD	(HL),D
	DEC 	HL
	LD	(HL),E
	
	LD	DE,24
	ADD	HL,DE
	
	POP 	BC
	RET
	
NEXTPT:	DW 	0
NEXTVL:	DW	0
LINENM:	DW      0
VICNUM:	DB	0
VICADR:	DW	0E300H
VICAD2:	DW	DEFVOICE
LNKTXT:	DB	3AH,8FH,0E9H,20H,20H	; 5 �
	
; **	SYSTEM WORK AREA	**
	
MACFG:	DB	0	;0>< AS MACRO PRC
;MESS:	DB	'[  MUSICLALF Ver:1.1 ] Address'		;���C���O
MESS:	DB	'[  MUSICLALF Ver:1.0 ] Address'		;���C����
	DB	':    -    (    )         [ 00:00 ] MODE:'
MESNML:	DB	'NORMAL  '
	DB	'LINC    '
	DB	'EXPERT  '
MESNOT:	DB	'----'
VNMESS:	DB	0AH,'Used FM voice:',0
TCMESS:	DB	0AH,'[ Total count ]',0AH,0
LCMESS:	DB	0AH,'[ Loop count  ]',0AH,0
ADMES:	DB	0AH,'Voice added: +',0
JPLMES:	DB	'Jumping to linenumber   >'
DEBFLG:
	DB	0FFH
LINCFG:	DB	0
MAXCH:
	DB	11,0
MAXCH_MULT4:
	DB	11*4,0	; MAXCH*4
IFGM:	DB	'>) as UP,<( as DOWN',0
IFGM2:	DB	'>) as DOWN,<( as UP',0
LFODAT:	DB	1,0,0,0,0,0,0
ADRSTC:	DW	0
VPCO:	DB	0
UDFLG:	DB	0
PSGMD:	DB	0
