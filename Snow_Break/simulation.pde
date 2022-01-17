float s(int i, PVector u) {
  float component1 = PVector.dot(unitVelocities[i], u) * 3.0f / c;
  float component2 = (PVector.dot(unitVelocities[i], u) * PVector.dot(unitVelocities[i], u) * 9) / (2 * c * c);
  float component3 = (PVector.dot(u, u) * 3) / (2 * c * c);
  return (w(i) * (component1 + component2 - component3));
}

float w(int i) {
  if (i == 0) {
    return 4.0f/9.0f;
  } else if (i < 5) {
    return 1.0f/9.0f;
  } else {
    return 1.0f/36.0f;
  }
}

// move particles
void stream() {
  float[][][] newDistributions = new float[simWidth][simHeight][9];
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      for (int k = 0; k < 9; k++) {
        PVector e = unitVelocities[k];
        int xDir = (int) e.x;
        int yDir = (int) e.y;
        int newi = i + xDir;
        int newj = j + yDir;

        if (newi == simWidth) {
          newi = 0;
        }
        if (newi == -1) {
          newi = simWidth - 1;
        }

        if (newj == simHeight) {
          newj = 0;
        }
        if (newj == -1) {
          newj = simHeight - 1;
        }

        newDistributions[newi][newj][k] += distributions[i][j][k];
      }
    }
  }
  distributions = newDistributions;
}

// relax some particles back to their equilibrium
void collide() {
  for (int i = 0; i < simWidth; i++) {
    for (int j = 0; j < simHeight; j++) {
      for (int k = 0; k < 9; k++) {
        float localStress = unitVelocities[k].x * unitVelocities[k].y * (distributions[i][j][k] - equilibriumDistributions[i][j][k]);
        float localStressTensorMagnitude = (-tau + sqrt(tau * tau + 18 * lambdaSquared * scSquared * abs(localStress))) / (6 * lambda * lambda * smagorinskyConstant * smagorinskyConstant);
        float correctedTau = tau + 3 * lambdaSquared * scSquared * localStressTensorMagnitude;
        distributions[i][j][k] = distributions[i][j][k] - (1.0f/correctedTau) * (distributions[i][j][k] - equilibriumDistributions[i][j][k]);
      }
    }
  }
}


// calculate densities
void calcDensities() {
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

// calculate avg velocities
void calcVelocities() {
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

// calculate desired particle distribution
void calcEquilibriumDistributions() {
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
