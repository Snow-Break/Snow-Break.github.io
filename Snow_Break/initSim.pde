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
PVector[][] velocities;               // ...?

int simWidth = 320;    // simulation domain
int simHeight = 90;    // simulation domain
PImage sim;            // we probably don't need this...
PImage disp;           // image for displaying the simulation output
