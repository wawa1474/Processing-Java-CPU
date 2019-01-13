char opcode;
char data;

int register;

void fetchOpcode(){
  opcode = char(mainRAM.contents[regPC] >> 8);
  data = char(mainRAM.contents[regPC] & 0xFF);
  //println("FO: " + hex(regPC) + " = " + hex(opcode));
  incPC();
}

void fetchData(){
  register = data;
  //print("FD: " + "reg = " + register);
  data = mainRAM.contents[regPC];
  //println(", " + hex(regPC) + " = "  + hex(data));
  incPC();
  setRegister(data);
}

void storeData(){
  //print("SD: " + "Address = " + hex(mainRAM.contents[regPC]));
  mainRAM.contents[regPC] = mainRAM.contents[regWP + data];
  //println(", " + "Data = "  + hex(mainRAM.contents[regWP + data]));
  incPC();
}

void loadData(){
  //print("LD: " + "Address = " + hex(mainRAM.contents[regWP + (data & 0x0F)]));
  //print(", " + "'Data' = " + hex(data));
  //print(", " + "Data = "  + hex(mainRAM.contents[mainRAM.contents[regWP + (data & 0x0F)]]));
  //print(", " + "Register0 = "  + hex(((data >> 4) & 0x0F)));
  //println(", " + "Register1 = "  + hex(data & 0x0F));
  mainRAM.contents[regWP + ((data >> 4) & 0x0F)] = mainRAM.contents[mainRAM.contents[regWP + (data & 0x0F)]];
  //incPC();
}

void storeRegister(){
  //print("SR: " + "Address = " + hex(mainRAM.contents[regWP + 0x0F]));
  mainRAM.contents[mainRAM.contents[regWP + 0x0F]] = mainRAM.contents[regWP + data];
  //println(", " + "Register = "  + hex(mainRAM.contents[regWP + data]));
}

void loadRegister(){//need to rewrit reto work
  //print("SR: " + "Address = " + hex(mainRAM.contents[regWP + 0x0F]));
  mainRAM.contents[mainRAM.contents[regWP + 0x0F]] = mainRAM.contents[regWP + data];
  //println(", " + "Register = "  + hex(mainRAM.contents[regWP + data]));
}

void storePixel(){
  //print("SR: " + "Address = " + hex(mainRAM.contents[regWP + 0x0F]));
  videoRAM.contents[mainRAM.contents[regWP + 0x0F]] = mainRAM.contents[regWP + data];
  //println(", " + "Register = "  + hex(mainRAM.contents[regWP + data]));
}

void fetchDataAddress(){
  register = 0;
  data = mainRAM.contents[mainRAM.contents[regWP + 0x0F]];
  //println("FDA: " + hex(mainRAM.contents[regWP + 0x0F]) + " = "  + hex(data));
  setRegister(data);
}

void fetchAddress(){
  register = 0x0F;
  //print("Address: ");
  data = mainRAM.contents[regPC];
  //println(hex(regPC) + " = "  + hex(data));
  incPC();
  setRegister(data);
}

char fetchRegister(){
  register = data;
  //println("FR: " + register);
  return mainRAM.contents[regWP + register];
}

void setRegister(char a){
  //print("SR: ");
  //print(hex(a));
  mainRAM.contents[regWP + register] = a;
  //println("reg " + register + ": " + hex(mainRAM.contents[regWP + register]));
}

void decodeOpcode(){
  //println("DO: " + opcodeDNames[opcode]);
  char tmp;
  switch(opcode){
    case SINGLES:
      decodeSingles();
      break;
      
    case AND:
      //print(regA);
      AND(mainRAM.contents[regWP], fetchRegister());
      //println("regA: " + hex(regA) + " AND " + hex(returnRegister()));
      break;
      
    case LOAD:
      fetchData();
      break;
    
    case PRINT:
      tmp = fetchRegister();
      //println("reg " + register + ":" + hex(tmp));
      break;
    
    case PRNTA:
      fetchAddress();
      fetchDataAddress();
      //println("Address: " + hex(mainRAM.contents[regWP + 0x0F]) + ", Data: " + hex(mainRAM.contents[regWP]));
      break;
      
    case ADD:
      //print("reg " + hex(((data >> 4) & 0x07)) + ": " + hex(mainRAM.contents[regWP + ((data >> 4) & 0x07)]) + " + " + "reg " + hex((data & 0x07)) + ": " + hex(mainRAM.contents[regWP + (data & 0x07)]));
      ADD(mainRAM.contents[regWP + ((data >> 4) & 0x0F)], mainRAM.contents[regWP + (data & 0x0F)]);
      //println(" = reg " + hex(0) + ": " + hex(mainRAM.contents[regWP]));
      break;
    
    case COPY:
      mainRAM.contents[regWP + (data & 0x0F)] = mainRAM.contents[regWP + ((data >> 4) & 0x0F)];
      //println("reg " + hex(((data >> 4) & 0x07)) + ": " + hex(mainRAM.contents[regWP + ((data >> 4) & 0x07)]) + " -> " + "reg " + hex(data& 0x07) + ": " + hex(mainRAM.contents[regWP + (data& 0x07)]));
      break;
    
    case INSC:
      instructionCount = data + 1;
      break;
    
    case INSM:
      instructionMultiplyer = data + 1;
      break;
    
    case INSD:
      instructionDelay = data;
      break;
    
    case COMPARE:
      COMPARE(mainRAM.contents[regWP + (data & 0x0F)], mainRAM.contents[regWP + ((data >> 4) & 0x0F)]);
      break;
    
    case STORE:
      storeData();
      break;
    
    case STOREREG:
      storeRegister();
      break;
    
    case INC:
      INC(data);
      break;
    
    case DEC:
      DEC(data);
      break;
    
    case STOREPIX:
      storePixel();
      break;
    
    case ZERO:
      mainRAM.contents[regWP + (data & 0x0F)] = 0;
      break;
    
    case LOADDATA:
      loadData();
      break;
    
    case ADDI:
      //print("reg " + hex(((data >> 4) & 0x07)) + ": " + hex(mainRAM.contents[regWP + ((data >> 4) & 0x07)]) + " + " + "reg " + hex((data & 0x07)) + ": " + hex(mainRAM.contents[regWP + (data & 0x07)]));
      ADDI(data, mainRAM.contents[regPC]);
      //println(" = reg " + hex(0) + ": " + hex(mainRAM.contents[regWP]));
      incPC();
      break;
  }
}

void decodeSingles(){
  //println("DS: " + opcodeSNames[data]);
  char tmp;
  switch(data){
    case NOP:
      break;
    
    case HALT:
      CPUHalt = true;
      break;
    
    case JUMPCARRY:
      if((regST & 0x0001) == 0x0001){
        //println("Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case JUMP:
      //println("Jump -> " + hex(mainRAM.contents[regPC]));
      regPC = mainRAM.contents[regPC];
      break;
    
    case JUMPNCARRY:
      if((regST & 0x0001) != 0x0001){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case COMPAREIMM:
      COMPARE(mainRAM.contents[regWP], mainRAM.contents[regPC]);
      incPC();
      break;
    
    case JUMPZERO:
      if((regST & 0x0002) == 0x0002){
        //println("Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case JUMPNZERO:
      if((regST & 0x0002) != 0x0002){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case JUMPBORROW:
      if((regST & 0x0004) == 0x0004){
        //println("Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case JUMPNBORROW:
      if((regST & 0x0004) != 0x0004){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case BRANCHCARRY:
      if((regST & 0x0001) == 0x0001){
        //println("Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        push(regPC + 1);
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case BRANCH:
      //println("Jump -> " + hex(mainRAM.contents[regPC]));
      push(regPC);
      regPC = mainRAM.contents[regPC];
      break;
    
    case BRANCHNCARRY:
      if((regST & 0x0001) != 0x0001){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        push(regPC + 1);
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case BRANCHZERO:
      if((regST & 0x0002) == 0x0002){
        //println("Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        push(regPC + 1);
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case BRANCHNZERO:
      if((regST & 0x0002) != 0x0002){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        push(regPC + 1);
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case BRANCHBORROW:
      if((regST & 0x0004) == 0x0004){
        //println("Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        push(regPC + 1);
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case BRANCHNBORROW:
      if((regST & 0x0004) != 0x0004){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[regPC]));
        push(regPC + 1);
        regPC = mainRAM.contents[regPC];
        break;
      }
      incPC();
      break;
    
    case BRANCHRETURN:
      regPC = pop();
      break;
    
    case KEYINPUT:
      if(keys[mainRAM.contents[regPC]] == true){
        regST |= 0x0002;//set zero flag
        //println(int(mainRAM.contents[regPC]));
      }else{
        regST &= 0xFFFD;//clear zero flag
      }
      incPC();
      break;
  }
}