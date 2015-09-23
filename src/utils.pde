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
