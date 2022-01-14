interface JavaScript {
  void showValue(boolean val);
}
void bindJavaScript(JavaScript js) {
  javascript = js;
}
JavaScript javascript;

int simWidth = 320;
int simHeight = 90;
float[][] densities;
PImage sim;
PImage disp;

void setup() {
  size(1600, 450);
  background(0);
  densities = new float[simWidth][simHeight];
  sim = new PImage(simWidth, simHeight);
  disp = new PImage(width, height);
  noSmooth();
}

// test function to be triggered from the website via JavaScript
boolean test = false;
void changeValue() {
  test = !test;
}

void draw() {
  sim.loadPixels();
  for (int i = 0; i < sim.width*sim.height; i++) {
    //float bright = random(255);
    float bright = 255*noise((i%sim.width)/10.0, (i/sim.width)/10.0, frameCount/100.0);
    sim.pixels[i] = color(bright, bright, bright);
  }
  sim.updatePixels();
  resizeNx(sim, width/simWidth);
  image(disp, 0, 0);
  textSize(40);
  text(frameRate, 50, 50);
  fill(test ? color(0, 255, 0) : color(255, 0, 0));
  ellipse(width/2, height/2, 250, 250);

  if (javascript != null) {
    javascript.showValue(test); // triggers JS on the website
    // the "showValue" function does not exist within the sketch
    // but within the website that this sketch runs on
  }
}

void resizeNx(PImage input, int n) {
  disp.loadPixels();
  input.loadPixels();
  int ratio = (int) ((input.width<<16)/(disp.width)) + 1;
  int x2;
  int y2;

  for (int i = 0; i < disp.height; i++) {
    for (int j = 0; j < disp.width; j++) {
      x2 = ((j*ratio)>>16);
      y2 = ((i*ratio)>>16);
      disp.pixels[(i*disp.width)+j] = input.pixels[(y2*input.width)+x2];
    }
  }
  disp.updatePixels();
}
