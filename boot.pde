void hardReset(){
  byte b[] = loadBytes("bootCode.bin");
  char bootCode[] = new char[b.length];
  
  for(int i = 0; i < b.length; i++){
    bootCode[i] = char(b[i] & 0xFF);
  }
  
  bootROM = new ROM(bootCode.length, bootCode);
  mainRAM = new RAM(RAMSize);
  mainREG = new REG();
  mainSTK = new STK(STKSize);
}

void softReset(){
  mainREG = new REG();
}