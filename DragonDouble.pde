import processing.opengl.*;
import fullscreen.*;

int sW, sH;
int fps = 60;
FullScreen fs;
float rW = 16;
float rH = 9;
boolean matchWidth = true;
PImage img;
ArrayList imgNames;
boolean showGui = true;
boolean debug = true;

int buttonLoadNum = 0;
int buttonScreenNum = 1;
int totalButtons = 2;
//--
Button[] buttons = new Button[totalButtons];
int buttonOffset = 50;
int buttonSize = 50;
int buttonFontSize = 15;

boolean modeImg = false;
int imgCounter = 0;
int imgCounterMax = 0;
int mouseTimerCounter = 0;
int mouseTimerCounterMax = fps * 3;

PFont font;
int fontSize = 12;
String fontFace = "Arial";

int saveDelayInterval = 0;

void setup(){
  size(screen.width,screen.height,OPENGL);
  frameRate(fps);
  smooth();
  if(matchWidth){
    sW = screen.width;
    sH = int((screen.width/rW)*rH);
  }else{
    sW = int((screen.height/rH)*rW);
    sH = screen.height;
  }
  img = createImage(sW,sH,RGB);
  buttonSetup();
  PFont font = createFont(fontFace, 3*fontSize);
  textFont(font,fontSize);
  fs = new FullScreen(this); 
}

void draw(){
  guiHandler();
  background(0);
  noStroke();
  fill(255);
  imageMode(CENTER);
  try{
    image(img,screen.width/2,screen.height/2,sW,sH);
  }catch(Exception e){ }
  if(showGui){
    buttonHandler();
  }  
  console();
}

boolean hitDetect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  w1 /= 2;
  h1 /= 2;
  w2 /= 2;
  h2 /= 2; 
  if(x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
    return true;
  } 
  else {
    return false;
  }
}
