//int w=20;
//int rc;
//float inc=0.1;
////int size=600;
//void setup() {
//  size(600, 600);
//  rc=width/4;
//  background(0);
//  stroke(255);
//}

//void draw() {
//    background(0);
//    float yoff=0;
//  for (int r=0; r<rc; r++) {
//    float xoff=0;
//    for (int c=0; c<rc; c++) {
//      float angle=noise(xoff,yoff)*TWO_PI;
//      PVector vector=new PVector(0,0).fromAngle(angle).setMag(0.1);
//      pushMatrix();
//      translate(r*w,c*w);
//      rotate(vector.heading());
//      line(0,0,w,0);
//      popMatrix();
//      //fill(random(255));
//      //rect(r*w,c*w,w,w);
//      xoff+=inc;
//    }
//    yoff+=inc;
//  }
//}

// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in
//
// Coding Challenge #24: Perlin Noise Flow  Field
// https://youtu.be/BjoM9oKOAKY

PImage img;
FlowField flowfield;
ArrayList<Particle> particles;

boolean debug = false;

void setup() {
  img=loadImage("txt.jpg");
  size(2000, 213);
  image(img,0,0);
  flowfield = new FlowField(10);
  flowfield.update();

  particles = new ArrayList<Particle>();
  
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    int x=i%width;
    int y=i/width;
    PVector start = new PVector(x, y);
    color c=get(x,y);
    float bright = brightness(c);
    if(bright>5){
    particles.add(new Particle(start, random(2, 8),c));
    }
  }
  
  background(255);
  strokeWeight(5);
}

void draw() {
  background(0);
  flowfield.update();
  
  if (debug) flowfield.display();
  
  for (Particle p : particles) {
    p.follow(flowfield);
    p.run();
  }
  saveFrame("wordAnimation2/#####.jpg");
}
