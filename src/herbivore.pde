var HERBIVORE_SIZE = 10;
var HERBIVORE_COLOR = 100;
var HERBIVORE_LIFE = 100;
var HERBIVORE_STEP_SIZE = 30;

var monteCarlo = function() {
  while (true) {
    var r1 = random(1);
    var probability = r1;
    var r2 = random(1);
    if (r2 > probability) {
      return r1;
    }
  }
};

function Herbivore(position) {
  this.position = position;
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

  var xStepSize = random(-stepSize, stepSize);
  var yStepSize = random(-stepSize, stepSize);
  var zStepSize = random(-stepSize, stepSize);

  this.position.x += xStepSize;
  this.position.y += yStepSize;
  this.position.z += zStepSize;
};

Herbivore.prototype.hurt = function() {
  this.life--;
};

Herbivore.prototype.isAlive = function() {
  return this.life > 0;
};
