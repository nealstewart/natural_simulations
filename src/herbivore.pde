var SIZE = 10;
var COLOR = 100;
var LIFE = 100;

function Herbivore(position) {
  this.position = position;
  this.life = LIFE;
}

Herbivore.prototype.display = function() {
  pushMatrix();
  translate(this.position.x, this.position.y, this.position.z);
  noStroke();
  fill(COLOR);
  sphere(SIZE);
  popMatrix();
};

Herbivore.prototype.hurt = function() {
  this.life--;
};

Herbivore.prototype.isAlive = function() {
  return this.life > 0;
};
