/*
screen types:

0 = 16 bit color
1 = 1 bit monochrome
2 = 16 bit sparcley packed
3 = 1 bit monochrome sparcley packed
4 = 16 bit small
5 = 1 bit monochrome small
*/


void drawScreen(){
  screen.loadPixels();
  switch(screenType){
    case 0:
      screenHexScreen();
      break;
    
    case 1:
      screenMonoScreen();
      break;
    
    case 2:
      screenHexSparceScreen();
      break;
    
    case 3:
      screenMonoSparceScreen();
      break;
    
    case 4:
      screenHexSmallScreen();
      break;
    
    case 5:
      screenMonoSmallScreen();
      break;
  }
  
  screen.updatePixels();
  image(screen,0,0);
}

void screenHexScreen(){
  //strokeWeight(3);
  //screen.loadPixels();
  //for(int y = 0; y < 256; y++){
  //  for(int x = 0; x < 256; x++){
  //    //stroke((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
  //    //point(x * 3 + 2, y * 3 + 2);
  //    //screen.pixels[(y * 256) + x] = color((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
  //    screen.pixels[(y * 256) + x] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
  //  }
  //}
  //screen.updatePixels();
  //screen.resize(768,768);
  //image(screen,0,0);
  //screen.resize(256,256);
  
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      color tempPixel = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
      if(invertScreen){
        tempPixel = tempPixel ^ color(255);
      }
      for(int y2 = 0; y2 < 3; y2++){
        for(int x2 = 0; x2 < 3; x2++){
          //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
          screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = tempPixel;
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
}

void screenMonoScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      for(int y2 = 0; y2 < 3; y2++){
        for(int x2 = 0; x2 < 3; x2++){
          //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(0, (videoRAM.contents[(y * 256) + x] & 0x01) * 256, 0);
          screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = ((videoRAM.contents[(y * 256) + x] & 0x01) == 0x01)?screenForegroundColor:screenBackgroundColor;
        }
      }
    }
  }
}

void screenHexSparceScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      screen.pixels[(y * (768 * 3)) + (x * 3)] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
    }
  }
}

void screenMonoSparceScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      screen.pixels[(y * (768 * 3)) + (x * 3)] = ((videoRAM.contents[(y * 256) + x] & 0x01) == 0x01)?screenForegroundColor:screenBackgroundColor;
    }
  }
}

void screenHexSmallScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      screen.pixels[(y * 768) + x] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
    }
  }
}

void screenMonoSmallScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      screen.pixels[(y * 768) + x] = ((videoRAM.contents[(y * 256) + x] & 0x01) == 0x01)?screenForegroundColor:screenBackgroundColor;
    }
  }
}