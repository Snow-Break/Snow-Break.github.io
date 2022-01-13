float[][] densities;

void setup() {
  size(1000, 200);
  background(0);
  densities = new float[200][40];
  for (int i = 0; i < 200; i++) {
    for (int j = 0; j < 40; j++) {
      densities[i][j] = random(0, 255);
    }
  }
}

void draw() {
  noStroke();
  for (int i = 0; i < 200; i++) {
    for (int j = 0; j < 40; j++) {
      densities[i][j] = random(0, 255);
    }
  }
  for (int i = 0; i < 200; i++) {
    for (int j = 0; j < 40; j++) {
      fill(densities[i][j]);
      rect(i * 5, j * 5, 5, 5);
    }
  }
  fill(255, 0, 0);
  textSize(40);
  text("fps: " + frameRate, 50, 50);
}
