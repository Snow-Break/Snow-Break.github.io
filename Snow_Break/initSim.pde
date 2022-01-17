float tau = 0.51f;    // time discretization
float lambda = 0.51f; // space discretization
float c = lambda/tau; // resulting maximum valocity

float lambdaSquared = lambda * lambda; // precompute this
float smagorinskyConstant = 0.3f;      // magic number lel
float scSquared = smagorinskyConstant * smagorinskyConstant;

PVector[] unitVelocities;             // 9 directions/velocities (moore neighborhood)
float[][][] distributions;            // particle amounts in each cell and each direction
float[][][] equilibriumDistributions; // desired particle amounts
float[][] densities;                  // density at each cell
PVector[][] velocities;               // avg valocity per cell

int simWidth = 320;    // simulation domain
int simHeight = 90;    // simulation domain
PImage sim;            // we probably don't need this...
PImage disp;           // image for displaying the simulation output

// initialize all the necessary arrays
void init(){
  initUnitVelocities();
  initDistributions();
  initDensities();
  initVelocities();
  initEquilibriumDistributions();
}

// initialize the moore-neighborhood directions/velocities
void initUnitVelocities(){
  unitVelocities = new PVector[9];
  unitVelocities[0] = new PVector(0, 0);
  unitVelocities[1] = new PVector(1, 0);
  unitVelocities[2] = new PVector(0, 1);
  unitVelocities[3] = new PVector(-1, 0);
  unitVelocities[4] = new PVector(0, -1);
  unitVelocities[5] = new PVector(1, 1);
  unitVelocities[6] = new PVector(-1, 1);
  unitVelocities[7] = new PVector(-1, -1);
  unitVelocities[8] = new PVector(1, -1);
}

// give an initial particle distribution
void initDistributions() {
  distributions = new float[simWidth][simHeight][9];
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      for (int k = 0; k < 9; k++) {
        distributions[i][j][k] = 10*abs(sin(TWO_PI*((i+1)*(j+1))/(simWidth*simHeight))) + 20;
      }
    }
  }
  for (int i = 55; i < 60; i++) {
    for (int j = 55; j < 70; j++) {
      for (int k = 0; k < 9; k++) {
        distributions[i][j][k] = 100;
      }
    }
  }
}

// initialize densities
void initDensities() {
  densities = new float[simWidth][simHeight];
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      float d = 0;
      for (int k = 0; k < 9; k++) {
        d += distributions[i][j][k];
      }
      densities[i][j] = d;
    }
  }
}

// initialize avg velocities
void initVelocities() {
  velocities = new PVector[simWidth][simHeight];
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      float d = densities[i][j];
      PVector weighedVelocity = new PVector(0, 0);
      for (int k = 0; k < 9; k++) {
        weighedVelocity.add(PVector.mult(unitVelocities[k], c * distributions[i][j][k]));
      }
      weighedVelocity.div(d);
      velocities[i][j] = weighedVelocity;
    }
  }
}

// initialize desired particle distribution
void initEquilibriumDistributions() {
  equilibriumDistributions = new float[simWidth][simHeight][9];
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      PVector u = velocities[i][j];
      float rho = densities[i][j];
      for (int k = 0; k < 9; k++) {
        equilibriumDistributions[i][j][k] = rho * (w(k) + s(k, u));
      }
    }
  }
}
