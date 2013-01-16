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
  if (buttons[buttonLoadNum].clicked){
    doButtonLoad();
  }
  if (buttons[buttonScreenNum].clicked){
    doButtonScreen();
  }
}

void guiHandler(){
  mouseTimer();
  if(showGui){
    cursor();
  }else{
    noCursor();
  }
}

void buttonSetup(){
  buttons[buttonLoadNum] = new Button(buttonOffset, buttonOffset, buttonSize, color(240, 10, 10), buttonFontSize, "load", "ellipse");
  buttons[buttonScreenNum] = new Button(buttonOffset * 2.25, buttonOffset, buttonSize, color(10, 240, 10), buttonFontSize, "screen", "rect");
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
    imgCounterMax = imgNames.size();
    //bvhBegin();
  }catch(Exception e){
    doButtonStop();
  }
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
    String folderPath = selectFolder();  // Opens file chooser
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
    File dataFolder = new File(usePath); 
    String[] allFiles = dataFolder.list();
    for (int j=0;j<allFiles.length;j++) {
      if (
        allFiles[j].toLowerCase().endsWith("tif") ||
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
  if(key==' '){
    if(imgCounter<imgCounterMax-1){
      imgCounter++;
    }else{
      imgCounter=0;
    } 
    imgLoader();
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
img = loadImageIO((String) imgNames.get(imgCounter));
}

void console(){
  if(debug){
      println(mouseTimerCounter + " " + mouseTimerCounterMax + " " + frameRate);
  }
}

