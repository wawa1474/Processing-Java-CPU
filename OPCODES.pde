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
static final int RIJUMP= 20;//14

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

//Doubles Names
String opcodeDNames[] = {"SINGLES", "AND", "LOAD", "PRINT", "PRNTA", "ADD", "COPY", "INSC", "INSM", "INSD", "COMPARE", "STORE", "STORE REGISTER",
                         "INCREMENT", "DECREMENT", "STORE PIXEL", "ZERO", "LOAD DATA", "ADD IMMEDIATE","x","c","v","b","a"};

//Singles Names
String opcodeSNames[] = {"NOP", "HALT", "JMP C", "JMP", "JMP NC", "CMP IMM","JMP Z","JMP NZ","JMP B","JMP NB","BRN C","BRN","BRN NC","BRN Z","BRN NZ","BRN B","BRN NB",
                         "BRN RTN","KEY IN","","",""};