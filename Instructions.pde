enum OPCODES {NOP, AND, LOAD, HALT, PRINT, PRNTA};
char opcode;
char data;

enum REGISTERS {regA, regF, regB, regC, regD, regE, regH, regL, regI, regX, regY};
REGISTERS register;

void fetchOpcode(){
  opcode = mainRAM.contents[regPC];
  println("FO: " + hex(regPC) + " = " + hex(opcode));
  INCPC();
}

void fetchData(){
  register = REGISTERS.values()[mainRAM.contents[regPC]];
  print("FD: " + hex(regPC) + " = " + register);
  INCPC();
  data = mainRAM.contents[regPC];
  print(", " + hex(regPC) + " = "  + hex(data));
  INCPC();
  data = char((data << 8) | mainRAM.contents[regPC]);
  println(", " + hex(regPC) + " = "  + hex(char(data & 0x00FF)));
  INCPC();
  setRegister(data);
}

void fetchDataAddress(){
  char tempx = regX;
  register = REGISTERS.values()[0];
  data = mainRAM.contents[regX];
  print("FDA: " + hex(regX) + " = "  + hex(data));
  if(regX >= 65535){tempx = 0;}else{tempx++;}
  data = char((data << 8) | mainRAM.contents[tempx]);
  println(", " + hex(regPC) + " = "  + hex(char(data & 0x00FF)));
  setRegister(data);
}

void fetchAddress(){
  register = REGISTERS.values()[9];
  print("Address: ");
  data = mainRAM.contents[regPC];
  print(hex(regPC) + " = "  + hex(data));
  INCPC();
  data = char((data << 8) | mainRAM.contents[regPC]);
  println(", " + hex(regPC) + " = "  + hex(char(data & 0x00FF)));
  INCPC();
  setRegister(data);
}

char fetchRegister(){
  register = REGISTERS.values()[mainRAM.contents[regPC]];
  println("FR: " + register);
  INCPC();
  return returnRegister();
}

void setRegister(char a){
  print("SR: ");
  //print(hex(a));
  switch(register){
    case regA:
      regA = a;
      break;
    case regF:
      regF = a;
      break;
    case regB:
      regB = a;
      break;
    case regC:
      regC = a;
      break;
    case regD:
      regD = a;
      break;
    case regE:
      regE = a;
      break;
    case regH:
      regH = a;
      break;
    case regL:
      regL = a;
      break;
    case regI:
      regI = a;
      break;
    case regX:
      regX = a;
      break;
    case regY:
      regY = a;
      break;
  }
  println(register + ": " + hex(returnRegister()));
}

char returnRegister(){
  //println("RR");
  char registerContents = 0;
  //println(register);
  switch(register){
    case regA:
      registerContents = regA;
      break;
    case regF:
      registerContents = regF;
      break;
    case regB:
      registerContents = regB;
      break;
    case regC:
      registerContents = regC;
      break;
    case regD:
      registerContents = regD;
      break;
    case regE:
      registerContents = regE;
      break;
    case regH:
      registerContents = regH;
      break;
    case regL:
      registerContents = regL;
      break;
    case regI:
      registerContents = regI;
      break;
    case regX:
      registerContents = regX;
      break;
    case regY:
      registerContents = regY;
      break;
  }
  return registerContents;
}

void decodeOpcode(){
  OPCODES decode = OPCODES.values()[opcode];
  println("DO: " + decode);
  switch(decode){
    case NOP:
      break;
    
    case AND:
      //print(regA);
      AND(regA, fetchRegister());
      //println("regA: " + hex(regA) + " AND " + hex(returnRegister()));
      break;
      
    case LOAD:
      fetchData();
      break;
    
    case HALT:
      CPUHalt = true;
      break;
    
    case PRINT:
      println(register + ":" + hex(fetchRegister()));
      break;
    
    case PRNTA:
      fetchAddress();
      fetchDataAddress();
      println("Address: " + hex(regX) + ", Data: " + hex(regA));
      break;
  }
}