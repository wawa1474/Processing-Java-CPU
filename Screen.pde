int screenType = 0;
boolean invertScreen = false;
color screenForegroundColor = screen_Amber;
color screenBackgroundColor = screen_Black;
boolean clearScreen = false;
boolean showAll = true;
boolean screenSizeChanged = true;

class Background{
  PImage buffer, image;
  int x;
  int y;
  
  color foregroundColor = screen_Amber;
  color backgroundColor = screen_Black;
  
  Background(int x_, int y_, int width_, int height_, int type_){
    x = x_;
    y = y_;
    buffer = image = new PImage(width_, height_, type_);
  }
  
  void set(char[] data_){
    buffer.loadPixels();
    int l;
    if(data_.length > buffer.width * buffer.height){
      l = buffer.width * buffer.height;
    }else{
      l = data_.length;
    }
    for(int i = 0; i < l; i++){
      buffer.pixels[i] = data_[i];
    }
    buffer.updatePixels();
    image = buffer;
  }
  
  void set(int index_, char data_){
    buffer.loadPixels();
    buffer.pixels[index_] = data_;
    buffer.updatePixels();
    image = buffer;
  }
  
  void set(char[] data_, int type_){
    buffer.loadPixels();
    int l;
    if(data_.length > buffer.width * buffer.height){
      l = buffer.width * buffer.height;
    }else{
      l = data_.length;
    }
    for(int i = 0; i < l; i++){
      switch(type_){
        case 0:
          buffer.pixels[i] = convertMemoryToColor(data_[i]);
          break;
        
        case 1:
          buffer.pixels[i] = convertMemoryToMono(data_[i]);
          break;
      }
    }
    buffer.updatePixels();
    image = buffer;
  }
  
  void set(char[] data_, int pos_, int length_, int type_){
    buffer.loadPixels();
    int pos;
    for(int i = 0; i < length_; i++){
      pos = pos_ + i;
      switch(type_){
        case 0:
          buffer.pixels[i] = convertMemoryToColor(data_[pos]);
          break;
        
        case 1:
          buffer.pixels[i] = convertMemoryToMono(data_[pos]);
          break;
      }
    }
    buffer.updatePixels();
    image = buffer;
  }
  
  void set(int pos_, int length_, int type_){
    buffer.loadPixels();
    int pos;
    for(int i = 0; i < length_; i++){
      pos = pos_ + i;
      switch(type_){
        case 0:
          buffer.pixels[i] = convertMemoryToColor(workRAM.contents[pos]);
          break;
        
        case 1:
          buffer.pixels[i] = convertMemoryToMono(workRAM.contents[pos]);
          break;
      }
    }
    buffer.updatePixels();
    image = buffer;
  }
  
  void clear(char value_){
    buffer.loadPixels();
    color tmp = convertMemoryToColor(value_);
    for(int i = 0; i < buffer.width * buffer.height; i++){
      buffer.pixels[i] = tmp;
    }
    buffer.updatePixels();
    image = buffer;
  }
  
  void draw(){
    image(image, x, y);
  }
  
  void draw(int width_, int height_){
    image(image, x, y, width_, height_);
  }
  
  void draw(int x, int y, int width_, int height_){
    image(image, x, y, width_, height_);
  }
}

color convertMemoryToColor(char memory){
  if(memory == 0xFFFF){
    return screen_WHITE;
  }
  int tempB = memory >> 4;
  int tempR = (tempB >> 4) & 0xF0;
  tempB = tempB & 0xF0;
  int tempG = memory & 0xFF;
  color pixelColor = color(tempR==0xF0?0xFF:tempR, tempG, tempB==0xF0?0xFF:tempB);
  if(invertScreen){
    pixelColor = pixelColor ^ color(255);
  }
  return pixelColor;
}

color convertMemoryToMono(char memory){
  return ((memory & 0x01) == 0x01)?screenForegroundColor:screenBackgroundColor;
}

void imageUpdate(){
  while(true){
    mem.set(workRAM.contents, 0, videoRAMSize, 0);
    dis.set(workRAM.contents, videoRAMPlace, videoRAMSize, 0);
  }
}