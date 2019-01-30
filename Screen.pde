/*
screen types:

0 = 16 bit color
1 = 1 bit monochrome
2 = 16 bit sparcley packed
3 = 1 bit monochrome sparcley packed
4 = 16 bit small
5 = 1 bit monochrome small
*/

void drawMemory(){
  //strokeWeight(3);
  //memory.loadPixels();
  //for(int y = 0; y < 256; y++){
  //  for(int x = 0; x < 256; x++){
  //    //stroke((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
  //    //point(x * 3 + 2, y * 3 + 2);
  //    //screen.pixels[(y * 256) + x] = color((mainRAM.contents[(y * 256) + x] >> 8) & 0xFF, mainRAM.contents[(y * 256) + x] & 0xFF, 0);
  //    memory.pixels[(y * 256) + x] = color(((mainRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, mainRAM.contents[(y * 256) + x] & 0xFF, ((mainRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
  //  }
  //}
  //memory.updatePixels();
  //memory.resize(768,768);
  //image(memory,768 + 16,0);
  //memory.resize(256,256);
  
  //memory.loadPixels();
  //for(int y = 0; y < 256; y++){
  //  for(int x = 0; x < 256; x++){
  //    for(int y2 = 0; y2 < 3; y2++){
  //      for(int x2 = 0; x2 < 3; x2++){
  //        memory.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((mainRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, (mainRAM.contents[(y * 256) + x] & 0xFF), ((mainRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
  //      }
  //    }
  //  }
  //}
  
  memory.loadPixels();
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      //memory.pixels[(y * 768) + x] = color(((mainRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, (mainRAM.contents[(y * 256) + x] & 0xFF), ((mainRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
      memory.pixels[(y * 256) + x] = color(((mainRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, (mainRAM.contents[(y * 256) + x] & 0xFF), ((mainRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
    }
  }
  
  //for(int y = 0; y < 256; y++){
  //  for(int x = 0; x < 256; x++){
  //    int tempRGB = mainRAM.contents[(y * 256) + x];
  //    int tempB = tempRGB >> 4;
  //    int tempR = (tempB >> 4);
  //    tempB = tempB & 0xF0;
  //    int tempG = tempRGB & 0xFF;
  //    //color tempPixel = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
  //    color tempPixel = color(tempR, tempG, tempB);
  //    if(invertScreen){
  //      tempPixel = tempPixel ^ color(255);
  //    }
  //    for(int y2 = 0; y2 < 3; y2++){
  //      for(int x2 = 0; x2 < 3; x2++){
  //        //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, videoRAM.contents[(y * 256) + x] & 0xFF, ((videoRAM.contents[(y * 256) + x] >> 8) & 0x0F) * 16);
  //        memory.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = tempPixel;
  //        //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 12) & 0x0F) * 16, (videoRAM.contents[(y * 256) + x] >> 4) & 0xFF, ((videoRAM.contents[(y * 256) + x]) & 0x0F) * 16);
  //        //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 11) & 0x1F) * 8, (videoRAM.contents[(y * 256) + x] & 0x3F) * 4, ((videoRAM.contents[(y * 256) + x] >> 6) & 0x1F) * 8);
  //        //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 11) & 0x1F) * 8, ((videoRAM.contents[(y * 256) + x] >> 5) & 0x3F) * 4, ((videoRAM.contents[(y * 256) + x]) & 0x1F) * 8);
  //        //screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = color(((videoRAM.contents[(y * 256) + x] >> 6) & 0x03) * 64, ((videoRAM.contents[(y * 256) + x] >> 2) & 0x0F) * 16, ((videoRAM.contents[(y * 256) + x]) & 0x03) * 64);
  //        /*if((videoRAM.contents[(y * 256) + x] & 0x01) == 0x01){
  //          screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = screen_Amber;
  //        }else{
  //          screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = screen_Black;
  //        }*/
  //      }
  //    }
  //  }
  //}
  
  memory.updatePixels();
  image(memory,768 + 16,0);
}


void drawScreen(){
  screen.loadPixels();
  memory.loadPixels();
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
  memory.updatePixels();
  if(screenType == 4 || screenType == 5){
    image(memory,256 + 16,0);
  }else{
    image(memory,768 + 16,0);
  }
}

color convertMemoryToColor(int memory){
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

color convertMemoryToMono(int memory){
  return ((memory & 0x01) == 0x01)?screenForegroundColor:screenBackgroundColor;
}

void clearScreen(){
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
  //for(int i = 0; i < VRAMSize; i++){
  //  videoRAM.contents[i] = char(int(random(0, 65536)));//'@';
  //  //print(i);
  //}
}

void screenHexScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      color tempPixel = convertMemoryToColor(videoRAM.contents[(y * 256) + x]);
      color tempPixel2 = convertMemoryToColor(mainRAM.contents[(y * 256) + x]);
      
      for(int y2 = 0; y2 < 3; y2++){
        for(int x2 = 0; x2 < 3; x2++){
          screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = tempPixel;
          memory.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = tempPixel2;
        }
      }
    }
  }
}

void screenMonoScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      color tempPixel = convertMemoryToMono(videoRAM.contents[(y * 256) + x]);
      color tempPixel2 = convertMemoryToMono(mainRAM.contents[(y * 256) + x]);
      for(int y2 = 0; y2 < 3; y2++){
        for(int x2 = 0; x2 < 3; x2++){
          screen.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = tempPixel;
          memory.pixels[(y * (768 * 3)) + (x * 3) + x2 + (y2 * 768)] = tempPixel2;
        }
      }
    }
  }
}

void screenHexSparceScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      color tempPixel = convertMemoryToColor(videoRAM.contents[(y * 256) + x]);
      color tempPixel2 = convertMemoryToColor(mainRAM.contents[(y * 256) + x]);
      screen.pixels[(y * (768 * 3)) + (x * 3)] = tempPixel;
      memory.pixels[(y * (768 * 3)) + (x * 3)] = tempPixel2;
    }
  }
}

void screenMonoSparceScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      color tempPixel = convertMemoryToMono(videoRAM.contents[(y * 256) + x]);
      color tempPixel2 = convertMemoryToMono(mainRAM.contents[(y * 256) + x]);
      screen.pixels[(y * (768 * 3)) + (x * 3)] = tempPixel;
      memory.pixels[(y * (768 * 3)) + (x * 3)] = tempPixel2;
    }
  }
}

void screenHexSmallScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      color tempPixel = convertMemoryToColor(videoRAM.contents[(y * 256) + x]);
      color tempPixel2 = convertMemoryToColor(mainRAM.contents[(y * 256) + x]);
      screen.pixels[(y * 768) + x] = tempPixel;
      memory.pixels[(y * 768) + x] = tempPixel2;
    }
  }
}

void screenMonoSmallScreen(){
  for(int y = 0; y < 256; y++){
    for(int x = 0; x < 256; x++){
      color tempPixel = convertMemoryToMono(videoRAM.contents[(y * 256) + x]);
      color tempPixel2 = convertMemoryToMono(mainRAM.contents[(y * 256) + x]);
      screen.pixels[(y * 768) + x] = tempPixel;
      memory.pixels[(y * 768) + x] = tempPixel2;
    }
  }
}