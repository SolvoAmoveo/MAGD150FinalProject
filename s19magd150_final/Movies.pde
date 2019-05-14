import processing.video.*;
import processing.sound.*;

class Movies {
  PImage thumbnails;
  Movie movies;
  String movieFile;
  
  Movies(String thumbnail, Movie movie){
    thumbnails = loadImage(thumbnail);
    movies = movie;
  }
  
  void displayThumbnail(float tx, float ty, float tz, float w, float h){
    pushMatrix();
    translate(tx, ty, tz);
    image(thumbnails, w, h);
    popMatrix();
  }
  
  void displayMovie(float tx, float ty, float tz, float w, float h){
    pushMatrix();
    translate(tx,ty,tz);
    image(movies, w, h);
    movies.play();
    popMatrix();
  }
}
