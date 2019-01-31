int programLength;
boolean fileSelected = false; 
String inputFile = "";

void hardReset(){//String input){
  //byte b[] = loadBytes("bootCode.bin");
  byte b[] = loadBytes(inputFile);
  programLength = b.length;
  
  RAM_work = new RAM(RAM_workSize);
  int j = 0;
  for(int i = 0; i < programLength; i+=2){
    //RAM_work.contents[j] = char(b[i] & 0xFF);
    //RAM_work.contents[j] = char((RAM_work.contents[j] << 8) | (b[i+1] & 0xFF));
    RAM_work.contents[j] = char((b[i] << 8) | (b[i+1] & 0xFF));
    j++;
  }
  
  for(int i = programLength/2; i < RAM_workSize; i++){// - 0x0F; i++){
    //mainRAM.contents[i] = char(int(random(0, 65536)));
  }
  
  RAM_video = new RAM(RAM_videoSize);
  for(int i = 0; i < RAM_videoSize; i++){
    RAM_video.contents[i] = char(int(random(0, 65536)));
  }
  
  regST = 0;
  regWP = 0xFFF0;
  
  RAM_work.contents[regWP + 0x0F] = char(int(random(0,65536)));
  
  RAM_stack = new RAM(RAM_stackSize);
  
  RAM_work.pointer = 0;
  RAM_stack.pointer = 0;
  
  instructions = 0;
  
  programMillis = millis();
  programFrames = frameCount;
  
  fileSelected = true;
}

void softReset(){
  RAM_work.pointer = 0;
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
    println("User selected " + selection.getAbsolutePath());
    //hardReset(selection.getAbsolutePath());
    inputFile = selection.getAbsolutePath();
    hardReset();
  }
}