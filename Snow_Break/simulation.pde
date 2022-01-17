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
