void mouseTimer(){
  if(hitDetect(mouseX,mouseY,5,5,pmouseX,pmouseY,5,5)){
    if(mouseTimerCounter<mouseTimerCounterMax){
      mouseTimerCounter++;
    }else{
      mouseTimerCounter=0;
      showGui=false;
    }
  }else{
    mouseTimerCounter=0;
    showGui=true;
  }
}

void mouseReleased(){
  vertexTargetOn = false;
  if (buttons[buttonLoadNum].clicked){
    doButtonLoad();
  }
  if (buttons[buttonReloadNum].clicked){
    doButtonReload();
  }
  if (buttons[buttonScreenNum].clicked){
    doButtonScreen();
  }
}

void guiHandler(){
  mouseTimer();
  if(showGui){
    cursor();
    if(!fs.isFullScreen()){ //vertex deform doesn't work well with fullscreen
      sprite.debug = true;
    }else{
      sprite.debug = false;
    }
  }else{
    noCursor();
    sprite.debug = false;
  }
}

void moveVertices(){
  if(mousePressed){
    PVector m = new PVector(mouseX,mouseY);
    for(int i=0;i<sprite.vertices_proj.length;i++){
      if(hitDetect(m.x,m.y,10,10,sprite.vertices_proj[i].x,sprite.vertices_proj[i].y,10,10)){
        vertexTargetOn=true;
        vertexTarget = i;
      }
    }
    if(vertexTargetOn){
      sprite.vertices[vertexTarget] = sprite.projToVert(m,sprite.p);
    }
  }
}

void buttonSetup(){
  buttons[buttonLoadNum] = new Button(buttonOffset, buttonOffset, buttonSize, color(240, 10, 10), buttonFontSize, "load", "ellipse");
  buttons[buttonReloadNum] = new Button(buttonOffset * 2.25, buttonOffset, buttonSize, color(240, 240, 10), buttonFontSize, "refresh", "ellipse");
  buttons[buttonScreenNum] = new Button(buttonOffset * 3.5, buttonOffset, buttonSize, color(10, 240, 10), buttonFontSize, "screen", "rect");
}

void buttonHandler() {
  for (int i=0;i<buttons.length;i++) {
    buttons[i].checkButton();
    buttons[i].drawButton();
  }
}

void buttonsRefresh() {
  for (int i=0;i<buttons.length;i++) {
    buttons[i].clicked = false;
  }
}

void doButtonLoad(){
  if(!buttons[buttonLoadNum].grayed){
  doButtonStop();
    try{
    chooseFolderDialog();
    delay(saveDelayInterval);
    modeImg = true;
    //bvhBegin();
  }catch(Exception e){
    doButtonStop();
  }
}
}

void doButtonReload(){
  try{
    countFrames(folderPath);
  }catch(Exception e){ 
    println("error reloading images");
  }
}

void doButtonScreen(){
  doButtonStop();
  try{
    if(fs.isFullScreen()){
      fs.leave();
      buttons[buttonLoadNum].grayed = false;
    }else if(!fs.isFullScreen()){
      fs.enter();
      buttons[buttonLoadNum].grayed = true;
    }
  }catch(Exception e){
    doButtonStop();
  }
}

void doButtonStop(){
  //
}

void chooseFolderDialog(){
    folderPath = selectFolder();  // Opens file chooser
    if (folderPath == null) {
      // If a folder was not selected
      println("No folder was selected...");
    } else {
      println(folderPath);
      countFrames(folderPath);
    }
}

void countFrames(String usePath) {
    imgNames = new ArrayList();
    //loads a sequence of frames from a folder
    dataFolder = new File(usePath); 
    String[] allFiles = dataFolder.list();
    for (int j=0;j<allFiles.length;j++) {
      if (
        allFiles[j].toLowerCase().endsWith("png") ||
        allFiles[j].toLowerCase().endsWith("jpg") ||
        allFiles[j].toLowerCase().endsWith("jpeg") ||
        allFiles[j].toLowerCase().endsWith("gif") ||
        allFiles[j].toLowerCase().endsWith("tga")){
          imgNames.add(usePath+"/"+allFiles[j]);
        }
    }
    imgLoader();
}

void keyPressed(){
  if(key==' ' || keyCode==34){
    try{
    if(imgCounter<imgNames.size()-1){
      imgCounter++;
    }else{
      imgCounter=0;
    } 
    imgLoader();
    }catch(Exception e){ }
  }

  if(keyCode==33){
    try{
    if(imgCounter>0){
      imgCounter--;
    }else{
      imgCounter=imgNames.size()-1;
    } 
    imgLoader();
    }catch(Exception e){ }
  }
  
  if(keyCode==9){
    if(showGui){
      mouseTimerCounter=0;
      showGui = false;
    }else{
      mouseTimerCounter=0;
      showGui = true;
    }
  }
}

void imgLoader(){
  try{
    img[0] = loadImage((String) imgNames.get(imgCounter));
  }catch(Exception e){ }
}

void console(){
  if(debug){
      println(sprite.vertices[0] + " " + sprite.vertices_proj[0]);
  }
}

