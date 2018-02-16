import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

boolean drawing = false;
int lineSize = 1;
float strokeColor1 = 125, strokeColor2 = 125, strokeColor3 = 125;
   
void setup() {
  size(1920, 1080);
  noStroke();
  background(0);
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
}

void keyPressed() {
  int keyIndex = -1;
  if (key == 'c')
    drawing = (!drawing);
  else if(key == 'j')
    lineSize += 1;
  else if(key == 'z')
    lineSize -= 1;
  else if(key == 'l'){
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
  } 
  sendOsc();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)key); 
  oscP5.send(msg, dest);
}
