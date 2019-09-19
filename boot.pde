int programLength;
boolean fileSelected = false; 
String inputFile = "";

void hardReset(){//String input){
  //byte b[] = loadBytes("bootCode.bin");
  byte b[] = loadBytes(inputFile);
  programLength = b.length / 2;
  
  regST = 0;
  regWP = 0xFFF0;
  
  instructionCount = 1;
  instructionMultiplyer = 1;
  //instructionCount = 1000;
  //instructionMultiplyer = 1000;
  instructionDelay = 0;
  delayCount = 0;
  
  workRAM = new RAM(workRAMSize);
  workRAM.pointer = 0;
  workRAM.write(regWP + 0x0F, char(int(random(0,65536))));
  

  println("START OF BOOT CODE:");
  print(hex(0) + ": ");
  for(int i = 0; i < programLength; i++){
    //RAM_work.contents[j] = char(b[i] & 0xFF);
    //RAM_work.contents[j] = char((RAM_work.contents[j] << 8) | (b[i+1] & 0xFF));
    workRAM.write(i, char((b[i * 2] << 8) | (b[(i * 2) + 1] & 0xFF)));
    
    print(hex(workRAM.read(i)));
    if(i < programLength - 1){
      print(", ");
      if((i + 1) % 32 == 0){
        println();
        print(hex(i) + ": ");
      }
    }
    //if((i + 1) % 32 == 0 || (i + 1) == programLength){
    //  //println();
    //}
  }
  println();println(":END OF BOOT CODE...");println();
  
  //for(int i = programLength/2; i < RAM_workSize; i++){// - 0x0F; i++){
    //mainRAM.contents[i] = char(int(random(0, 65536)));
  //}
  
  //videoRAM = new RAM(videoRAMSize);
  //for(int i = 0; i < videoRAMSize; i++){
  //  videoRAM.contents[i] = char(0x2202);//int(random(0, 65536)));//
  //}
  
  //stackRAM = new RAM(stackRAMSize);
  //stackRAM.pointer = 0;
  
  //stackRAM.push(char(255));
  //println("stack test: " + (stackRAM.pop() & 0xFF));
  
  instructions = 0;
  
  programMillis = millis();
  programFrames = frameCount;
  
  fileSelected = true;
  
  for(int i = 256; i < 260; i++){
    workRAM.contents[i] = char(int(random(0, 16) * 4096));
  }
}

void softReset(){
  workRAM.pointer = 0;
  regST = 0;
  regWP = 0xFFF0;
  
  instructions = 0;
}

void Error(String error){
  println(error);
  CPUHalt = true;
}

void fileSelected(File selection) {
  if (selection == null && !fileSelected) {
    println("Window was closed or the user hit cancel.");
    forceExit = true;
    exit();
  } else if(selection != null) {
    println("User selected " + selection.getAbsolutePath());println();
    //hardReset(selection.getAbsolutePath());
    inputFile = selection.getAbsolutePath();
    hardReset();
  }
}