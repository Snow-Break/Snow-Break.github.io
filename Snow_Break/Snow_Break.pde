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

PGraphics pg;

void setup() {
  size(1600, 450);
  background(0);
  densities = new float[simWidth][simHeight];
  pg = createGraphics(simWidth, simHeight);
  pg.smooth = 0;
  pg.noSmooth();
  noSmooth();
}

boolean test = false;

void changeValue() {
  test = !test;
}

void draw() {
  pg.beginDraw();
  pg.noStroke();
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      densities[i][j] = random(0, 255);
    }
  }

  pg.loadPixels();
  for (int i = 0; i < pg.width*pg.height; i++) {
    float bright = random(255);
    //float bright = 255*noise((i%width)/10.0, (i/height)/10.0, frameCount/100.0);
    pg.pixels[i] = color(bright, bright, bright);
  }
  pg.updatePixels();
  pg.endDraw();
  PImage img = resizeNx(pg.get(), width/simWidth);
  image(img, 0, 0);
  textSize(40);
  text(frameRate, 50, 50);
  fill(test ? color(0, 255, 0) : color(255, 0, 0));
  ellipse(width/2, height/2, 250, 250);

  if (javascript != null) {
    javascript.showValue(test);
  }
}

PImage resizeNx(PImage input, int n) {
  PImage ret = new PImage(input.width*n, input.height*n);
  ret.loadPixels();
  input.loadPixels();
  int ratio = (int) ((input.width<<16)/(ret.width)) + 1;
  int x2;
  int y2;

  for (int i = 0; i < ret.height; i++) {
    for (int j = 0; j < ret.width; j++) {
      x2 = ((j*ratio)>>16);
      y2 = ((i*ratio)>>16);
      ret.pixels[(i*ret.width)+j] = input.pixels[(y2*input.width)+x2];
    }
  }
  ret.updatePixels();
  return ret;
}
