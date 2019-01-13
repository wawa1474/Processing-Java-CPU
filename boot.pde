int programLength;

void hardReset(){//String input){
  //byte b[] = loadBytes("bootCode.bin");
  byte b[] = loadBytes(inputFile);
  programLength = b.length;
  
  mainRAM = new RAM(RAMSize);
  int j = 0;
  for(int i = 0; i < programLength; i+=2){
    mainRAM.contents[j] = char(b[i] & 0xFF);
    mainRAM.contents[j] = char((mainRAM.contents[j] << 8) | (b[i+1] & 0xFF));
    j++;
  }
  
  for(int i = programLength/2; i < RAMSize; i++){// - 0x0F; i++){
    //mainRAM.contents[i] = char(int(random(0, 65536)));
  }
  
  videoRAM = new RAM(VRAMSize);
  for(int i = 0; i < VRAMSize; i++){
    videoRAM.contents[i] = char(int(random(0, 65536)));
  }
  
  regPC = 0;
  regST = 0;
  regWP = 0xFFF0;
  
  mainRAM.contents[regWP + 0x0F] = char(int(random(0,65536)));
  
  stack = new int[STKSize];
  regSP = 0;
  
  instructions = 0;
  
  programMillis = millis();
  programFrames = frameCount;
  
  fileSelected = true;
}

void softReset(){
  regPC = 0;
  regST = 0;
  regWP = 0xFFF0;
  
  instructions = 0;
}

void Error(String error){
  println(error);
  CPUHalt = true;
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    forceExit = true;
    exit();
  } else {
    println("User selected " + selection.getAbsolutePath());
    //hardReset(selection.getAbsolutePath());
    inputFile = selection.getAbsolutePath();
    hardReset();
  }
}