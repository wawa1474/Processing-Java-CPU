ROM bootROM;
RAM mainRAM;
int RAMSize = 65536;
int STKSize = 256;

boolean CPUHalt = false;

void setup(){
  size(960, 540);
  hardReset();
  for(int i = 0; i < bootROM.contents.length; i++){
    print(bootROM.contents[i] & 0xFF);
    print(", ");
    mainRAM.contents[i] = bootROM.contents[i];
  }
  //mainRam.contents = bootCode;
  push(char(255));
  println();
  println(pop() & 0xFF);
  /*mainRAM.contents[0] = 2;
  mainRAM.contents[1] = 0;
  mainRAM.contents[2] = 0xFFFF;
  mainRAM.contents[3] = 2;
  mainRAM.contents[4] = 2;
  mainRAM.contents[5] = 0xAA55;
  mainRAM.contents[6] = 1;
  mainRAM.contents[7] = 2;*/
  fetchOpcode();
  decodeOpcode();
  fetchOpcode();
  decodeOpcode();
  fetchOpcode();
  decodeOpcode();
  println(hex(regA));
}

void draw(){
  
}