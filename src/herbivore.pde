var HERBIVORE_SIZE = 10;
var HERBIVORE_COLOR = 100;
var HERBIVORE_LIFE = 100;
var HERBIVORE_STEP_SIZE = 30;
var HERBIVORE_SPEED_LIMIT = 8;

function Herbivore(position) {
  this.position = position;
  this.velocity = new PVector(0, 0, 0);
  this.life = HERBIVORE_LIFE;
}

Herbivore.prototype.display = function() {
  pushMatrix();
  translate(this.position.x, this.position.y, this.position.z);
  noStroke();
  fill(HERBIVORE_COLOR);
  sphere(HERBIVORE_SIZE);
  popMatrix();
};

Herbivore.prototype.update = function() {
  if (!this.isAlive()) {
    return;
  }

  var stepSize = monteCarlo() * HERBIVORE_STEP_SIZE;

  var acceleration = new PVector(
      random(-stepSize, stepSize),
      random(-stepSize, stepSize),
      random(-stepSize, stepSize)
  );

  this.velocity.add(acceleration);
  this.velocity.limit(HERBIVORE_SPEED_LIMIT);
  this.position.add(this.velocity);
};

Herbivore.prototype.hurt = function() {
  this.life--;
};

Herbivore.prototype.isAlive = function() {
  return this.life > 0;
};
