void hardReset(){
  byte b[] = loadBytes("bootCode.bin");
  char bootCode[] = new char[b.length];
  
  for(int i = 0; i < b.length; i++){
    bootCode[i] = char(b[i] & 0xFF);
  }
  
  bootROM = new ROM(bootCode);
  mainRAM = new RAM(RAMSize);
  
  resetRegisters();
  
  stack = new char[STKSize];
  regSP = 0;
}

void softReset(){
  resetRegisters();
}

void Error(String error){
  println(error);
  CPUHalt = true;
}