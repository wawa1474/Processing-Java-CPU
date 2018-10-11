RAM mainRAM;
int RAMSize = 65536;
int STKSize = 256;

int instructionCount = 1;
int instructionMultiplyer = 1;
int instructionDelay = 0;

boolean CPUHalt = false;

int instructions = 0;

PImage screen = createImage(256,256,RGB);

void setup(){
  size(768, 768);
  hardReset();
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

void draw(){
  for(int i = 0; i < instructionCount * instructionMultiplyer; i++){
    fetchOpcode();
    decodeOpcode();
    if(CPUHalt == true){i = instructionCount * instructionMultiplyer; noLoop();}
    delay(instructionDelay);
  }
  instructions++;
  background(0);
  strokeWeight(3);
  screen.loadPixels();
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      //stroke((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
      //point(x * 3 + 2, y * 3 + 2);
      screen.pixels[(y * 256) + x] = color((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
    }
  }
  screen.updatePixels();
  screen.resize(768,768);
  image(screen,0,0);
  screen.resize(256,256);
  //frame.setTitle("Instruction: " + str(instructions) + ", FPS: " + str(frameRate));
  surface.setTitle("Instruction: " + str(instructions) + ", FPS: " + str(frameRate));
  //text(frames, 300,100);
  //text(frameRate, 300,150);
}