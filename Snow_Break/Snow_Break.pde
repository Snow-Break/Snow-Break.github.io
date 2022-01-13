void setup(){
  size(1000,1000);
}

void draw(){
  background(100);
  noStroke();
  fill(0);
  circle(frameCount*2%(width+250)-125, height/2, 250);
}
