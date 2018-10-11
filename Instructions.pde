enum OPCODES {NOP, AND, LOAD, HALT, PRINT, PRNTA};
char opcode;
char data;

int register;

void fetchOpcode(){
  opcode = char(mainRAM.contents[regPC] >> 8);
  data = char(mainRAM.contents[regPC] & 0xFF);
  println("FO: " + hex(regPC) + " = " + hex(opcode));
  INCPC();
}

void fetchData(){
  register = data;
  print("FD: " + "reg = " + register);
  data = mainRAM.contents[regPC];
  println(", " + hex(regPC) + " = "  + hex(data));
  INCPC();
  setRegister(data);
}

void fetchDataAddress(){
  register = 0;
  data = mainRAM.contents[mainRAM.contents[regWP + 0x0F]];
  println("FDA: " + hex(mainRAM.contents[regWP + 0x0F]) + " = "  + hex(data));
  setRegister(data);
}

void fetchAddress(){
  register = 0x0F;
  print("Address: ");
  data = mainRAM.contents[regPC];
  println(hex(regPC) + " = "  + hex(data));
  INCPC();
  setRegister(data);
}

char fetchRegister(){
  register = data;
  println("FR: " + register);
  return mainRAM.contents[regWP + register];
}

void setRegister(char a){
  print("SR: ");
  //print(hex(a));
  mainRAM.contents[regWP + register] = a;
  println("reg " + register + ": " + hex(mainRAM.contents[regWP + register]));
}

void decodeOpcode(){
  OPCODES decode = OPCODES.values()[opcode];
  println("DO: " + decode);
  char tmp;
  switch(decode){
    case NOP:
      break;
    
    case AND:
      //print(regA);
      AND(mainRAM.contents[regWP], fetchRegister());
      //println("regA: " + hex(regA) + " AND " + hex(returnRegister()));
      break;
      
    case LOAD:
      fetchData();
      break;
    
    case HALT:
      CPUHalt = true;
      break;
    
    case PRINT:
      tmp = fetchRegister();
      println("reg " + register + ":" + hex(tmp));
      break;
    
    case PRNTA:
      fetchAddress();
      fetchDataAddress();
      println("Address: " + hex(mainRAM.contents[regWP + 0x0F]) + ", Data: " + hex(mainRAM.contents[regWP]));
      break;
  }
}