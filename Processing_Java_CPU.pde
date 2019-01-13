color screen_Green = color(0,255,0);
color screen_Amber = #FFCC00;
color screen_Black = color(0);

boolean keys[] = new boolean[65536];


RAM mainRAM;
int RAMSize = 65536;
int STKSize = 256;

RAM videoRAM;
int VRAMSize = 65536;
int screenType = 0;
boolean invertScreen = false;
color screenForegroundColor = screen_Amber;
color screenBackgroundColor = screen_Black;


int instructionCount = 1;//000;//0x01;//FF
int instructionMultiplyer = 1;//000;//0x01;//07
int instructionDelay = 0;
int delayCount = 0;
int programMillis = 0;
int programFrames = 0;

boolean CPUHalt = false;
boolean fileSelected = false;
String inputFile = "";
boolean forceExit = false;

int instructions = 0;

//PImage screen = createImage(256,256,RGB);
PImage screen = createImage(768,768,RGB);
//PImage memory = createImage(256,256,RGB);
PImage memory = createImage(768,768,RGB);
boolean clearScreen = false;

void setup(){
  size(1552, 1000);//1552,768
  //noSmooth();
  //hardReset();
  selectInput("Select a file to load:", "fileSelected");
  while(!fileSelected && !forceExit){delay(50);}
  
  if(!forceExit){
    print("bootCode: ");
    for(int i = 0; i < programLength / 2; i++){
      print(hex(mainRAM.contents[i]));
      if(i < programLength / 2 - 1){print(", ");}
    }
    println();println();
  
    push(char(255));
    println(pop() & 0xFF);
    println();
  }
}

void draw(){
  //noLoop();
  if(delayCount >= instructionDelay / frameRate && !CPUHalt){
    for(int i = 0; i < instructionCount * instructionMultiplyer; i++){
      fetchOpcode();
      decodeOpcode();
      if(CPUHalt == true){i = instructionCount * instructionMultiplyer; /*noLoop();*/ println("CPU Halted!"); println((millis() - programMillis) + " Ms, " + (frameCount - programFrames) + " Frames");}
      instructions++;
    }
    delayCount = 0;
  }
  if(instructionDelay != 0){delayCount++;}// delay(1);}
  
  //instructions++;
  background(0);
  
  if(clearScreen){
    screen.loadPixels();
    memory.loadPixels();
    
    for(int y = 0; y < 256; y++){
      for(int x = 0; x < 256; x++){
        for(int y2 = 0; y2 < 3; y2++){
          for(int x2 = 0; x2 < 3; x2++){
            screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = 0;
            memory.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = 0;
          }
        }
      }
    }
    
    screen.updatePixels();
    memory.updatePixels();
    //fill(0);
    //stroke(0);
    //rect(0,0,width,height);
    clearScreen = false;
    //for(int i = 0; i < VRAMSize; i++){
    //  videoRAM.contents[i] = char(int(random(0, 65536)));//'@';
    //  //print(i);
    //}
  }
  
  drawScreen();
  //drawMemory();
  
  strokeWeight(14);
  stroke(255);
  line(768 + 8, 0, 768 + 8, height);
  
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
    clearScreen = true;
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
    if(screenType > 5){screenType = 5;}
    clearScreen = true;
  }
  if(key == 'g'){
    screenType--;
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
}