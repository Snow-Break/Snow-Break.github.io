float[][] densities;

void setup() {
  size(1000, 200);
  background(0);
  densities = new float[100][20];
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 20; j++) {
      densities[i][j] = random(0, 255);
    }
  }
}

void draw() {
  noStroke();
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 20; j++) {
      fill(densities[i][j]);
      rect(i * 10, j * 10, 10, 10);
    }
  }
}
