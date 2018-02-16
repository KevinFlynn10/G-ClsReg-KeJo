import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;


int rectWidth;
boolean drawing = false;
int lineSize = 1;
float strokeColor1 = 0, strokeColor2 = 0, strokeColor3 = 0;
   
void setup() {
  size(1920, 1080);
  noStroke();
  background(0);
  rectWidth = width/4;
  frameRate(60);
  oscP5 = new OscP5(this,9000);
  dest = new NetAddress("127.0.0.1",6448);
}

void draw() { 
  stroke(strokeColor1, strokeColor2, strokeColor3);
  if (drawing == true) {
    strokeWeight(lineSize);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
  // keep draw() here to continue looping while waiting for keys
}

void keyPressed() {
  int keyIndex = -1;
  if (key == 99)
    drawing = (!drawing);
  else if(key == 106)
    lineSize += 1;
  else if(key == 122)
    lineSize -= 1;
  else if(key == 108){
    strokeColor1 = random(0, 255);
    strokeColor2 = random(0, 255);
    strokeColor3 = random(0, 255);
  }
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
  if (keyIndex == -1) {
    // If it's not a letter key, clear the screen
    background(0);
  } else { 
    // It's a letter key, fill a rectangle
    fill(random(0, 255), random(0, 255), random(0, 255));
    //float x = map(keyIndex, 0, 25, 0, width - rectWidth);
    //rect(x, 0, rectWidth, height);
  }
  sendOsc();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)key); 
  oscP5.send(msg, dest);
}