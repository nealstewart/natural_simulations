var HERBIVORE_SIZE = 10;
var HERBIVORE_COLOR = 100;
var HERBIVORE_LIFE = 3;
var HERBIVORE_STEP_SIZE = 30;
var HERBIVORE_SPEED_LIMIT = 11;
var HERBIVORE_BREED_LIMIT = 1000;
var HERBIVORE_AGE_LIMIT = 2001;

function Herbivore(position) {
  this.position = position;
  this.velocity = new PVector(0, 0, 0);
  this.life = HERBIVORE_LIFE;
  this.age = 0;
  this.deathAge = floor(random(HERBIVORE_BREED_LIMIT, HERBIVORE_AGE_LIMIT));
  this.breedLimit = floor(random(HERBIVORE_BREED_LIMIT / 2, HERBIVORE_BREED_LIMIT));
  this.size = HERBIVORE_SIZE;
}

Herbivore.prototype.display = function() {
  pushMatrix();
  var adjustedPos = new PVector(
      this.position.x + HERBIVORE_SIZE,
      this.position.y + HERBIVORE_SIZE,
      this.position.z + HERBIVORE_SIZE
  );
  translate(adjustedPos.x, adjustedPos.y, adjustedPos.z);
  noStroke();
  fill(HERBIVORE_COLOR);
  sphere(HERBIVORE_SIZE);
  popMatrix();
};

Herbivore.prototype.update = function() {
  if (!this.isAlive()) {
    return;
  }

  this._moveUpdate();
  this._lifeUpdate();
};

Herbivore.prototype._moveUpdate = function() {
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

Herbivore.prototype._lifeUpdate = function() {
  this.age += 1;
};

Herbivore.prototype.breed = function() {
  if (this.age % this.breedLimit != 0) {
    return null;
  }

  var child = new Herbivore(new PVector(
    this.position.x + HERBIVORE_SIZE,
    this.position.y + HERBIVORE_SIZE,
    this.position.z + HERBIVORE_SIZE
  ));

  return child;
};

Herbivore.prototype.hurt = function() {
  this.life--;
};

Herbivore.prototype.isAlive = function() {
  return this.life > 0 && this.age < this.deathAge;
};
