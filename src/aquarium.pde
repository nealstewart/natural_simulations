var WIDTH = 1000;
var HEIGHT = 1000;
var DEPTH = 1000;

var DISABLE_CRAETURE = true;

function getRandomLocation(dimensions) {
  var position = new PVector(
      floor(random(0, dimensions.x)),
      floor(random(0, dimensions.y)),
      floor(random(0, dimensions.z))
  );
  return position;
}

function Aquarium() {
  this.position = new PVector(0, 0, 0);
  this.dimensions = new PVector(WIDTH, HEIGHT, DEPTH);
  this.herbivores = [];

  var location = this.dimensions.get();
  location.div(2);

  for (var i = 0; i < 10; i++) {
    var h = new Herbivore(getRandomLocation(this.dimensions));
    this.herbivores.push(h);
  }

  this.creature = new Creature(this, location, 3, false);
}

Aquarium.prototype._updateCreature = function() {
  if (DISABLE_CRAETURE) {
    return;
  }

  for (var i = 0, len = this.herbivores.length; i < len; i++) {
    this.creature.attract(this.herbivores[i]);
  }

  this.creature.update();
};

Aquarium.prototype._updateFood = function() {
  var newFood = [];
  for (var i = 0, len = this.herbivores.length; i < len; i++) {
    var h = this.herbivores[i];
    if (h.isAlive()) {
      newFood.push(h);
    }
  }

  return newFood;
};

Aquarium.prototype.update = function() {
  this._updateCreature();

  this.herbivores = this._updateFood();
};

Aquarium.prototype.display = function(rotation) {
  pushMatrix();
  background(255, 255, 255);

  translate(window.innerWidth/2, window.innerHeight/2);
  translate(0, 0, -1000)

  rotateX(rotation.x); 
  rotateY(rotation.y); 

  stroke(125);
  noFill();
  box(this.dimensions.x, this.dimensions.y, this.dimensions.z);

  // Translate into the coordinate system of the box.
  translate(-this.dimensions.x/2, -this.dimensions.y/2, -this.dimensions.z/2);

  if (!DISABLE_CRAETURE) {
    this.creature.display();
  }

  for (var i = 0, len = this.herbivores.length; i < len; i++) {
    this.herbivores[i].display(); 
  }

  popMatrix();
};

