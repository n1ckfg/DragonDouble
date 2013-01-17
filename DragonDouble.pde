import processing.opengl.*;
import fullscreen.*;

int sW, sH;
int fps = 60;
FullScreen fs;
float rW = 16;
float rH = 9;
boolean matchWidth = true;
PImage[] img = new PImage[1];
ArrayList imgNames;
boolean showGui = true;
boolean debug = true;
int grabVerticesRange = 20;

AnimSprite sprite;
int vertexTarget = 0;
boolean vertexTargetOn = false;

String folderPath;
File dataFolder;

int buttonLoadNum = 0;
int buttonReloadNum = 1;
int buttonScreenNum = 2;
int totalButtons = 3;
//--
Button[] buttons = new Button[totalButtons];
int buttonOffset = 50;
int buttonSize = 50;
int buttonFontSize = 15;

boolean modeImg = false;
int imgCounter = 0;
int mouseTimerCounter = 0;
int mouseTimerCounterMax = fps * 3;

PFont font;
int fontSize = 12;
String fontFace = "Arial";

int saveDelayInterval = 0;

void setup(){
  Settings settings = new Settings("settings.text");
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
  img[0] = createImage(sW,sH,RGB);
  sprite = new AnimSprite(img,1);
  sprite.makeTexture();
  sprite.p.x = sW/2;
  sprite.p.y = sH/2;
  sprite.s.x = 1.0;
  sprite.s.y = 1.0;
  buttonSetup();
  PFont font = createFont(fontFace, 3*fontSize);
  textFont(font,fontSize);
  fs = new FullScreen(this); 
}

void draw(){
  background(0);
  guiHandler();
  try{
    sprite.frames[0] = img[0];
    moveVertices();
    sprite.run();
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
