int simWidth = 160;
int simHeight = 90;

float[][] densities;

PGraphics pg;



void setup() {
  size(1600, 900);
  background(0);
  densities = new float[simWidth][simHeight];
  pg = createGraphics(simWidth, simHeight);
  pg.noSmooth();
}

boolean test = false;

void changeValue(){
  test = !test;
}

void draw() {
  frameRate(3);
  pg.beginDraw();
  pg.noStroke();
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      densities[i][j] = random(0, 255);
    }
  }

  pg.loadPixels();
  for (int i = 0; i < pg.width*pg.height; i++) {
    pg.pixels[i] = color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
  }
  pg.updatePixels();


  pg.textSize(40);
  pg.endDraw();
  PImage img = pg.get();
  img.resize(1600, 900);
  image(img, 0, 0);
  text(frameRate, 50, 50);
  fill(test ? color(0, 255, 0) : color(255, 0, 0));
  ellipse(width/2, height/2, 250, 250);
}
