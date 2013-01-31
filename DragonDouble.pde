import processing.opengl.*;
import fullscreen.*;
//import controlP5.*;

int sW, sH;
int fps = 60;
FullScreen fs;
boolean matchWidth = true;
PImage[] img = new PImage[1];
ArrayList imgNames;
boolean showGui = true;
boolean debug = true;
int grabVerticesRange = 20;
boolean doInitSprite = true;
float globalImageScale = 1.0;

AnimSprite sprite;
int vertexTarget = 0;
boolean vertexTargetOn = false;

String folderPath;
File dataFolder;
/*
ControlP5 controlP5;
 Slider s1;
 int sliderValue = 100;
 int sliderTicks = 100;
 */

int buttonLoadNum = 0;
int buttonReloadNum = 1;
int buttonScreenNum = 2;
int buttonResetNum = 3;
int totalButtons = 4;
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

void setup() {
  Settings settings = new Settings("settings.txt");
  /*
  controlP5 = new ControlP5(this);
   s1 = controlP5.addSlider("% scale",0,100,128,215,33,100,30);
   */
  sW = screen.width;
  sH = screen.height;
  size(sW, sH, OPENGL);
  frameRate(fps);
  smooth();
  println(sW + " " + sH);
  buttonSetup();
  PFont font = createFont(fontFace, 3*fontSize);
  textFont(font, fontSize);
  fs = new FullScreen(this);
}

void draw() {
  background(0);
  guiHandler();
  try {
    sprite.frames[0] = img[0];
    /*
    sprite.s.x = s1.value()/100;
     sprite.s.y = s1.value()/100;
     */
    moveVertices();
    sprite.run();
  }
  catch(Exception e) {
  }
  if (showGui) {
    buttonHandler();
  }  
  console();
}

void initSprite() {
  sprite = new AnimSprite(img, 1);
  sprite.makeTexture();
  sprite.p.x = sW/2;
  sprite.p.y = sH/2;
}

boolean hitDetect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  w1 /= 2;
  h1 /= 2;
  w2 /= 2;
  h2 /= 2; 
  if (x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
    return true;
  } 
  else {
    return false;
  }
}

