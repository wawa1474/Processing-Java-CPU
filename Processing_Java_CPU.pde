color screen_Green = color(0,255,0);
color screen_Amber = #FFCC00;
color screen_Black = color(0);
final int kilo_Word = 1024;
final int kilo_Byte_Int = kilo_Word / 4;

final int mega_Word = kilo_Word * 1024;
final int mega_Byte_Int = mega_Word / 4;


boolean keys[] = new boolean[65536];


int instructionCount = 500;//000;//0x01;//FF
int instructionMultiplyer = 500;//000;//0x01;//07
int instructionDelay = 0;
int delayCount = 0;
int programMillis = 0;
int programFrames = 0;

boolean CPUHalt = false;
boolean forceExit = false;

int instructions = 0;

//void settings(){
//  if(showAll){
//    size(1552, 1000);//1552,768
//  }else{
//    size(768, 768);//1552,768
//  }
//}

Background mem;
Background dis;
boolean autoLoad = true;

int[] test2 = new int[4 * mega_Word];

void setup(){
  size(1552, 1000);//1552,768
  surface.setResizable(true);
  if(!showAll){
    surface.setSize(768, 768);
  }
  noSmooth();
  //hardReset();
  if(autoLoad){
    inputFile = new File(sketchPath() + "/code bak/imagedisplaytest4.bin").getAbsolutePath();
    hardReset();
  }else{
    selectInput("Select a file to load:", "fileSelected");
  }
  while(!fileSelected && !forceExit){delay(50);}
  
  //logo = new sprite(0x68, 8, 8, 32);
  //thread("master");
  mem = new Background(768, 0, 256, 256, RGB);
  dis = new Background(0, 0, 256, 256, RGB);
  
  for(int i = 0; i < test2.length; i++){
    test2[i] = i;
  }
  println(test2[int(random(test2.length))]);
}

void draw(){
  if(screenSizeChanged){
    if(showAll){
      surface.setSize(1552, 1000);
    }else{
      surface.setSize(768, 768);
    }
    screenSizeChanged = false;
  }
  
  
  //noLoop();
  if(delayCount >= instructionDelay / frameRate && !CPUHalt){
    for(int i = 0; i < instructionCount * instructionMultiplyer; i++){
      fetchOpcode();
      decodeOpcode();
      if(CPUHalt == true){i = instructionCount * instructionMultiplyer; /*noLoop();*/ println("CPU Halted!"); println((millis() - programMillis) + " Ms, " + (frameCount - programFrames) + " Frames, " + instructions + " Instructions");}
      instructions++;
    }
    delayCount = 0;
  }
  if(instructionDelay != 0){delayCount++;}// delay(1);}
  
  //instructions++;
  //background(0);
  
  if(clearScreen){
    clearScreen();
    clearScreen = false;
  }
  
  //thread("drawScreen");
  //drawScreen();
  //drawMemory();
  
  mem.set(workRAM.contents, 0);
  mem.draw(768, 768);
  dis.set(videoRAM.contents, 0);
  dis.draw(768, 768);
  
  //logo.setPosition(logo.x + instructionCount,logo.y + instructionMultiplyer);
  //logo.draw();
  
  //if(keys['m']){
  //  text("Hello M!",800,256);
  //}
  
  //if((regST & 0x0001) != 0x0001){
  //  text("Hello NC!",800,300);
  //}
  
  //text(int(keys[int('m')]),800,350);
  
  //blend(screen, 0, 0, 256, 256, 0, 0, 768, 768, BLEND);
  //frame.setTitle("Instruction: " + str(instructions) + ", FPS: " + str(frameRate));
  surface.setTitle("Instruction: " + str(instructions) + ", FPS: " + str(floor(frameRate)) + ", iC: " + instructionCount + ", iM: " + instructionMultiplyer + ", iD: " + instructionDelay);//hex(mainRAM.contents[regWP]));
  //text(frames, 300,100);
  //text(frameRate, 300,150);
  
  //if(instructionCount > 65536){
  //  hardReset();
  //}
}

void keyPressed(){
  //println(hex(key));
  //println(int(key));
  keys[key] = true;
  
  //println(keyCode);
  //println((int)key, keyCode);
  if(keyCode == 10 && CPUHalt == true){//Enter
    CPUHalt = false;
    //loop();
    hardReset();
  }
  
  if((int)key == 18 && keyCode == 82){//CTRL + R
    CPUHalt = false;
    //clearScreen = true;
    //loop();
    hardReset();
  }
}

void keyReleased(){
  keys[key] = false;
}

void keyTyped(){
  //int instructionCount = 0x01;//FF
  //int instructionMultiplyer = 0x01;//07
  //int instructionDelay = 0;
  //println(key);
  if(key == 'w'){
    instructionCount++;
  }
  if(key == 's'){
    instructionCount--;
    if(instructionCount <= 1){instructionCount = 1;}
  }
  if(key == 'e'){
    instructionMultiplyer++;
  }
  if(key == 'd'){
    instructionMultiplyer--;
    if(instructionMultiplyer <= 1){instructionMultiplyer = 1;}
  }
  if(key == 'r'){
    instructionDelay++;
  }
  if(key == 'f'){
    instructionDelay--;
    if(instructionDelay <= 0){instructionDelay = 0;}
  }
  if(key == 't'){
    screenType++;
    //println(screenType);
    background(0);
    if(screenType > 5){screenType = 5;}
    clearScreen = true;
  }
  if(key == 'g'){
    screenType--;
    //println(screenType);
    background(0);
    if(screenType < 0){screenType = 0;}
    clearScreen = true;
  }
  if(key == 'i'){
    color temp = screenForegroundColor;
    screenForegroundColor = screenBackgroundColor;
    screenBackgroundColor = temp;
  }
  if(key == 'k'){
    //color temp = screenForegroundColor;
    screenForegroundColor = screenForegroundColor ^ color(255);
    screenBackgroundColor = screenBackgroundColor ^ color(255);
    //temp = temp ^ color(255);
    invertScreen = !invertScreen;
  }
  if(key == '-'){
    selectInput("Select a file to load:", "fileSelected");
  }
  if(key == '='){
    showAll = !showAll;
    screenSizeChanged = true;
  }
  if(key == 'h'){
    logo.setPosition(logo.x,logo.y - 10);
  }
  if(key == 'v'){
    logo.setPosition(logo.x - 10,logo.y);
  }
  if(key == 'b'){
    logo.setPosition(logo.x,logo.y + 10);
  }
  if(key == 'n'){
    logo.setPosition(logo.x + 10,logo.y);
  }
  if(key == ','){
    logo.loopX = !logo.loopX;
  }
  if(key == '.'){
    logo.loopY = !logo.loopY;
  }
}