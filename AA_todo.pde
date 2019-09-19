/*
thread("function_name");
millis();
while(true)
redraw();


interrupts
  once every frame (program)
  once every horizontal line (display)
  once every frame (display)
  interrupt on memory address
    when a certain value (0, 0xff, 0a5, etc.)
    when written to
    when read from


have all memory be in the "main memory"
  registers (R0 - R?, PC, SP, IX, IY)
  zero page
  video ram
  keyboard
  disk
  stack
    push
    pop
    peek
    update
    roll
    size
    empty


jumps
  have stored changable address and a single instruction to jump to it (256 sub routines?)
    have the jump table in workRAM?
    set Jaddress 0 (load address from memory)
    jump Jaddress 0 (jump to loaded address)


thread(cpu);//central processing unit
  allow multiple cpus?
    do they all use the same memory or do they have some of their own?
    whats the max # of cpus?
    can one halt itself and be reset/restarted by another?
thread(apu);//audio processing unit
thread(gpu);//graphics processing unit
  do we use redraw()?
thread(disk);//file reading/writing



complex graphics
  horizontal/vertical scrolling
  horizontal/vertical per line shifting
  palette swapping
  sprites
  backgrounds

audio
  sine/triangle/square/saw
  float array
  
  

0xabad1dea
*/

boolean run = true;
int frame = 0;
int test = 0;

void master(){
  while(run == true){
    //main code here
    
    int tmpMillis = millis();
    if(tmpMillis - 17 > frame){
      frame = tmpMillis;
      redraw();
    }
    
    if(tmpMillis - 1000 > test){
      test = tmpMillis;
      println("test");
    }
  }
}

//float x = 0;

//void setup() {
//  size(200, 200);
//  noLoop();
//}

//void draw() {
//  background(204);
//  line(x, 0, x, height); 
//}

//void mousePressed() {
//  x += 1;
//  redraw();
//}


//void setup(){
//  PImage image = loadImage("font.png");
//  image.loadPixels();
//  int length_ = image.width * image.height;
//  byte[] output = new byte[length_ * 2];
//  int pos = 0;
//  for(int character = 0; character < image.width; character++){
//    for(int y = (character / 32) * 8; y < ((character / 32) * 8) + 8; y++){
//      for(int x = (character * 8) % image.width; x < ((character * 8) % image.width) + 8; x++){
//        color pix = image.get(x, y);
//        int red = (pix >> 16) & 0xF0;
//        int blue = (pix >> 12) & 0x0F;
//        int green = (pix >> 8) & 0xFF;
//        output[pos] = byte(red | blue);
//        output[pos + 1] = byte(green);
//        pos += 2;
//      }
//    }
//  }
//  saveBytes("font.bin", output);
  
//  output = new byte[length_ / 8];
//  pos = 0;
//  for(int character = 0; character < image.width; character++){
//    for(int y = (character / 32) * 8; y < ((character / 32) * 8) + 8; y++){
//      output[pos/8] = byte(0);
//      for(int x = (character * 8) % image.width; x < ((character * 8) % image.width) + 8; x++){
//        color pix = image.get(x, y);
//        output[pos / 8] |= byte(pix != 0xFF000000?1<<7-(pos%8):0);
//        pos++;
//      }
//    }
//  }
//  saveBytes("fontbin.bin", output);
//  exit();
//}