//Doubles
static final int SINGLES = 0;//00
static final int AND = 1;//01
static final int LOAD = 2;//02
static final int PRINT = 3;//03
static final int PRNTA = 4;//04
static final int ADD = 5;//05
static final int COPY = 6;//06
static final int INSC = 7;//07
static final int INSM = 8;//08
static final int INSD = 9;//09
static final int COMPARE = 10;//0A
static final int STORE = 11;//0B
static final int STOREREG = 12;//0C
static final int INC = 13;//0D
static final int DEC = 14;//0E
static final int STOREPIX = 15;//0F
static final int ZERO = 16;//10
static final int LOADDATA = 17;//11
static final int ADDI = 18;//12
static final int RGILOAD = 19;//13
static final int RIJUMP = 20;//14
static final int PUSHREG = 21;//15
static final int POPREG = 22;//16
static final int COMPAREREGS = 23;//17
static final int INDSTOREPIX = 24;//18
static final int AIINDSTOREPIX = 25;//19
static final int LOADREGINSC = 26;//1A
static final int REGCOMPAREIMM = 27;//1B
static final int LOADSPRITE = 28;//1C
static final int LOADINDA = 29;//1D
static final int CLRSCREEN = 30;//1E

//Singles
static final int NOP = 0;//00
static final int HALT = 1;//01
static final int JUMPCARRY = 2;//02
static final int JUMP = 3;//03
static final int JUMPNCARRY = 4;//04
static final int COMPAREIMM = 5;//05
static final int JUMPZERO = 6;//06
static final int JUMPNZERO = 7;//07
static final int JUMPBORROW = 8;//08
static final int JUMPNBORROW = 9;//09
static final int BRANCHCARRY = 10;//0A
static final int BRANCH = 11;//0B
static final int BRANCHNCARRY = 12;//0C
static final int BRANCHZERO = 13;//0D
static final int BRANCHNZERO = 14;//0E
static final int BRANCHBORROW = 15;//0F
static final int BRANCHNBORROW = 16;//10
static final int BRANCHRETURN = 17;//11
static final int KEYINPUT = 18;//12
static final int INCINSC = 19;//13
static final int INCINSM = 20;//14
static final int SKIPZERO = 21;//15
static final int HARDRESET = 22;//16
static final int INSCCOMPAREIMM = 23;//17
static final int INDXINC = 24;//18
static final int INDYINC = 25;//19
static final int DRAWSPRITE = 26;//1A

/*JP EQU - Jump if EQUAL
JP NEQ - Jump if NOT EQUAL

JP GT - Jump if GREATER THAN
JP LT - Jump if LESS THAN

JP GE - Jump if GREATER THAN OR EQUAL
JP LE - Jump if LESS THAN OR EQUAL

JP C  - Jump if CARRY
JP NC - Jump if NOT CARRY

JP B  - Jump if BORROW
JP NB - Jump if NOT BORROW

JP Z  - Jump if ZERO
JP NZ - Jump if NOT ZERO

JP    - Jump UNCONDITIONALY

JP BS - Jump if Bit Set
JP BC - Jump if Bit Clear

JP ??*/
final int condition_UNC = 0;//ALWAYS
final int condition_NEV = 1;//NEVER
final int condition_C = 2;//if CARRY
final int condition_NC = 3;//if NOT CARRY
final int condition_Z = 4;//if ZERO
final int condition_NZ = 5;//if NOT ZERO
final int condition_B = 6;//if BORROW
final int condition_NB = 7;//if NOT BORROW
final int condition_PLS = 8;//if POSITIVE
final int condition_MIN = 9;//if NEGEATIVE
final int condition_GT = 10;//if GREATER THAN
final int condition_LS = 11;//if LESS THAN
final int condition_GTE = 12;//if GREATER THAN OR EQUAL
final int condition_LTE = 13;//if LESS THAN OR EQUAL
final int condition_NN = 14;//NOT IMPLEMENTED
final int condition_NNN = 15;//NOT IMPLEMENTED

//Doubles Names
String opcodeDNames[] = {"SINGLES", "AND", "LOAD", "PRINT", "PRNTA", "ADD", "COPY", "INSC", "INSM", "INSD", "COMPARE", "STORE", "STORE REGISTER",
                         "INCREMENT", "DECREMENT", "STORE PIXEL", "ZERO", "LOAD DATA", "ADD IMMEDIATE","x","c","v","b","a"};

//Singles Names
String opcodeSNames[] = {"NOP", "HALT", "JMP C", "JMP", "JMP NC", "CMP IMM","JMP Z","JMP NZ","JMP B","JMP NB","BRN C","BRN","BRN NC","BRN Z","BRN NZ","BRN B","BRN NB",
                         "BRN RTN","KEY IN","","",""};