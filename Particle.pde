// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in
//
// Coding Challenge #24: Perlin Noise Flow  Field
// https://youtu.be/BjoM9oKOAKY

public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
  color c;
  boolean gone=false;
  int trans;
   
  Particle(PVector start, float maxspeed,color col) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
    c=col;
    trans=255;
  }
  void run() {
    if(!gone){
    update();
    edges();
    show();
    }
  }
  void update() {
    trans--;
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);
  }
  void applyForce(PVector force) {
    acc.add(force); 
  }
  void show() {
    stroke(c,trans);
    strokeWeight(1);
    line(pos.x, pos.y, previousPos.x, previousPos.y);
    //point(pos.x, pos.y);
    updatePreviousPos();
  }
  void edges() {
    if (pos.x > width) {
      pos.x = 0;
      updatePreviousPos();
   trans=0;
    }
    if (pos.x < 0) {
      pos.x = width;    
      updatePreviousPos();
   trans=0;
    }
    if (pos.y > height) {
      pos.y = 0;
      updatePreviousPos();
   trans=0;
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePreviousPos();
   trans=0;
    }
  }
  void updatePreviousPos() {
    this.previousPos.x = pos.x;
    this.previousPos.y = pos.y;
  }
  void follow(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);
    int index = x + y * flowfield.cols;
    
    PVector force = flowfield.vectors[index];
    applyForce(force);
  }
}
