/**
Author: Jake Fuller, Avery Walker, Chris Bobholz
Version: 0.2.1b
This program is designed to be a collection of videos, in similar style to
the menus you would see on DVDs. The first screen is a title screen that allows the user
to click a button and navigate to anther screen where you can select a video.
The use of the program is to be able to view any video in the collection,
as well as manipulate it while watching it by being able to pause, stop, play,
change volume, etc. A UI is intended, but there is a keyboard shortcut alternative in place.
Hitting backspace at any time or a button in the top left while watching any movie
will cause it to go back to the preview menu.
**/

//Importing PDF Library along with video/sound Libraries
import processing.pdf.*;
import processing.video.*;
import processing.sound.*;

//Create a boolean (True or False) variable to
//tell Processing when to start and stop saving
//the screen information to a .pdf file.
boolean recordScreen;

//A String variable can be used to change
//the file name of the .pdf to be saved.
String fileName;

Movies [] mov = new Movies [4];
Movie [] movies = new Movie [4];
PImage menuBackground, shapeTexture;
PShape menuShape;
float u, v, uO, vO, menu, //'menu' determines what menu screen the user is on and what to display.
shapeRotationX, shapeRotationY;
String title;
int chosenMovie;

void setup() {
  surface.setTitle("MOVIE MASTER");
  size(1000, 750, P3D);
  fileName = "movieClip";
  background(0);
  
  textureMode(NORMAL);
  textureWrap(REPEAT);
  menuBackground = loadImage("menubg.jpg");
  shapeTexture = loadImage("moviereel.jpg");
  menuShape = createShape(SPHERE, 20);
  menuShape.setTexture(shapeTexture);
  
  shapeRotationX = 0;
  shapeRotationY = 0;
  title = "M   VIE  MASTER";
  u = 1;
  v = 1;
  menu = 1;
  rectMode(CENTER);
  for(int i = 0; i < 3; i++){
    movies [i] = new Movie(this, "Movie"+(i+1)+".mov");
  //}
  //for(int i = 0; i < 3; i++){
    mov [i] = new Movies("Thumbnail"+(i+1)+".jpg", movies[i]);
  }
}

void draw() {
  background(0);
  fill(255, 255, 255, 0); //noFill() doesn't work?

//Starts the recording
  if (recordScreen) {
    beginRecord(PDF, fileName + ".pdf");
  }

//Title Screen
  if(menu == 1){
    ambientLight(255, 255, 255);
    directionalLight(255, 255, 255, 1, 1, -1);
    
    pushMatrix();
    
    translate(width/2, height/2, -1);
    scale(340);
    
    beginShape();
    texture(menuBackground);
    vertex(-1, -1, 1, uO, vO);
    vertex(1, -1, 1, uO + u, vO);
    vertex(1, 1, 1, uO + u, vO +v);
    vertex(-1, 1, 1, uO, vO + v);  
    endShape(CLOSE);
    
    popMatrix();
    
    fill(125, 95, 0, 255);
    textSize(40);
    text(title, width/3.02, height/2.51, 400);
    fill(165, 135, 0, 255);
    textSize(40);
    text(title, width/3.01, height/2.505, 400);
    fill(255, 215, 0, 255);
    textSize(40);
    text(title, width/3, height/2.5, 400);
    
    pushMatrix();
    translate(width/2.57, height/2.6, 400);
    shapeRotationX = shapeRotationX + PI/512;
    shapeRotationY = shapeRotationY + PI/128;
    rotateX(shapeRotationX);
    rotateY(shapeRotationY);
    noStroke();
    fill(255);
    shape(menuShape);
    popMatrix();
    
    pushMatrix();
    
    translate(width/2.7, height/2, 400);
    fill(165, 135, 0, 255);
    rect(-2, -2, 30, 30);
    fill(255, 215, 0, 255);
    rect(0, 0, 30, 30);
    
    textSize(30);
    text("Movie Select", 25, 10);
    fill(165, 135, 0, 255);
    text("Movie Select", 26, 11);
    
    popMatrix();
       
  }
//Preview Images & Movie Select  
  if(menu == 2){
    background(0);
    fill(255);
    rect(width/3, height/1.5, 300, 150);
    rect(width/1.5, height/1.5, 300, 150);
    rect(width/3, height/3, 300, 150);
    rect(width/1.5, height/3, 300, 150);
    //for loop
    //mov[0].displayThumbnail(width/3,height/2,160,300,150);
    mov[0].displayThumbnail(width/3,height/2,160,width/3-150,150);
  }
  
//Playing Movie  
  if( menu == 3){
    mov[chosenMovie].displayMovie(width,height);
    //mov[0].displayMovie(50,50);
    //mov[n].displayBackground();
    //mov[0].displayMovie();
}

//Ends the recording
  if (recordScreen) {
    endRecord();
    recordScreen = false;
  }
}

void mousePressed() {
  if ( mouseX > width/6 && mouseX < width/4 && mouseY > height/2.2 && mouseY < height/1.8 && menu == 1 ){
    menu = 2;
  }
  if ( mouseX > width/3-150 && mouseX < width/3+150 && mouseY > height/1.5-75 && mouseY < height/1.5+75 && menu == 2 ){
    chosenMovie = 0;
    menu = 3;
  }
  if ( mouseX > width/3-150 && mouseX < width/3+150 && mouseY > height/3-75 && mouseY < height/3+75 && menu == 2 ){
    chosenMovie = 2;
    menu = 3;
  }
  if ( mouseX > width/1.5-150 && mouseX < width/1.5+150 && mouseY > height/1.5-75 && mouseY < height/1.5+75 && menu == 2 ){
    chosenMovie = 1;
    menu = 3;
  }
  if ( mouseX > width/1.5-150 && mouseX < width/1.5+150 && mouseY > height/3-75 && mouseY < height/3+75 && menu == 2 ){
    chosenMovie = 3;
    menu = 3;
  }
/*
  Turns the boolean to true, which begins
  the recording process in draw.
*/
  if (mouseButton == RIGHT) {
    recordScreen = true;
  }
}
