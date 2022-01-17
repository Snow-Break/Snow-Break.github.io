float tau = 0.51f;    // time discretization
float lambda = 0.51f; // space discretization
float c = lambda/tau; // resulting maximum valocity

float lambdaSquared = lambda * lambda; // precompute this
float smagorinskyConstant = 0.3f;      // magic number
float scSquared = smagorinskyConstant * smagorinskyConstant;
