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
  
  void displayThumbnail(float x, float y){
    pushMatrix();
    translate(x, y, 0);
    image(thumbnails, x, y);
    popMatrix();
  }
  
  void displayMovie(float x, float y){
    pushMatrix();
    translate(x, y, 0);
    image(movies, x, y);
    popMatrix();
  }
}
