int programLength;

void hardReset(){
  byte b[] = loadBytes("bootCode.bin");
  programLength = b.length;
  
  mainRAM = new RAM(RAMSize);
  int j = 0;
  for(int i = 0; i < programLength; i+=2){
    mainRAM.contents[j] = char(b[i] & 0xFF);
    mainRAM.contents[j] = char((mainRAM.contents[j] << 8) | (b[i+1] & 0xFF));
    j++;
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