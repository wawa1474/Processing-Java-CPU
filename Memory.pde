class RAM{//RAM
  char contents[];
  
  public RAM(int size){
    contents = new char[size];
  }
}

class ROM{//ROM
  char contents[];
  
  public ROM(char contents[]){
    this.contents = contents;
  }
}

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
  
void INCPC(){this.regPC++;}
void DECPC(){this.regPC--;}

void resetRegisters(){
  regPC = 0;//Program Counter
  regA = 0; regF = 0;//Accumulator, Flags?
  regB = 0; regC = 0;//Registers B & C
  regD = 0; regE = 0;//Registers D & E
  regH = 0; regL = 0;//Registers H & L
  regI = 0;//Interrupt Vector
  regX = 0; regY = 0;//Index X, Index Y
  flagC = false; flagZ = false;//Carry, Zero
  flagO = false; flagN = false;//Overflow, Negative
  flagS = false; flagP = false;//Sign, Parity
}


int regSP = 0;
char stack[] = new char[STKSize];
  
void push(char c){
  stack[regSP] = c;
  this.regSP++;
}
  
char pop(){
  this.regSP--;
  return stack[regSP];
}