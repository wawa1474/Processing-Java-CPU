ROM bootROM;
RAM mainRAM;
REG mainREG;
STK mainSTK;
int RAMSize = 65536;
int STKSize = 256;

void setup(){
  size(960, 540);
  hardReset();
  for(int i = 0; i < bootROM.contents.length; i++){
    print(bootROM.contents[i] & 0xFF);
    print(", ");
  }
  //mainRam.contents = bootCode;
  mainSTK.push(char(255));
  println();
  print(mainSTK.pop() & 0xFF);
}

void draw(){
  
}