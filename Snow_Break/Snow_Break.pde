float[][] densities;

PGraphics pg;

void setup() {
  size(1000, 200);
  background(0);
  densities = new float[200][40];
  pg = createGraphics(1000, 200);
}

void draw() {
  pg.beginDraw();
  pg.noStroke();
  for (int i = 0; i < 200; i++) {
    for (int j = 0; j < 40; j++) {
      densities[i][j] = random(0, 255);
    }
  }
  for (int i = 0; i < 200; i++) {
    for (int j = 0; j < 40; j++) {
      pg.fill(densities[i][j]);
      pg.rect(i * 5, j * 5, 5, 5);
    }
  }
  pg.fill(255, 0, 0);
  pg.textSize(40);
  pg.text("fps: " + frameRate, 50, 50);
  pg.endDraw();
  image(pg, 0, 0);
}
