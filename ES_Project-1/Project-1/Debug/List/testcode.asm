
;CodeVisionAVR C Compiler V3.52 
;(C) Copyright 1998-2023 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPMCSR=0x37
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.EQU __FLASH_PAGE_SIZE=0x40

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _i=R5
	.DEF __lcd_x=R4
	.DEF __lcd_y=R7
	.DEF __lcd_maxx=R6

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _Admin
	JMP  _Set_PC
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x0:
	.DB  0x50,0x72,0x65,0x73,0x73,0x20,0x2A,0x20
	.DB  0x74,0x6F,0x20,0x45,0x6E,0x74,0x65,0x72
	.DB  0xA,0x0,0x45,0x6E,0x74,0x65,0x72,0x20
	.DB  0x79,0x6F,0x75,0x72,0x20,0x49,0x44,0x3A
	.DB  0x20,0xA,0x0,0x45,0x6E,0x74,0x65,0x72
	.DB  0x20,0x79,0x6F,0x75,0x72,0x20,0x6F,0x6C
	.DB  0x64,0x20,0x70,0x61,0x73,0x73,0x63,0x6F
	.DB  0x64,0x65,0x3A,0x0,0x45,0x6E,0x74,0x65
	.DB  0x72,0x20,0x6E,0x65,0x77,0x20,0x70,0x61
	.DB  0x73,0x73,0x63,0x6F,0x64,0x65,0x3A,0x0
	.DB  0x52,0x65,0x2D,0x65,0x6E,0x74,0x65,0x72
	.DB  0x20,0x6E,0x65,0x77,0x20,0x70,0x61,0x73
	.DB  0x73,0x63,0x6F,0x64,0x65,0x3A,0x0,0x4E
	.DB  0x65,0x77,0x20,0x50,0x43,0x20,0x73,0x74
	.DB  0x6F,0x72,0x65,0x64,0x0,0x50,0x61,0x73
	.DB  0x73,0x63,0x6F,0x64,0x65,0x73,0x20,0x64
	.DB  0x6F,0x20,0x6E,0x6F,0x74,0x20,0x6D,0x61
	.DB  0x74,0x63,0x68,0x0,0x57,0x72,0x6F,0x6E
	.DB  0x67,0x20,0x6F,0x6C,0x64,0x20,0x70,0x61
	.DB  0x73,0x73,0x63,0x6F,0x64,0x65,0x0,0x57
	.DB  0x72,0x6F,0x6E,0x67,0x20,0x49,0x44,0x0
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x41,0x64
	.DB  0x6D,0x69,0x6E,0x20,0x50,0x43,0x3A,0xA
	.DB  0x0,0x45,0x6E,0x74,0x65,0x72,0x20,0x73
	.DB  0x74,0x75,0x64,0x65,0x6E,0x74,0x20,0x49
	.DB  0x44,0x3A,0x0,0x45,0x6E,0x74,0x65,0x72
	.DB  0x20,0x6E,0x65,0x77,0x20,0x50,0x43,0x3A
	.DB  0xA,0x0,0x50,0x43,0x20,0x69,0x73,0x20
	.DB  0x73,0x74,0x6F,0x72,0x65,0x64,0xA,0x0
	.DB  0x43,0x6F,0x6E,0x74,0x61,0x63,0x74,0x20
	.DB  0x41,0x64,0x6D,0x69,0x6E,0x0,0x50,0x72
	.DB  0x6F,0x66,0x0,0x41,0x68,0x6D,0x65,0x64
	.DB  0x0,0x41,0x6D,0x65,0x72,0x0,0x41,0x64
	.DB  0x65,0x6C,0x0,0x4F,0x6D,0x61,0x72,0x0
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x79,0x6F
	.DB  0x75,0x72,0x20,0x70,0x61,0x73,0x73,0x63
	.DB  0x6F,0x64,0x65,0x3A,0x0,0x57,0x65,0x6C
	.DB  0x63,0x6F,0x6D,0x65,0x2C,0x20,0x25,0x73
	.DB  0x0,0x53,0x6F,0x72,0x72,0x79,0x2C,0x20
	.DB  0x77,0x72,0x6F,0x6E,0x67,0x20,0x70,0x61
	.DB  0x73,0x73,0x63,0x6F,0x64,0x65,0x0
_0x2020003:
	.DB  0x80,0xC0
_0x2080060:
	.DB  0x1
_0x2080000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x12
	.DW  _0x3
	.DW  _0x0*2

	.DW  0x11
	.DW  _0x7
	.DW  _0x0*2+18

	.DW  0x19
	.DW  _0x7+17
	.DW  _0x0*2+35

	.DW  0x14
	.DW  _0x7+42
	.DW  _0x0*2+60

	.DW  0x17
	.DW  _0x7+62
	.DW  _0x0*2+80

	.DW  0x0E
	.DW  _0x7+85
	.DW  _0x0*2+103

	.DW  0x17
	.DW  _0x7+99
	.DW  _0x0*2+117

	.DW  0x13
	.DW  _0x7+122
	.DW  _0x0*2+140

	.DW  0x09
	.DW  _0x7+141
	.DW  _0x0*2+159

	.DW  0x11
	.DW  _0x32
	.DW  _0x0*2+168

	.DW  0x12
	.DW  _0x32+17
	.DW  _0x0*2+185

	.DW  0x0F
	.DW  _0x32+35
	.DW  _0x0*2+203

	.DW  0x0E
	.DW  _0x32+50
	.DW  _0x0*2+218

	.DW  0x0E
	.DW  _0x32+64
	.DW  _0x0*2+232

	.DW  0x0E
	.DW  _0x32+78
	.DW  _0x0*2+232

	.DW  0x05
	.DW  _0x61
	.DW  _0x0*2+246

	.DW  0x06
	.DW  _0x61+5
	.DW  _0x0*2+251

	.DW  0x05
	.DW  _0x61+11
	.DW  _0x0*2+257

	.DW  0x05
	.DW  _0x61+16
	.DW  _0x0*2+262

	.DW  0x05
	.DW  _0x61+21
	.DW  _0x0*2+267

	.DW  0x11
	.DW  _0x61+26
	.DW  _0x0*2+18

	.DW  0x15
	.DW  _0x61+43
	.DW  _0x0*2+272

	.DW  0x16
	.DW  _0x61+64
	.DW  _0x0*2+305

	.DW  0x09
	.DW  _0x61+86
	.DW  _0x0*2+159

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

	.DW  0x01
	.DW  __seed_G104
	.DW  _0x2080060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x160

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;char Keypad();
;void EE_Write(unsigned int address, unsigned char data);
;unsigned char EE_Read(unsigned int address);
;void initialize()
; 0000 002F {

	.CSEG
_initialize:
; .FSTART _initialize
; 0000 0030 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0031 lcd_puts("Press * to Enter\n");
	__POINTW2MN _0x3,0
	RCALL _lcd_puts
; 0000 0032 
; 0000 0033 }
	RET
; .FEND

	.DSEG
_0x3:
	.BYTE 0x12
;void enterStudentData(Student students[], unsigned char studentIndex, const char *name, unsigned int id, unsigned int passcode)
; 0000 0036 {

	.CSEG
_enterStudentData:
; .FSTART _enterStudentData
; 0000 0037 unsigned char j = 0;
; 0000 0038 strncpy(students[studentIndex].name, name, sizeof(students[studentIndex].name) - 1);
	RCALL __SAVELOCR6
	MOVW R18,R26
	__GETWRS 20,21,6
	LDD  R16,Y+10
;	students -> Y+11
;	studentIndex -> R16
;	*name -> Y+8
;	id -> R20,R21
;	passcode -> R18,R19
;	j -> R17
	LDI  R17,0
	RCALL SUBOPT_0x0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(5)
	RCALL _strncpy
; 0000 0039 students[studentIndex].name[sizeof(students[studentIndex].name) - 1] = '\0';  // Ensure null-termination
	RCALL SUBOPT_0x0
	ADIW R30,5
	LDI  R26,LOW(0)
	STD  Z+0,R26
; 0000 003A students[studentIndex].id = id;
	RCALL SUBOPT_0x0
	__PUTWZR 20,21,6
; 0000 003B students[studentIndex].passcode = passcode;
	RCALL SUBOPT_0x0
	__PUTWZR 18,19,8
; 0000 003C 
; 0000 003D // Store data into EEPROM for the current student
; 0000 003E EE_Write(studentIndex * sizeof(Student), students[studentIndex].id);
	LDI  R30,LOW(10)
	MUL  R30,R16
	ST   -Y,R1
	ST   -Y,R0
	RCALL SUBOPT_0x1
	ADD  R26,R30
	ADC  R27,R31
	ADIW R26,6
	LD   R26,X
	RCALL _EE_Write
; 0000 003F EE_Write(studentIndex * sizeof(Student) + 1, students[studentIndex].passcode);
	LDI  R30,LOW(10)
	MUL  R30,R16
	MOVW R30,R0
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x2
; 0000 0040 for (j = 0; j < sizeof(students[studentIndex].name); ++j)
	LDI  R17,LOW(0)
_0x5:
	CPI  R17,6
	BRSH _0x6
; 0000 0041 EE_Write(studentIndex * sizeof(Student) + 2 + j, students[studentIndex].name[j]);
	LDI  R30,LOW(10)
	MUL  R30,R16
	MOVW R30,R0
	ADIW R30,2
	MOVW R26,R30
	MOV  R30,R17
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x1
	ADD  R26,R30
	ADC  R27,R31
	CLR  R30
	ADD  R26,R17
	ADC  R27,R30
	LD   R26,X
	RCALL _EE_Write
	SUBI R17,-LOW(1)
	RJMP _0x5
_0x6:
; 0000 0042 }
	RCALL __LOADLOCR6
	ADIW R28,13
	RET
; .FEND
;void changePasscode(Student students[], unsigned char studentIndex)
; 0000 0048 {
_changePasscode:
; .FSTART _changePasscode
; 0000 0049 unsigned char i = 0;
; 0000 004A unsigned char j = 0;
; 0000 004B unsigned char k = 0;
; 0000 004C unsigned char l = 0;
; 0000 004D unsigned int enteredID;
; 0000 004E unsigned int enteredOldPasscode;
; 0000 004F unsigned int newPasscode1;
; 0000 0050 unsigned int newPasscode2;
; 0000 0051 char key;
; 0000 0052 
; 0000 0053 lcd_clear();
	ST   -Y,R26
	SBIW R28,7
	RCALL __SAVELOCR6
;	students -> Y+14
;	studentIndex -> Y+13
;	i -> R17
;	j -> R16
;	k -> R19
;	l -> R18
;	enteredID -> R20,R21
;	enteredOldPasscode -> Y+11
;	newPasscode1 -> Y+9
;	newPasscode2 -> Y+7
;	key -> Y+6
	LDI  R17,0
	LDI  R16,0
	LDI  R19,0
	LDI  R18,0
	RCALL _lcd_clear
; 0000 0054 lcd_puts("Enter your ID: \n");
	__POINTW2MN _0x7,0
	RCALL _lcd_puts
; 0000 0055 
; 0000 0056 // Read entered ID from keypad
; 0000 0057 enteredID = 0;
	__GETWRN 20,21,0
; 0000 0058 for ( i = 0; i < ID_DIGITS; ++i)
	LDI  R17,LOW(0)
_0x9:
	CPI  R17,3
	BRSH _0xA
; 0000 0059 {
; 0000 005A unsigned char digit = Keypad();
; 0000 005B lcd_putchar(digit);
	RCALL SUBOPT_0x3
;	students -> Y+15
;	studentIndex -> Y+14
;	enteredOldPasscode -> Y+12
;	newPasscode1 -> Y+10
;	newPasscode2 -> Y+8
;	key -> Y+7
;	digit -> Y+0
; 0000 005C delay_ms(200);
; 0000 005D enteredID = enteredID * 10 + (digit - '0');
; 0000 005E }
	SUBI R17,-LOW(1)
	RJMP _0x9
_0xA:
; 0000 005F 
; 0000 0060 // Check if the entered ID is stored
; 0000 0061 if (enteredID == students[studentIndex].id)
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x5
	CP   R30,R20
	CPC  R31,R21
	BREQ PC+2
	RJMP _0xB
; 0000 0062 {
; 0000 0063 lcd_clear();
	RCALL _lcd_clear
; 0000 0064 lcd_puts("Enter your old passcode:");
	__POINTW2MN _0x7,17
	RCALL _lcd_puts
; 0000 0065 
; 0000 0066 // Read entered old passcode from keypad
; 0000 0067 enteredOldPasscode = 0;
	LDI  R30,LOW(0)
	STD  Y+11,R30
	STD  Y+11+1,R30
; 0000 0068 for ( j = 0; j < PASSCODE_DIGITS; ++j)
	LDI  R16,LOW(0)
_0xD:
	CPI  R16,3
	BRSH _0xE
; 0000 0069 {
; 0000 006A key = Keypad();
	RCALL _Keypad
	STD  Y+6,R30
; 0000 006B enteredOldPasscode = enteredOldPasscode * 10 + (key - '0');
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	RCALL SUBOPT_0x6
	STD  Y+11,R30
	STD  Y+11+1,R31
; 0000 006C lcd_putchar('*');
	RCALL SUBOPT_0x7
; 0000 006D delay_ms(200);
; 0000 006E }
	SUBI R16,-LOW(1)
	RJMP _0xD
_0xE:
; 0000 006F 
; 0000 0070 // Check if the entered old passcode is correct
; 0000 0071 if (enteredOldPasscode == students[studentIndex].passcode)
	RCALL SUBOPT_0x4
	ADD  R26,R30
	ADC  R27,R31
	ADIW R26,8
	LD   R30,X+
	LD   R31,X+
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CP   R30,R26
	CPC  R31,R27
	BREQ PC+2
	RJMP _0xF
; 0000 0072 {
; 0000 0073 lcd_clear();
	RCALL _lcd_clear
; 0000 0074 lcd_puts("Enter new passcode:");
	__POINTW2MN _0x7,42
	RCALL _lcd_puts
; 0000 0075 
; 0000 0076 // Read new passcode
; 0000 0077 newPasscode1 = 0;
	LDI  R30,LOW(0)
	STD  Y+9,R30
	STD  Y+9+1,R30
; 0000 0078 for (k = 0; k < PASSCODE_DIGITS; ++k)
	LDI  R19,LOW(0)
_0x11:
	CPI  R19,3
	BRSH _0x12
; 0000 0079 {
; 0000 007A key = Keypad();
	RCALL _Keypad
	STD  Y+6,R30
; 0000 007B newPasscode1 = newPasscode1 * 10 + (key - '0');
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	RCALL SUBOPT_0x6
	STD  Y+9,R30
	STD  Y+9+1,R31
; 0000 007C lcd_putchar('*');
	RCALL SUBOPT_0x7
; 0000 007D delay_ms(200);
; 0000 007E }
	SUBI R19,-LOW(1)
	RJMP _0x11
_0x12:
; 0000 007F 
; 0000 0080 lcd_clear();
	RCALL _lcd_clear
; 0000 0081 lcd_puts("Re-enter new passcode:");
	__POINTW2MN _0x7,62
	RCALL SUBOPT_0x8
; 0000 0082 
; 0000 0083 // Re-enter new passcode
; 0000 0084 newPasscode2 = 0;
; 0000 0085 for (l = 0; l < PASSCODE_DIGITS; ++l)
_0x14:
	CPI  R18,3
	BRSH _0x15
; 0000 0086 {
; 0000 0087 key = Keypad();
	RCALL SUBOPT_0x9
; 0000 0088 newPasscode2 = newPasscode2 * 10 + (key - '0');
	STD  Y+7,R30
	STD  Y+7+1,R31
; 0000 0089 lcd_putchar('*');
	RCALL SUBOPT_0x7
; 0000 008A delay_ms(200);
; 0000 008B }
	SUBI R18,-LOW(1)
	RJMP _0x14
_0x15:
; 0000 008C 
; 0000 008D // Check if the two entries are identical
; 0000 008E if (newPasscode1 == newPasscode2)
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x16
; 0000 008F {
; 0000 0090 // Update the passcode in memory and EEPROM
; 0000 0091 students[studentIndex].passcode = newPasscode1;
	LDD  R30,Y+13
	LDI  R31,0
	__GETWRS 22,23,14
	RCALL SUBOPT_0xA
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 0092 EE_Write(studentIndex * sizeof(Student) + 1, students[studentIndex].passcode);
	LDD  R26,Y+13
	RCALL SUBOPT_0xB
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+15
	LDI  R31,0
	__GETWRS 22,23,16
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0x2
; 0000 0093 
; 0000 0094 lcd_clear();
	RCALL _lcd_clear
; 0000 0095 lcd_puts("New PC stored");
	__POINTW2MN _0x7,85
	RCALL _lcd_puts
; 0000 0096 delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RJMP _0xE2
; 0000 0097 }
; 0000 0098 else
_0x16:
; 0000 0099 {
; 0000 009A // Two entries are not identical
; 0000 009B lcd_clear();
	RCALL _lcd_clear
; 0000 009C lcd_puts("Passcodes do not match");
	__POINTW2MN _0x7,99
	RCALL SUBOPT_0xD
; 0000 009D delay_ms(2000);
; 0000 009E // Generate two peep alarms
; 0000 009F PORTB.2 = 1;
; 0000 00A0 delay_ms(500);
; 0000 00A1 PORTB.2 = 0;
; 0000 00A2 delay_ms(500);
; 0000 00A3 PORTB.2 = 1;
; 0000 00A4 delay_ms(500);
; 0000 00A5 PORTB.2 = 0;
; 0000 00A6 delay_ms(500);
_0xE2:
	RCALL _delay_ms
; 0000 00A7 }
; 0000 00A8 }
; 0000 00A9 else
	RJMP _0x20
_0xF:
; 0000 00AA {
; 0000 00AB // Wrong old passcode
; 0000 00AC lcd_clear();
	RCALL _lcd_clear
; 0000 00AD lcd_puts("Wrong old passcode");
	__POINTW2MN _0x7,122
	RCALL SUBOPT_0xD
; 0000 00AE delay_ms(2000);
; 0000 00AF // Generate two peep alarms
; 0000 00B0 PORTB.2 = 1;
; 0000 00B1 delay_ms(500);
; 0000 00B2 PORTB.2 = 0;
; 0000 00B3 delay_ms(500);
; 0000 00B4 PORTB.2 = 1;
; 0000 00B5 delay_ms(500);
; 0000 00B6 PORTB.2 = 0;
; 0000 00B7 delay_ms(500);
	RCALL _delay_ms
; 0000 00B8 }
_0x20:
; 0000 00B9 }
; 0000 00BA else
	RJMP _0x29
_0xB:
; 0000 00BB {
; 0000 00BC // Wrong ID
; 0000 00BD lcd_clear();
	RCALL _lcd_clear
; 0000 00BE lcd_puts("Wrong ID");
	__POINTW2MN _0x7,141
	RCALL SUBOPT_0xE
; 0000 00BF // Generate two peep alarms
; 0000 00C0 PORTB.2 = 1;
; 0000 00C1 delay_ms(500);
; 0000 00C2 PORTB.2 = 0;
; 0000 00C3 delay_ms(500);
; 0000 00C4 PORTB.2 = 1;
; 0000 00C5 delay_ms(500);
; 0000 00C6 PORTB.2 = 0;
; 0000 00C7 delay_ms(500);
; 0000 00C8 }
_0x29:
; 0000 00C9 initialize();
	RCALL _initialize
; 0000 00CA }
	RCALL __LOADLOCR6
	ADIW R28,16
	RET
; .FEND

	.DSEG
_0x7:
	.BYTE 0x96
;void adminOperations(Student students[])
; 0000 00CD {

	.CSEG
_adminOperations:
; .FSTART _adminOperations
; 0000 00CE unsigned int enteredAdminPC;
; 0000 00CF unsigned char i, j;
; 0000 00D0 unsigned int reprogramStudentID;
; 0000 00D1 unsigned int newStudentPC;
; 0000 00D2 char key;
; 0000 00D3 
; 0000 00D4 lcd_clear();
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,3
	RCALL __SAVELOCR6
;	students -> Y+9
;	enteredAdminPC -> R16,R17
;	i -> R19
;	j -> R18
;	reprogramStudentID -> R20,R21
;	newStudentPC -> Y+7
;	key -> Y+6
	RCALL _lcd_clear
; 0000 00D5 lcd_puts("Enter Admin PC:\n");
	__POINTW2MN _0x32,0
	RCALL _lcd_puts
; 0000 00D6 
; 0000 00D7 // Read entered admin passcode from keypad
; 0000 00D8 enteredAdminPC = 0;
	__GETWRN 16,17,0
; 0000 00D9 for (j = 0; j < PASSCODE_DIGITS; ++j)
	LDI  R18,LOW(0)
_0x34:
	CPI  R18,3
	BRSH _0x35
; 0000 00DA {
; 0000 00DB key = Keypad();
	RCALL _Keypad
	STD  Y+6,R30
; 0000 00DC enteredAdminPC = enteredAdminPC * 10 + (key - '0');
	RCALL SUBOPT_0xF
	LDD  R30,Y+6
	RCALL SUBOPT_0x10
; 0000 00DD lcd_putchar('*');
	RCALL SUBOPT_0x7
; 0000 00DE delay_ms(200);
; 0000 00DF }
	SUBI R18,-LOW(1)
	RJMP _0x34
_0x35:
; 0000 00E0 
; 0000 00E1 // Check if the entered admin passcode is correct
; 0000 00E2 if (enteredAdminPC == ADMIN_PASSCODE)
	LDI  R30,LOW(123)
	LDI  R31,HIGH(123)
	CP   R30,R16
	CPC  R31,R17
	BREQ PC+2
	RJMP _0x36
; 0000 00E3 {
; 0000 00E4 lcd_clear();
	RCALL _lcd_clear
; 0000 00E5 lcd_puts("Enter student ID:");
	__POINTW2MN _0x32,17
	RCALL _lcd_puts
; 0000 00E6 
; 0000 00E7 // Read student ID for reprogramming
; 0000 00E8 reprogramStudentID = 0;
	__GETWRN 20,21,0
; 0000 00E9 for (j = 0; j < ID_DIGITS; ++j)
	LDI  R18,LOW(0)
_0x38:
	CPI  R18,3
	BRSH _0x39
; 0000 00EA {
; 0000 00EB unsigned char digit = Keypad();
; 0000 00EC lcd_putchar(digit);
	RCALL SUBOPT_0x3
;	students -> Y+10
;	newStudentPC -> Y+8
;	key -> Y+7
;	digit -> Y+0
; 0000 00ED delay_ms(200);
; 0000 00EE reprogramStudentID = reprogramStudentID * 10 + (digit - '0');
; 0000 00EF }
	SUBI R18,-LOW(1)
	RJMP _0x38
_0x39:
; 0000 00F0 
; 0000 00F1 // Find the student with the entered ID
; 0000 00F2 for (i = 0; i < MAX_STUDENTS; ++i)
	LDI  R19,LOW(0)
_0x3B:
	CPI  R19,5
	BRSH _0x3C
; 0000 00F3 {
; 0000 00F4 if (students[i].id == reprogramStudentID)
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0x5
	CP   R20,R30
	CPC  R21,R31
	BRNE _0x3D
; 0000 00F5 {
; 0000 00F6 lcd_clear();
	RCALL _lcd_clear
; 0000 00F7 lcd_puts("Enter new PC:\n");
	__POINTW2MN _0x32,35
	RCALL SUBOPT_0x8
; 0000 00F8 
; 0000 00F9 // Read new passcode for the student
; 0000 00FA newStudentPC = 0;
; 0000 00FB for (j = 0; j < PASSCODE_DIGITS; ++j)
_0x3F:
	CPI  R18,3
	BRSH _0x40
; 0000 00FC {
; 0000 00FD key = Keypad();
	RCALL SUBOPT_0x9
; 0000 00FE newStudentPC = newStudentPC * 10 + (key - '0');
	STD  Y+7,R30
	STD  Y+7+1,R31
; 0000 00FF lcd_putchar('*');
	RCALL SUBOPT_0x7
; 0000 0100 delay_ms(200);
; 0000 0101 }
	SUBI R18,-LOW(1)
	RJMP _0x3F
_0x40:
; 0000 0102 
; 0000 0103 // Update the passcode in memory
; 0000 0104 students[i].passcode = newStudentPC;
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0xA
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 0105 
; 0000 0106 // Update the passcode in EEPROM
; 0000 0107 EE_Write(i * sizeof(Student) + 1, students[i].passcode);
	LDI  R30,LOW(10)
	MUL  R30,R19
	MOVW R30,R0
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R19
	LDI  R31,0
	__GETWRS 22,23,11
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0x2
; 0000 0108 
; 0000 0109 lcd_clear();
	RCALL _lcd_clear
; 0000 010A lcd_puts("PC is stored\n");
	__POINTW2MN _0x32,50
	RCALL SUBOPT_0x12
; 0000 010B delay_ms(2000);
; 0000 010C 
; 0000 010D // Break out of the loop after reprogramming the student
; 0000 010E break;
	RJMP _0x3C
; 0000 010F }
; 0000 0110 }
_0x3D:
	SUBI R19,-LOW(1)
	RJMP _0x3B
_0x3C:
; 0000 0111 
; 0000 0112 // If the loop completes without finding the student
; 0000 0113 if (i == MAX_STUDENTS)
	CPI  R19,5
	BRNE _0x41
; 0000 0114 {
; 0000 0115 lcd_clear();
	RCALL _lcd_clear
; 0000 0116 lcd_puts("Contact Admin");
	__POINTW2MN _0x32,64
	RCALL SUBOPT_0xE
; 0000 0117 // Generate two peep alarms
; 0000 0118 PORTB.2 = 1;
; 0000 0119 delay_ms(500);
; 0000 011A PORTB.2 = 0;
; 0000 011B delay_ms(500);
; 0000 011C PORTB.2 = 1;
; 0000 011D delay_ms(500);
; 0000 011E PORTB.2 = 0;
; 0000 011F delay_ms(500);
; 0000 0120 
; 0000 0121 // Wait for a while
; 0000 0122 delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
; 0000 0123 }
; 0000 0124 }
_0x41:
; 0000 0125 else
	RJMP _0x4A
_0x36:
; 0000 0126 {
; 0000 0127 lcd_clear();
	RCALL _lcd_clear
; 0000 0128 lcd_puts("Contact Admin");
	__POINTW2MN _0x32,78
	RCALL SUBOPT_0xE
; 0000 0129 // Generate two peep alarms
; 0000 012A PORTB.2 = 1;
; 0000 012B delay_ms(500);
; 0000 012C PORTB.2 = 0;
; 0000 012D delay_ms(500);
; 0000 012E PORTB.2 = 1;
; 0000 012F delay_ms(500);
; 0000 0130 PORTB.2 = 0;
; 0000 0131 delay_ms(500);
; 0000 0132 
; 0000 0133 // Wait for a while
; 0000 0134 delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
; 0000 0135 }
_0x4A:
; 0000 0136 initialize();
	RCALL _initialize
; 0000 0137 }
	RCALL __LOADLOCR6
	ADIW R28,11
	RET
; .FEND

	.DSEG
_0x32:
	.BYTE 0x5C
;void main()
; 0000 013C {

	.CSEG
_main:
; .FSTART _main
; 0000 013D unsigned int enteredID;
; 0000 013E unsigned int enteredPasscode;
; 0000 013F char key;
; 0000 0140 
; 0000 0141 initialize();
;	enteredID -> R16,R17
;	enteredPasscode -> R18,R19
;	key -> R21
	RCALL _initialize
; 0000 0142 
; 0000 0143 DDRC = 0b00000111;
	LDI  R30,LOW(7)
	OUT  0x14,R30
; 0000 0144 PORTC = 0b11111000;
	LDI  R30,LOW(248)
	OUT  0x15,R30
; 0000 0145 DDRB.0 = 1; // PIN B.0 IS OUTPUT
	SBI  0x17,0
; 0000 0146 DDRB.1 = 1; // PIN B.1 IS OUTPUT
	SBI  0x17,1
; 0000 0147 DDRB.2 = 1; // PIN B.2 IS OUTPUT
	SBI  0x17,2
; 0000 0148 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0149 
; 0000 014A // INT0
; 0000 014B DDRD.2 = 0; // INPUT
	CBI  0x11,2
; 0000 014C PORTD.2 = 1; // PULL UP
	SBI  0x12,2
; 0000 014D bit_set(MCUCR, 1); // Falling Edga
	RCALL SUBOPT_0x13
; 0000 014E bit_clr(MCUCR, 0);
; 0000 014F SREG.7 = 1; // Enable Gloabal INT
; 0000 0150 bit_set(GICR, 6); // EXT0 Specific Enable
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 0151 
; 0000 0152 // INT1
; 0000 0153 DDRD.3 = 0; // INPUT
	CBI  0x11,3
; 0000 0154 PORTD.3 = 1; // PULL UP
	SBI  0x12,3
; 0000 0155 bit_set(MCUCR, 1); // Falling Edga
	RCALL SUBOPT_0x13
; 0000 0156 bit_clr(MCUCR, 0);
; 0000 0157 SREG.7 = 1; // Enable Gloabal INT
; 0000 0158 bit_set(GICR, 7); // EXT0 Specific Enable
	ORI  R30,0x80
	OUT  0x3B,R30
; 0000 0159 
; 0000 015A // Enter data for multiple students
; 0000 015B enterStudentData(students, 0, "Prof", 111, 123);
	RCALL SUBOPT_0x14
	LDI  R30,LOW(0)
	ST   -Y,R30
	__POINTW1MN _0x61,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(111)
	LDI  R31,HIGH(111)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(123)
	LDI  R27,0
	RCALL _enterStudentData
; 0000 015C enterStudentData(students, 1, "Ahmed", 126, 129);
	RCALL SUBOPT_0x14
	LDI  R30,LOW(1)
	ST   -Y,R30
	__POINTW1MN _0x61,5
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(126)
	LDI  R31,HIGH(126)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(129)
	LDI  R27,0
	RCALL _enterStudentData
; 0000 015D enterStudentData(students, 2, "Amer", 128, 125);
	RCALL SUBOPT_0x14
	LDI  R30,LOW(2)
	ST   -Y,R30
	__POINTW1MN _0x61,11
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(125)
	LDI  R27,0
	RCALL _enterStudentData
; 0000 015E enterStudentData(students, 3, "Adel", 130, 226);
	RCALL SUBOPT_0x14
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW1MN _0x61,16
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(130)
	LDI  R31,HIGH(130)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(226)
	LDI  R27,0
	RCALL _enterStudentData
; 0000 015F enterStudentData(students, 4, "Omar", 132, 179);
	RCALL SUBOPT_0x14
	LDI  R30,LOW(4)
	ST   -Y,R30
	__POINTW1MN _0x61,21
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(132)
	LDI  R31,HIGH(132)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(179)
	LDI  R27,0
	RCALL _enterStudentData
; 0000 0160 
; 0000 0161 while (1)
_0x62:
; 0000 0162 {
; 0000 0163 unsigned char j = 0;
; 0000 0164 unsigned int storedPasscode;
; 0000 0165 
; 0000 0166 initialize();
	SBIW R28,3
	LDI  R30,LOW(0)
	STD  Y+2,R30
;	j -> Y+2
;	storedPasscode -> Y+0
	RCALL _initialize
; 0000 0167 
; 0000 0168 key = Keypad();
	RCALL _Keypad
	MOV  R21,R30
; 0000 0169 if (key == '*')
	CPI  R21,42
	BREQ PC+2
	RJMP _0x65
; 0000 016A {
; 0000 016B lcd_clear();
	RCALL _lcd_clear
; 0000 016C lcd_puts("Enter your ID: \n");
	__POINTW2MN _0x61,26
	RCALL _lcd_puts
; 0000 016D 
; 0000 016E // Read entered ID from keypad
; 0000 016F enteredID = 0;
	__GETWRN 16,17,0
; 0000 0170 for (i = 0; i < ID_DIGITS; ++i)
	CLR  R5
_0x67:
	LDI  R30,LOW(3)
	CP   R5,R30
	BRSH _0x68
; 0000 0171 {
; 0000 0172 unsigned char digit = Keypad();
; 0000 0173 lcd_putchar(digit);
	SBIW R28,1
;	j -> Y+3
;	storedPasscode -> Y+1
;	digit -> Y+0
	RCALL _Keypad
	ST   Y,R30
	LD   R26,Y
	RCALL _lcd_putchar
; 0000 0174 delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0175 enteredID = enteredID * 10 + (digit - '0');
	RCALL SUBOPT_0xF
	LD   R30,Y
	RCALL SUBOPT_0x10
; 0000 0176 }
	ADIW R28,1
	INC  R5
	RJMP _0x67
_0x68:
; 0000 0177 
; 0000 0178 // Check if the entered ID is stored
; 0000 0179 for (i = 0; i < MAX_STUDENTS; ++i)
	CLR  R5
_0x6A:
	LDI  R30,LOW(5)
	CP   R5,R30
	BRLO PC+2
	RJMP _0x6B
; 0000 017A {
; 0000 017B unsigned int storedID = EE_Read(i * sizeof(Student));
; 0000 017C 
; 0000 017D if (enteredID == storedID)
	SBIW R28,2
;	j -> Y+4
;	storedPasscode -> Y+2
;	storedID -> Y+0
	MOV  R26,R5
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOVW R26,R30
	RCALL _EE_Read
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
	CP   R30,R16
	CPC  R31,R17
	BREQ PC+2
	RJMP _0x6C
; 0000 017E {
; 0000 017F lcd_clear();
	RCALL _lcd_clear
; 0000 0180 lcd_puts("Enter your passcode:");
	__POINTW2MN _0x61,43
	RCALL _lcd_puts
; 0000 0181 
; 0000 0182 // Read entered passcode from keypad
; 0000 0183 enteredPasscode = 0;
	__GETWRN 18,19,0
; 0000 0184 for (j = 0; j < PASSCODE_DIGITS; ++j)
	LDI  R30,LOW(0)
	STD  Y+4,R30
_0x6E:
	LDD  R26,Y+4
	CPI  R26,LOW(0x3)
	BRSH _0x6F
; 0000 0185 {
; 0000 0186 key = Keypad();
	RCALL _Keypad
	MOV  R21,R30
; 0000 0187 enteredPasscode = enteredPasscode * 10 + (key - '0');
	__MULBNWRU 18,19,10
	MOVW R26,R30
	MOV  R30,R21
	LDI  R31,0
	SBIW R30,48
	ADD  R30,R26
	ADC  R31,R27
	MOVW R18,R30
; 0000 0188 lcd_putchar('*');
	RCALL SUBOPT_0x7
; 0000 0189 delay_ms(200);
; 0000 018A }
	LDD  R30,Y+4
	SUBI R30,-LOW(1)
	STD  Y+4,R30
	RJMP _0x6E
_0x6F:
; 0000 018B 
; 0000 018C // Check if the entered passcode is correct
; 0000 018D storedPasscode = EE_Read(i * sizeof(Student) + 1);
	MOV  R26,R5
	RCALL SUBOPT_0xB
	MOVW R26,R30
	RCALL _EE_Read
	LDI  R31,0
	STD  Y+2,R30
	STD  Y+2+1,R31
; 0000 018E if (enteredPasscode == storedPasscode)
	CP   R30,R18
	CPC  R31,R19
	BRNE _0x70
; 0000 018F {
; 0000 0190 lcd_clear();
	RCALL _lcd_clear
; 0000 0191 lcd_printf("Welcome, %s", students[i].name);
	__POINTW1FN _0x0,293
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R5
	LDI  R26,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_students)
	SBCI R31,HIGH(-_students)
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _lcd_printf
	ADIW R28,6
; 0000 0192 delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
; 0000 0193 PORTB.0 = 1;
	SBI  0x18,0
; 0000 0194 PORTB.1 = 1;
	SBI  0x18,1
; 0000 0195 delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
; 0000 0196 PORTB.0 = 0;
	CBI  0x18,0
; 0000 0197 PORTB.1 = 0;
	CBI  0x18,1
; 0000 0198 // Additional actions when access is granted
; 0000 0199 }
; 0000 019A else
	RJMP _0x79
_0x70:
; 0000 019B {
; 0000 019C lcd_clear();
	RCALL _lcd_clear
; 0000 019D lcd_puts("Sorry, wrong passcode");
	__POINTW2MN _0x61,64
	RCALL SUBOPT_0x12
; 0000 019E delay_ms(2000);
; 0000 019F // Generate one peep alarm
; 0000 01A0 PORTB.2 = 1;
	SBI  0x18,2
; 0000 01A1 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 01A2 PORTB.2 = 0;
	CBI  0x18,2
; 0000 01A3 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 01A4 
; 0000 01A5 // Wait for a while
; 0000 01A6 delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
; 0000 01A7 }
_0x79:
; 0000 01A8 
; 0000 01A9 // Break out of the loop after finding the student
; 0000 01AA break;
	ADIW R28,2
	RJMP _0x6B
; 0000 01AB }
; 0000 01AC }
_0x6C:
	ADIW R28,2
	INC  R5
	RJMP _0x6A
_0x6B:
; 0000 01AD 
; 0000 01AE // If the loop completes without finding the student
; 0000 01AF if (i == MAX_STUDENTS)
	LDI  R30,LOW(5)
	CP   R30,R5
	BRNE _0x7E
; 0000 01B0 {
; 0000 01B1 lcd_clear();
	RCALL _lcd_clear
; 0000 01B2 lcd_puts("Wrong ID");
	__POINTW2MN _0x61,86
	RCALL SUBOPT_0xE
; 0000 01B3 // Generate two peep alarms
; 0000 01B4 PORTB.2 = 1;
; 0000 01B5 delay_ms(500);
; 0000 01B6 PORTB.2 = 0;
; 0000 01B7 delay_ms(500);
; 0000 01B8 PORTB.2 = 1;
; 0000 01B9 delay_ms(500);
; 0000 01BA PORTB.2 = 0;
; 0000 01BB delay_ms(500);
; 0000 01BC 
; 0000 01BD // Wait for a while
; 0000 01BE delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01BF }
; 0000 01C0 
; 0000 01C1 // Clear entered data for the next attempt
; 0000 01C2 initialize();
_0x7E:
	RCALL _initialize
; 0000 01C3 }
; 0000 01C4 
; 0000 01C5 }
_0x65:
	ADIW R28,3
	RJMP _0x62
; 0000 01C6 
; 0000 01C7 }
_0x87:
	RJMP _0x87
; .FEND

	.DSEG
_0x61:
	.BYTE 0x5F
;interrupt [2]void Admin (void)
; 0000 01CA {

	.CSEG
_Admin:
; .FSTART _Admin
	RCALL SUBOPT_0x15
; 0000 01CB adminOperations(students);
	LDI  R26,LOW(_students)
	LDI  R27,HIGH(_students)
	RCALL _adminOperations
; 0000 01CC 
; 0000 01CD }
	RJMP _0xE3
; .FEND
;interrupt [3]void Set_PC (void)
; 0000 01D0 {
_Set_PC:
; .FSTART _Set_PC
	RCALL SUBOPT_0x15
; 0000 01D1 changePasscode(students, i);
	RCALL SUBOPT_0x14
	MOV  R26,R5
	RCALL _changePasscode
; 0000 01D2 
; 0000 01D3 }
_0xE3:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;void EE_Write(unsigned int address, unsigned char data)
; 0000 01D8 {
_EE_Write:
; .FSTART _EE_Write
; 0000 01D9 while (EECR.1 == 1)
	RCALL __SAVELOCR4
	MOV  R17,R26
	__GETWRS 18,19,4
;	address -> R18,R19
;	data -> R17
_0x88:
	SBIC 0x1C,1
; 0000 01DA ; // wait until EEWE = 0
	RJMP _0x88
; 0000 01DB EEAR = address;
	__OUTWR 18,19,30
; 0000 01DC EEDR = data;
	OUT  0x1D,R17
; 0000 01DD EECR.2 = 1; // EEMRE
	SBI  0x1C,2
; 0000 01DE EECR.1 = 1; // EEWE
	SBI  0x1C,1
; 0000 01DF }
	RCALL __LOADLOCR4
	ADIW R28,6
	RET
; .FEND
;unsigned char EE_Read(unsigned int address)
; 0000 01E3 {
_EE_Read:
; .FSTART _EE_Read
; 0000 01E4 while (EECR.1 == 1)
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	address -> R16,R17
_0x8F:
	SBIC 0x1C,1
; 0000 01E5 ; // wait until EEWE = 0
	RJMP _0x8F
; 0000 01E6 EEAR = address;
	__OUTWR 16,17,30
; 0000 01E7 EECR.0 = 1; // EERE
	SBI  0x1C,0
; 0000 01E8 return EEDR;
	IN   R30,0x1D
	LD   R16,Y+
	LD   R17,Y+
	RET
; 0000 01E9 }
; .FEND
;char Keypad()
; 0000 01EC {
_Keypad:
; .FSTART _Keypad
; 0000 01ED while (1)
_0x94:
; 0000 01EE {
; 0000 01EF PORTC.0 = 0; // col 1 is active
	CBI  0x15,0
; 0000 01F0 PORTC.1 = 1; // col 2 is inactive
	SBI  0x15,1
; 0000 01F1 PORTC.2 = 1; // col 3 is inactive
	SBI  0x15,2
; 0000 01F2 switch (PINC)
	IN   R30,0x13
; 0000 01F3 {
; 0000 01F4 case 0b11110110:
	CPI  R30,LOW(0xF6)
	BRNE _0xA0
; 0000 01F5 while (PINC.3 == 0);
_0xA1:
	SBIS 0x13,3
	RJMP _0xA1
; 0000 01F6 return '1';
	LDI  R30,LOW(49)
	RET
; 0000 01F7 break;
	RJMP _0x9F
; 0000 01F8 
; 0000 01F9 case 0b11101110:
_0xA0:
	CPI  R30,LOW(0xEE)
	BRNE _0xA4
; 0000 01FA while (PINC.4 == 0);
_0xA5:
	SBIS 0x13,4
	RJMP _0xA5
; 0000 01FB return '4';
	LDI  R30,LOW(52)
	RET
; 0000 01FC break;
	RJMP _0x9F
; 0000 01FD 
; 0000 01FE case 0b11011110:
_0xA4:
	CPI  R30,LOW(0xDE)
	BRNE _0xA8
; 0000 01FF while (PINC.5 == 0);
_0xA9:
	SBIS 0x13,5
	RJMP _0xA9
; 0000 0200 return '7';
	LDI  R30,LOW(55)
	RET
; 0000 0201 break;
	RJMP _0x9F
; 0000 0202 
; 0000 0203 case 0b10111110:
_0xA8:
	CPI  R30,LOW(0xBE)
	BRNE _0x9F
; 0000 0204 while (PINC.6 == 0);
_0xAD:
	SBIS 0x13,6
	RJMP _0xAD
; 0000 0205 return '*';
	LDI  R30,LOW(42)
	RET
; 0000 0206 break;
; 0000 0207 }
_0x9F:
; 0000 0208 
; 0000 0209 PORTC.0 = 1; // col 1 is inactive
	SBI  0x15,0
; 0000 020A PORTC.1 = 0; // col 2 is active
	CBI  0x15,1
; 0000 020B PORTC.2 = 1; // col 3 is inactive
	SBI  0x15,2
; 0000 020C switch (PINC)
	IN   R30,0x13
; 0000 020D {
; 0000 020E case 0b11110101:
	CPI  R30,LOW(0xF5)
	BRNE _0xB9
; 0000 020F while (PINC.3 == 0);
_0xBA:
	SBIS 0x13,3
	RJMP _0xBA
; 0000 0210 return '2';
	LDI  R30,LOW(50)
	RET
; 0000 0211 break;
	RJMP _0xB8
; 0000 0212 
; 0000 0213 case 0b11101101:
_0xB9:
	CPI  R30,LOW(0xED)
	BRNE _0xBD
; 0000 0214 while (PINC.4 == 0);
_0xBE:
	SBIS 0x13,4
	RJMP _0xBE
; 0000 0215 return '5';
	LDI  R30,LOW(53)
	RET
; 0000 0216 break;
	RJMP _0xB8
; 0000 0217 
; 0000 0218 case 0b11011101:
_0xBD:
	CPI  R30,LOW(0xDD)
	BRNE _0xC1
; 0000 0219 while (PINC.5 == 0);
_0xC2:
	SBIS 0x13,5
	RJMP _0xC2
; 0000 021A return '8';
	LDI  R30,LOW(56)
	RET
; 0000 021B break;
	RJMP _0xB8
; 0000 021C 
; 0000 021D case 0b10111101:
_0xC1:
	CPI  R30,LOW(0xBD)
	BRNE _0xB8
; 0000 021E while (PINC.6 == 0);
_0xC6:
	SBIS 0x13,6
	RJMP _0xC6
; 0000 021F return '0';
	LDI  R30,LOW(48)
	RET
; 0000 0220 break;
; 0000 0221 }
_0xB8:
; 0000 0222 
; 0000 0223 PORTC.0 = 1; // col 1 is inactive
	SBI  0x15,0
; 0000 0224 PORTC.1 = 1; // col 2 is inactive
	SBI  0x15,1
; 0000 0225 PORTC.2 = 0; // col 3 is active
	CBI  0x15,2
; 0000 0226 switch (PINC)
	IN   R30,0x13
; 0000 0227 {
; 0000 0228 case 0b11110011:
	CPI  R30,LOW(0xF3)
	BRNE _0xD2
; 0000 0229 while (PINC.3 == 0);
_0xD3:
	SBIS 0x13,3
	RJMP _0xD3
; 0000 022A return '3';
	LDI  R30,LOW(51)
	RET
; 0000 022B break;
	RJMP _0xD1
; 0000 022C 
; 0000 022D case 0b11101011:
_0xD2:
	CPI  R30,LOW(0xEB)
	BRNE _0xD6
; 0000 022E while (PINC.4 == 0);
_0xD7:
	SBIS 0x13,4
	RJMP _0xD7
; 0000 022F return '6';
	LDI  R30,LOW(54)
	RET
; 0000 0230 break;
	RJMP _0xD1
; 0000 0231 
; 0000 0232 case 0b11011011:
_0xD6:
	CPI  R30,LOW(0xDB)
	BRNE _0xDA
; 0000 0233 while (PINC.5 == 0);
_0xDB:
	SBIS 0x13,5
	RJMP _0xDB
; 0000 0234 return '9';
	LDI  R30,LOW(57)
	RET
; 0000 0235 break;
	RJMP _0xD1
; 0000 0236 
; 0000 0237 case 0b110111011:
_0xDA:
	CPI  R30,LOW(0x1BB)
	BRNE _0xD1
; 0000 0238 while (PINC.6 == 0);
_0xDF:
	SBIS 0x13,6
	RJMP _0xDF
; 0000 0239 return '#';
	LDI  R30,LOW(35)
	RET
; 0000 023A break;
; 0000 023B }
_0xD1:
; 0000 023C }
	RJMP _0x94
; 0000 023D }
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	RCALL SUBOPT_0x16
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	RCALL SUBOPT_0x16
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	RCALL SUBOPT_0x17
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x18
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	RCALL SUBOPT_0x17
	RCALL SUBOPT_0x19
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	RCALL SUBOPT_0x17
	RCALL SUBOPT_0x19
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	RCALL SUBOPT_0x17
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	RCALL SUBOPT_0x17
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	__GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	RCALL SUBOPT_0x16
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	RCALL SUBOPT_0x16
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0x18
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	RCALL SUBOPT_0x16
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x18
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X+
	LD   R31,X+
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_put_lcd_G100:
; .FSTART _put_lcd_G100
	RCALL __SAVELOCR4
	MOVW R16,R26
	LDD  R19,Y+4
	MOV  R26,R19
	RCALL _lcd_putchar
	MOVW R26,R16
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RCALL __LOADLOCR4
	ADIW R28,5
	RET
; .FEND
_lcd_printf:
; .FSTART _lcd_printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	__ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	__ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_lcd_G100)
	LDI  R31,HIGH(_put_lcd_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G100
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x20E0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 133
	ADIW R28,1
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	ADD  R30,R16
	MOV  R26,R30
	RCALL __lcd_write_data
	MOV  R4,R16
	MOV  R7,R17
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x1A
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(0)
	MOV  R7,R30
	MOV  R4,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R17
	MOV  R17,R26
	CPI  R17,10
	BREQ _0x2020005
	CP   R4,R6
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R7
	MOV  R26,R7
	RCALL _lcd_gotoxy
	CPI  R17,10
	BREQ _0x20E0001
_0x2020004:
	INC  R4
	SBI  0x1B,0
	MOV  R26,R17
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x20E0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	RCALL __SAVELOCR4
	MOVW R18,R26
_0x2020008:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020008
_0x202000A:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	MOV  R6,R17
	MOV  R30,R17
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	MOV  R30,R17
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1B
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20E0001:
	LD   R17,Y+
	RET
; .FEND

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND
_strncpy:
; .FSTART _strncpy
	ST   -Y,R26
    ld   r23,y+
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strncpy0:
    tst  r23
    breq strncpy1
    dec  r23
    ld   r22,z+
    st   x+,r22
    tst  r22
    brne strncpy0
strncpy2:
    tst  r23
    breq strncpy1
    dec  r23
    st   x+,r22
    rjmp strncpy2
strncpy1:
    movw r30,r24
    ret
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_students:
	.BYTE 0x32
__base_y_G101:
	.BYTE 0x4
__seed_G104:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x0:
	MOV  R30,R16
	LDI  R31,0
	__GETWRS 22,23,11
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	RCALL __MULW12U
	ADD  R30,R22
	ADC  R31,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x1:
	MOV  R30,R16
	LDI  R31,0
	__GETWRS 22,23,13
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	RCALL __MULW12U
	MOVW R26,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2:
	ADD  R26,R30
	ADC  R27,R31
	ADIW R26,8
	LD   R26,X
	RJMP _EE_Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x3:
	SBIW R28,1
	RCALL _Keypad
	ST   Y,R30
	LD   R26,Y
	RCALL _lcd_putchar
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
	__MULBNWRU 20,21,10
	MOVW R26,R30
	LD   R30,Y
	LDI  R31,0
	SBIW R30,48
	ADD  R30,R26
	ADC  R31,R27
	MOVW R20,R30
	ADIW R28,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDD  R30,Y+13
	LDI  R31,0
	__GETWRS 22,23,14
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	RCALL __MULW12U
	MOVW R26,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	ADD  R26,R30
	ADC  R27,R31
	ADIW R26,6
	__GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(10)
	CALL __MULB1W2U
	MOVW R26,R30
	LDD  R30,Y+6
	LDI  R31,0
	SBIW R30,48
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x7:
	LDI  R26,LOW(42)
	RCALL _lcd_putchar
	LDI  R26,LOW(200)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	RCALL _lcd_puts
	LDI  R30,LOW(0)
	STD  Y+7,R30
	STD  Y+7+1,R30
	LDI  R18,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	RCALL _Keypad
	STD  Y+6,R30
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	RCALL __MULW12U
	ADD  R30,R22
	ADC  R31,R23
	ADIW R30,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC:
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	RCALL __MULW12U
	MOVW R26,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0xD:
	RCALL _lcd_puts
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
	SBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
	CBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
	SBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
	CBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:46 WORDS
SUBOPT_0xE:
	RCALL _lcd_puts
	SBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
	CBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
	SBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
	CBI  0x18,2
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	__MULBNWRU 16,17,10
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x10:
	LDI  R31,0
	SBIW R30,48
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	MOV  R30,R19
	LDI  R31,0
	__GETWRS 22,23,9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	RCALL _lcd_puts
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x13:
	IN   R30,0x35
	ORI  R30,2
	OUT  0x35,R30
	IN   R30,0x35
	ANDI R30,0xFE
	OUT  0x35,R30
	BSET 7
	IN   R30,0x3B
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x14:
	LDI  R30,LOW(_students)
	LDI  R31,HIGH(_students)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x15:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x16:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x17:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x18:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x19:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1B:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
