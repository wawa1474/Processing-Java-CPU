//Doubles
static final int SINGLES = 0;
static final int AND = 1;
static final int LOAD = 2;
static final int PRINT = 3;
static final int PRNTA = 4;
static final int ADD = 5;
static final int COPY = 6;
static final int INSC = 7;
static final int INSM = 8;
static final int INSD = 9;
static final int COMPARE = 10;
static final int STORE = 11;
static final int STOREREG = 12;
static final int INC = 13;
static final int DEC = 14;
static final int STOREPIX = 15;
static final int ZERO = 16;

//Singles
static final int NOP = 0;
static final int HALT = 1;
static final int JUMPCARRY = 2;
static final int JUMP = 3;
static final int JUMPNCARRY = 4;
static final int COMPAREIMM = 5;
static final int JUMPZERO = 6;
static final int JUMPNZERO = 7;
static final int JUMPBORROW = 8;
static final int JUMPNBORROW = 9;
static final int BRANCHCARRY = 10;
static final int BRANCH = 11;
static final int BRANCHNCARRY = 12;
static final int BRANCHZERO = 13;
static final int BRANCHNZERO = 14;
static final int BRANCHBORROW = 15;
static final int BRANCHNBORROW = 16;
static final int BRANCHRETURN = 17;

//Doubles Names
String opcodeDNames[] = {"SINGLES", "AND", "LOAD", "PRINT", "PRNTA", "ADD", "COPY", "INSC", "INSM", "INSD", "COMPARE", "STORE", "STORE REGISTER",
                         "INCREMENT", "DECREMENT", "STORE PIXEL"};

//Singles Names
String opcodeSNames[] = {"NOP", "HALT", "JUMP CARRY", "JUMP", "JUMP NOT CARRY", "COMPARE IMMEDIATE"};