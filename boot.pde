int programLength;

void hardReset(){
  byte b[] = loadBytes("bootCode.bin");
  programLength = b.length;
  
  mainRAM = new RAM(RAMSize);
  
  for(int i = 0; i < programLength; i++){
    mainRAM.contents[i] = char(b[i] & 0xFF);
  }
  
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