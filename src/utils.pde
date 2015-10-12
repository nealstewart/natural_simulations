function context(fn) {
  pushMatrix();
  fn();
  popMatrix();
}

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

function lineBetween(a, b) {
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}

function face(src, dest) {
  var diff = dest.get();
  diff.sub(src);

  var az = atan2(-diff.x, -diff.z);
  rotateY(az);

  var alt = atan2(diff.y, sqrt(diff.x * diff.x + diff.z * diff.z));
  rotateX(alt);
}
