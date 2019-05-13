/**
Author: Jake Fuller, Avery Walker, Chris #
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

Movies [] mov = new Movies [4];
Movie [] movie = new Movie [4];
PImage [] thumbnail = new PImage [4];
PImage menuBackground, shapeTexture;
PShape menuShape;
float u, v, uO, vO, menu, //menu determines what menu screen the user is on and what to display.
shapeRotationX, shapeRotationY;
String title;

void setup() {
  size(1000, 750, P3D);
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
    thumbnail[i] = new PImage();
    movie[i] = new Movie(this, "Trailer"+(i+1)+".mp4");
  }
  mov [0] = new Movies (thumbnail[0], movie[0]);
  mov [1] = new Movies (thumbnail[1], movie[1]);
  mov [2] = new Movies (thumbnail[2], movie[2]);
  mov [3] = new Movies (thumbnail[3], movie[3]);
}

void draw() {
  background(0);
  fill(255, 255, 255, 0); //noFill() doesn't work?

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
    rect(width/3, height/2, 300, 150);
    rect(width/1.5, height/2, 300, 150);
    //for loop
  }
  
//Playing Movie  
  if(menu == 3){
    mov[0].displayThumbnail(0,0);
    mov[0].displayMovie(50,50);
  }
}

void mousePressed() {
  if ( mouseX > width/6 && mouseX < width/4 && mouseY > height/2.2 && mouseY < height/1.8 ){
    menu = 2;
  }
}

---------------------- Separate Class ----------------------------------
import processing.video.*;
import processing.sound.*;

class Movies {
  PImage thumbnails;
  Movie movies;
  float thumbnailY, thumbnailX;
  float movieY, movieX;
  
  Movies(PImage thumbnail, Movie movie){
    thumbnails = thumbnail;
    movies = movie;
  }
  
  void displayThumbnail(float x, float y){
    thumbnailY = y;
    thumbnailX = x;
  }
  
  void displayMovie(float x, float y){
    movieY = y;
    movieX = x;
  }
}

