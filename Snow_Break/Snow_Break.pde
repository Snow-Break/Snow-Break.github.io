interface JavaScript {
  void showValue(boolean val);
}
void bindJavaScript(JavaScript js) {
  javascript = js;
}
JavaScript javascript;



void setup() {
  size(1600, 450);
  background(0);
  sim = new PImage(simWidth, simHeight);
  disp = new PImage(width, height);
  noSmooth();

  init();
}

// test function to be triggered from the website via JavaScript
boolean test = false;
void changeValue() {
  test = !test;
}


// display the simulation
void show() {
  sim.loadPixels();
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      int mappedDensity = (int)map(densities[i][j]*densities[i][j], 0, 1500000, 0, 255);
      sim.pixels[xywToI(i, j, simWidth)] = color(mappedDensity, mappedDensity, mappedDensity);
      //sim.pixels[xywToI(i, j, simWidth)] = color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
    }
  }
  sim.updatePixels();
}

void draw() {
  show();
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

  stream();
  initDensities();
  initVelocities();
  initEquilibriumDistributions();
  collide();
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

int xywToI(int x, int y, int w) {
  return y * w + x;
}
