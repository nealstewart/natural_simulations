function Plant() {
  this.parts = [
    new PVector(0, 0),
    new PVector(100, 100),
    new PVector(300, 200)
  ];
}

Plant.prototype.update = function() {
  // TODO
};

Plant.prototype.moveDown = function() {
  for (var i = 0, len = this.parts.length; i < len; i++) {
    this.parts[i].add(new PVector(200, 200));
  }
};

function drawCylinderBetween(a, b) {
  translate(a.x, a.y, a.z);
  var diff = b.get();
  diff.sub(a);
  translate(diff.x/2, diff.y/2, diff.z/2)
  face(b, a);
  var dist = b.dist(a);
  drawCylinder(30, 10, dist);
}

Plant.prototype.display = function() {
  pushMatrix();
  stroke(0);
  fill(0, 100, 0);
  var lastPart = this.parts[0];
  for (var i = 1, len = this.parts.length; i < len; i++) {
    var thisPart = this.parts[i];
    context(function() {
      drawCylinderBetween(lastPart, thisPart);
      lastPart = thisPart;
    });
  }
  popMatrix();
};
