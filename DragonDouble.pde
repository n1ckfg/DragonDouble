int sW, sH;
int rW = 16;
int rH = 9;

void setup(){
  size(screen.width,screen.height);
  sW = screen.width;
  sH = (screen.width/rW)*rH;
}

void draw(){
  background(0);
  noStroke();
  fill(255);
  rectMode(CENTER);
  rect(screen.width/2,screen.height/2,sW,sH);  
}


