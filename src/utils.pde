function monteCarlo() {
  while (true) {
    var r1 = random(1);
    var probability = r1;
    var r2 = random(1);
    if (r2 > probability) {
      return r1;
    }
  }
}

void constrainVector(a, limits, s) {
  PVector newA = a.get();
  newA.x = constrain(a.x, 0, limits.x - s);
  newA.y = constrain(a.y, 0, limits.y - s);
  newA.z = constrain(a.z, 0, limits.z - s);
  return newA;
}
