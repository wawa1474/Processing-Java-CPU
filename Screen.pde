int screenType = 0;
boolean invertScreen = false;
color screenForegroundColor = screen_Amber;
color screenBackgroundColor = screen_Black;
boolean clearScreen = false;
boolean showAll = true;
boolean screenSizeChanged = true;

class Background{
  PImage image, image2;
  int x;
  int y;
  
  color foregroundColor = screen_Amber;
  color backgroundColor = screen_Black;
  
  Background(int x_, int y_, int width_, int height_, int type_){
    x = x_;
    y = y_;
    image = image2 = new PImage(width_, height_, type_);
  }
  
  void set(char[] data_){
    image.loadPixels();
    int l;
    if(data_.length > image.width * image.height){
      l = image.width * image.height;
    }else{
      l = data_.length;
    }
    for(int i = 0; i < l; i++){
      image.pixels[i] = data_[i];
    }
    image.updatePixels();
    image2 = image;
  }
  
  void set(int index_, char data_){
    image.loadPixels();
    image.pixels[index_] = data_;
    image.updatePixels();
    image2 = image;
  }
  
  void set(char[] data_, int type_){
    image.loadPixels();
    int l;
    if(data_.length > image.width * image.height){
      l = image.width * image.height;
    }else{
      l = data_.length;
    }
    for(int i = 0; i < l; i++){
      switch(type_){
        case 0:
          image.pixels[i] = convertMemoryToColor(data_[i]);
          break;
        
        case 1:
          image.pixels[i] = convertMemoryToMono(data_[i]);
          break;
      }
    }
    image.updatePixels();
    image2 = image;
  }
  
  void set(char[] data_, int pos_, int length_, int type_){
    image.loadPixels();
    int pos;
    for(int i = 0; i < length_; i++){
      pos = pos_ + i;
      switch(type_){
        case 0:
          image.pixels[i] = convertMemoryToColor(data_[pos]);
          break;
        
        case 1:
          image.pixels[i] = convertMemoryToMono(data_[pos]);
          break;
      }
    }
    image.updatePixels();
    image2 = image;
  }
  
  void clear(char value_){
    image.loadPixels();
    for(int i = 0; i < image.width * image.height; i++){
      image.pixels[i] = value_;
    }
    image.updatePixels();
    image2 = image;
  }
  
  void draw(){
    image(image2, x, y);
  }
  
  void draw(int width_, int height_){
    image(image2, x, y, width_, height_);
  }
  
  void draw(int x, int y, int width_, int height_){
    image(image2, x, y, width_, height_);
  }
}

color convertMemoryToColor(char memory){
  int tempB = memory >> 4;
  int tempR = (tempB >> 4);
  tempB = tempB & 0xF0;
  int tempG = memory & 0xFF;
  color pixelColor = color(tempR, tempG, tempB);
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