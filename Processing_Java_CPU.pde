RAM mainRAM;
int RAMSize = 65536;
int STKSize = 256;

RAM videoRAM;
int VRAMSize = 65536;
int instructionCount = 0xFF;//FF
int instructionMultiplyer = 0x07;//07
int instructionDelay = 0;

boolean CPUHalt = false;

int instructions = 0;

//PImage screen = createImage(256,256,RGB);
PImage screen = createImage(768,768,RGB);
//PImage memory = createImage(256,256,RGB);
PImage memory = createImage(768,768,RGB);

color screen_Green = color(0,255,0);
color screen_Amber = #FFCC00;
color screen_Black = color(0);

void setup(){
  size(1552, 768);
  //noSmooth();
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
  //noLoop();
  for(int i = 0; i < instructionCount * instructionMultiplyer; i++){
    fetchOpcode();
    decodeOpcode();
    if(CPUHalt == true){i = instructionCount * instructionMultiplyer; noLoop(); println("CPU Halted!"); println(millis() + " Ms, " + frameCount + " Frames");}
    delay(instructionDelay);
    instructions++;
  }
  //instructions++;
  background(0);
  /*strokeWeight(3);
  screen.loadPixels();
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      //stroke((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
      //point(x * 3 + 2, y * 3 + 2);
      //screen.pixels[(y * 256) + x] = color((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
      screen.pixels[(y * 256) + x] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
    }
  }
  screen.updatePixels();
  screen.resize(768,768);
  image(screen,0,0);
  screen.resize(256,256);*/
  
  screen.loadPixels();
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      for(int y2 = 0; y2 < 3; y2++){
        for(int x2 = 0; x2 < 3; x2++){
          screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
          //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, (videoRAM.contents[(y * 256) + x] >> 4) & 0xFF, ((videoRAM.contents[(y * 256) + x]) & 0x0F) * 16);
          //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 11) & 0x1F) * 8, (videoRAM.contents[(y * 256) + x] & 0x3F) * 4, ((videoRAM.contents[(y * 256) + x] >> 6) & 0x1F) * 8);
          //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 11) & 0x1F) * 8, ((videoRAM.contents[(y * 256) + x] >> 5) & 0x3F) * 4, ((videoRAM.contents[(y * 256) + x]) & 0x1F) * 8);
          //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 6) & 0x03) * 64, ((videoRAM.contents[(y * 256) + x] >> 2) & 0x0F) * 16, ((videoRAM.contents[(y * 256) + x]) & 0x03) * 64);
          /*if((videoRAM.contents[(y * 256) + x] & 0x01) == 0x01){
            screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = screen_Amber;
          }else{
            screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = screen_Black;
          }*/
        }
      }
    }
  }
  screen.updatePixels();
  image(screen,0,0);
  
  strokeWeight(14);
  stroke(255);
  line(768 + 8, 0, 768 + 8, height);
  
  /*strokeWeight(3);
  memory.loadPixels();
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      //stroke((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
      //point(x * 3 + 2, y * 3 + 2);
      //screen.pixels[(y * 256) + x] = color((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
      memory.pixels[(y * 256) + x] = color(((mainRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, mainRAM.contents[(y * 256) + x] & 0xFF, ((mainRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
    }
  }
  memory.updatePixels();
  memory.resize(768,768);
  image(memory,768 + 16,0);
  memory.resize(256,256);*/
  
  memory.loadPixels();
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      for(int y2 = 0; y2 < 3; y2++){
        for(int x2 = 0; x2 < 3; x2++){
          memory.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((mainRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, (mainRAM.contents[(y * 256) + x] & 0xFF), ((mainRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
        }
      }
    }
  }
  memory.updatePixels();
  image(memory,768 + 16,0);
  
  
  //blend(screen, 0, 0, 256, 256, 0, 0, 768, 768, BLEND);
  //frame.setTitle("Instruction: " + str(instructions) + ", FPS: " + str(frameRate));
  surface.setTitle("Instruction: " + str(instructions) + ", FPS: " + str(floor(frameRate)) + ", TEST: " + hex(mainRAM.contents[regWP]));
  //text(frames, 300,100);
  //text(frameRate, 300,150);
}

void keyPressed(){
  //println(keyCode);
  //println((int)key, keyCode);
  if(keyCode == 10 && CPUHalt == true){//Enter
    CPUHalt = false;
    loop();
    hardReset();
  }
  
  if((int)key == 18 && keyCode == 82){//CTRL + R
    CPUHalt = false;
    loop();
    hardReset();
  }
}

void keyTyped(){
  //println(key);
}