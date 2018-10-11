class RAM{//RAM
  int size;
  char contents[];
  
  public RAM(int size){
    this.size = size;
  }
}

class ROM{//ROM
  int size;
  char contents[];
  
  public ROM(int size, char contents[]){
    this.size = size;
    this.contents = contents;
  }
}

class REG{//Registers
  int regPC;//Program Counter
  char regA, regF;//Accumulator, Flags?
  char regB, regC;//Registers B & C
  char regD, regE;//Registers D & E
  char regH, regL;//Registers H & L
  char regI;//Interrupt Vector
  char regX, regY;//Index X, Index Y
  boolean flagC, flagZ;//Carry, Zero
  boolean flagO, flagN;//Overflow, Negative
  boolean flagS, flagP;//Sign, Parity
  
  public REG(){
    this.regPC = 0;
    this.regA = 0; this.regF = 0;
    this.regB = 0; this.regC = 0;
    this.regD = 0; this.regE = 0;
    this.regH = 0; this.regL = 0;
    this.regI = 0; this.regX = 0; this.regY = 0;
    this.flagC = false; this.flagZ = false;
    this.flagO = false; this.flagN = false;
    this.flagS = false; this.flagP = false;
  }
  
  void INCPC(){this.regPC++;}
  void DECPC(){this.regPC--;}
}

class STK{//Stack
  int regSP;
  char stack[];
  
  public STK(int size){
    this.regSP = 0;
    stack = new char[size];
  }
  
  void push(char c){
    stack[regSP] = c;
    this.regSP++;
  }
  
  char pop(){
    this.regSP--;
    return stack[regSP];
  }
  
}