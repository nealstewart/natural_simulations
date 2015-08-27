var SIZE = 10;

function Food() {
  this.position = new PVector(0, 0, 0);
}

Food.prototype.display = function() {
  pushMatrix();
  translate(this.position.x, this.position.y, this.position.z);
  noStroke();
  fill(100);
  sphere(SIZE);
  popMatrix();
};
