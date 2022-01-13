float[][] densities;

PGraphics pg;

void setup() {
  size(1000, 200);
  background(0);
  densities = new float[200][40];
  pg = createGraphics(1000, 200);
  pg.noSmooth();
}

void draw() {
  pg.beginDraw();
  pg.noStroke();
  for (int i = 0; i < 200; i++) {
    for (int j = 0; j < 40; j++) {
      densities[i][j] = random(0, 255);
    }
  }

  pg.loadPixels();
  println(pg.width*pg.height);
  for (int i = 0; i < pg.width*pg.height; i++) {
    pg.pixels[i] = color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
  }
  pg.updatePixels();


  pg.textSize(40);
  pg.text("fps: " + frameRate, 50, 50);
  pg.endDraw();
  image(pg, 0, 0);
}
