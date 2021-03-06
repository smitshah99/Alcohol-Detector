ORG 0x00
	
MOV R1, #38H
CALL COMMAND
MOV R1, #0EH
CALL COMMAND
MOV R1, #06H
CALL COMMAND
MOV R1, #01H
CALL COMMAND

START:
CLR P3.5
NOP
SETB P3.5

WAIT:
JB P3.2, WAIT
ACALL READ
ACALL CONVERSION

CALL DATA2
CALL DATA1

CALL EPR
CALL DELAY 
MOV R1, #01H
CALL COMMAND
CALL DELAY
JMP START

READ:
CLR P3.4
MOV A, P2
MOV 30H,A
SETB P3.4
RET

DELAY:
MOV R1, #255
L2: MOV R1, #255
L1: DJNZ R0, L1
DJNZ R1,L2
RET

COMMAND:
CLR P1.2
MOV P0,R1
SETB P1.0
CALL DELAY
CLR P1.0
RET

DATA2:
SETB P1.2
MOV P0,R4
SETB P1.0
CALL DELAY
CLR P1.0
RET

DATA1:
SETB P1.2
MOV P0, R2
SETB P1.0
CALL DELAY
CLR P1.0
RET

EPR:
SETB P1.2
MOV P0, R2
SETB P1.0
CALL DELAY
CLR P1.0
RET

CONVERSION:
MOV B, #10
DIV AB
MOV R2,B
MOV B, #10
DIV AB
ORL A, #30H
MOV R3,A
MOV A, R2
ORL A,#30H
MOV R2,A
RET

END