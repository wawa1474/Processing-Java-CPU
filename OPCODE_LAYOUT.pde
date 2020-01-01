/*
all values in binary unless stated otherwise
O = output register
A = 1st input register
B = 2nd input register
I = Immediate value
S = sign bit
M = minor addressing Mode
J = jump type
T = memory Type (main ram, video ram, stack, etc.)

set major Addressing Mode
AM = XXXX XXXX XXXI IIII

12
IMM  = IMMediate -------------------------------- (imm)
REG  = REGister --------------------------------- (reg[a])
IND  = INDirect --------------------------------- (mem[imm])
REL  = RELative --------------------------------- (PC + imm)
POP  = POP from stack --------------------------- (stack.pop())
REG  = REGister --------------------------------- (reg[a])
REGI = REGister + Imm --------------------------- (reg[a] + imm)
RGAI = ReGister AutoIncrement ------------------- (reg[a]) reg[a]++
RGAD = ReGister AutoDecrement ------------------- (reg[a]) reg[a]--
RGPI = ReGister Pre-Increment ------------------- (++reg[a]) (reg[a])
RGPD = ReGister Pre-Decrement ------------------- (--reg[a]) (reg[a])

12
IMM  = IMMediate -------------------------------- (imm)
REG  = REGister --------------------------------- (reg[a])
IMM  = IMMediate -------------------------------- (imm)
PCI  = PC + Imm --------------------------------- (PC + imm)
REG  = REGister --------------------------------- (reg[a])
REGI = REGister + Imm --------------------------- (reg[a] + imm)
RGRG = ReGister + ReGister ---------------------- (reg[a] + reg[b])
RGRGI= reg + reg + imm -------------------------- (reg[a] + reg[b] + imm)
RGI  = Register autoIncrement ------------------- (reg[a]) reg[a]++
RGD  = Register autoDeccrement ------------------ (reg[a]) reg[a]--
RGPI = Register Pre-Increment ------------------- (++reg[a]) (reg[a])
RGPD = Register Pre-Deccrement ------------------ (--reg[a]) (reg[a])

12
IMM  = IMMediate -------------------------------- (imm)
REG  = REGister --------------------------------- (reg[a])
ID   = InDirect --------------------------------- (mem[imm])
REL  = RELative --------------------------------- (mem[PC + imm])
RI   = Register Indirect ------------------------ (mem[reg[a]])
IN   = INdexed indirect ------------------------- (mem[reg[a] + imm])
INR  = INdexed Register indirect ---------------- (mem[reg[a] + reg[b]])
IRO  = Indexed Register Offset indirect --------- (mem[reg[a] + reg[b] + imm])
RII  = Register Indirect autoIncrement ---------- (mem[reg[a]]) reg[a]++
RID  = Register Indirect autoDecrement --------- (mem[reg[a]]) reg[a]--
RIPI = Register Indirect Pre-Increment ---------- (++reg[a]) (mem[reg[a]])
RIPD = Register Indirect Pre-Decrement --------- (--reg[a]) (mem[reg[a]])

12
MIMM  = Memory IMMediate ------------------------ (mem[imm])
MREG  = Memory REGister ------------------------- (mem[reg[a]])
MID   = Memory InDirect ------------------------- (mem[mem[imm]])
MREL  = Memory RELative ------------------------- (mem[mem[PC + imm]])
MRI   = Memory Register Indirect ---------------- (mem[mem[reg[a]]])
MIN   = Memory INdexed indirect ----------------- (mem[mem[reg[a] + imm]])
MINR  = Memory INdexed Register indirect -------- (mem[mem[reg[a] + reg[b]]])
MIRO  = Memory Indexed Register Offset indirect - (mem[mem[reg[a] + reg[b] + imm]])
MRII  = Memory Register Indirect autoIncrement -- (mem[mem[reg[a]]]) reg[a]++
MRID  = Memory Register Indirect autoDeccrement - (mem[mem[reg[a]]]) reg[a]--
MRIPI = Memory Register Indirect Pre-Increment -- (++reg[a]) (mem[mem[reg[a]]])
MRIPD = Memory Register Indirect Pre-Deccrement - (--reg[a]) (mem[mem[reg[a]]])


EQ = EQual
NEQ = Not EQual
QT = Greater Than
LT = Less Than
GEQ = Greater than or EQual
LEQ = Less than or EQual
C = Carry
NC = Not Carry
B = Borrow
NB = Not Borrow
Z = Zero
NZ = Not Zero
N = Negative
NN = Not Negative

BCD MATH STUFF
H = Half carry
NH = Not Half carry
Q = Quarter carry
NQ = Not Quarter carry
T = Three-quarter carry
NT = Not Three-quarter carry

ADDition
ADD MM-----XXXX MMMM OOOO AAAA IIII IIII IIII IIII

ADdition with Carry
ADC MM-----XXXX MMMM OOOO AAAA IIII IIII IIII IIII

SUBtraction
SUB MM-----XXXX MMMM OOOO AAAA IIII IIII IIII IIII

SuBtraction with Borrow
SBB MM-----XXXX MMMM OOOO AAAA IIII IIII IIII IIII

CoMPare
CMP MM-----XXXX MMMM BBBB AAAA IIII IIII IIII IIII

Bit Testing, Setting, Resetting, Complementing
BT MM------XXXX MMMM IIII AAAA
BTS MM-----XXXX MMMM IIII AAAA
BTR MM-----XXXX MMMM IIII AAAA
BTC MM-----XXXX MMMM IIII AAAA

JUMPS+++++++++++++++++++++++++++++++++++++++++++++
JuMP to address
JMP MM JJ-----XXXX XXXX MMMM JJJJ IIII IIII IIII IIII

push current address, CALL function
CALL MM JJ----XXXX XXXX MMMM JJJJ IIII IIII IIII IIII

ReTurN from function
RTN MM JJ-----XXXX XXXX MMMM JJJJ
JUMPS---------------------------------------------

Arithmetic Shift Left, Right
ASL--------XXXX MMMM IIII AAAA
ASR--------XXXX MMMM IIII AAAA
Logical Shift Left, Right
LSL--------XXXX MMMM IIII AAAA
LSR--------XXXX MMMM IIII AAAA
ROtate Left, Right
ROL--------XXXX MMMM IIII AAAA
ROR--------XXXX MMMM IIII AAAA
Rotate through Carry Left, Right
RCL--------XXXX MMMM IIII AAAA
RCR--------XXXX MMMM IIII AAAA

NEGate
NEG--------XXXX XXXX MMMM AAAA

AND
AND MM-----XXXX MMMM OOOO AAAA

Not AND
NAND MM----XXXX MMMM OOOO AAAA

OR
OR MM------XXXX MMMM OOOO AAAA

Not OR
NOR MM-----XXXX MMMM OOOO AAAA

eXclusive OR
XOR MM-----XXXX MMMM OOOO AAAA

eXclusive Not OR
XNOR MM----XXXX MMMM OOOO AAAA

invert
NOT--------XXXX XXXX MMMM AAAA

INCrement
INC MM-----XXXX XXXX MMMM AAAA

DECrement
DEC MM-----XXXX XXXX MMMM AAAA

PUSH to stack
PUSH-------XXXX XXXX MMMM OOOO
POP from stack
POP--------XXXX XXXX MMMM AAAA


No OPeration
NOP--------XXXX XXXX XXXX XXXX
HaLT
HLT--------XXXX XXXX XXXX XXXX

CPUID------XXXX XXXX XXXX XXXX

Carry Flag Clear, Set, Invert
CCF--------XXXX XXXX XXXX XXXX
SCF--------XXXX XXXX XXXX XXXX
ICF--------XXXX XXXX XXXX XXXX

Half Carry Flag Clear, Set, Invert
CHF--------XXXX XXXX XXXX XXXX
SHF--------XXXX XXXX XXXX XXXX
IHF--------XXXX XXXX XXXX XXXX

Quarter Carry Flag Clear, Set, Invert
CQF--------XXXX XXXX XXXX XXXX
SQF--------XXXX XXXX XXXX XXXX
IQF--------XXXX XXXX XXXX XXXX

Three-Quarter Carry Flag Clear, Set, Invert
CTF--------XXXX XXXX XXXX XXXX
STF--------XXXX XXXX XXXX XXXX
ITF--------XXXX XXXX XXXX XXXX

Zero Flag Clear, Set, Invert
CZF--------XXXX XXXX XXXX XXXX
SZF--------XXXX XXXX XXXX XXXX
IZF--------XXXX XXXX XXXX XXXX

Borrow Flag Clear, Set, Invert
CBF--------XXXX XXXX XXXX XXXX
SBF--------XXXX XXXX XXXX XXXX
IBF--------XXXX XXXX XXXX XXXX

Negative Flag Clear, Set, Invert
CNF--------XXXX XXXX XXXX XXXX
SNF--------XXXX XXXX XXXX XXXX
INF--------XXXX XXXX XXXX XXXX


LOAD-------XXXX XXXX MMMM OOOO IIII IIII IIII IIII

STORE------XXXX XXXX MMMM AAAA IIII IIII IIII IIII

COPY a to b
COPY REG---XXXX XXXX BBBB AAAA

COPY I amount of memory from mem[A] to mem[B] incrementing
COPY MEMI--XXXX TTTT BBBB AAAA IIII IIII IIII IIII
COPY I amount of memory from mem[A] to mem[B] decrementing
COPY MEMD--XXXX TTTT BBBB AAAA IIII IIII IIII IIII

*/