var WIDTH = 4000;
var HEIGHT = 1000;
var DEPTH = 3000;

var DISABLE_CRAETURE = false;
var AQUARIUM_DIMENSIONS = new PVector(WIDTH, HEIGHT, DEPTH)

function getMiddle() {
  var dim = AQUARIUM_DIMENSIONS.get();
  dim.div(2);
  return dim;
}

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
  this.herbivores = this._createHerbivores();
  this.creature = new Creature(this, getMiddle(), 3, false);
}

Aquarium.prototype._createHerbivores = function() {
  var herbs = [];

  for (var i = 0; i < 10; i++) {
    herbs.push(new Herbivore(getRandomLocation(AQUARIUM_DIMENSIONS)));
  }

  return herbs;
};

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
    h.update();
  }

  for (var i = 0, len = this.herbivores.length; i < len; i++) {
    var h = this.herbivores[i];
    if (h.isAlive()) {
      newFood.push(h);
    }

    var child = h.breed();

    if (child) {
      newFood.push(child);
    }
  }

  return newFood;
};

Aquarium.prototype.update = function() {
  this._updateCreature();
  this.herbivores = this._updateFood();
};

Aquarium.prototype.display = function() {
  pushMatrix();
  box(AQUARIUM_DIMENSIONS.x, AQUARIUM_DIMENSIONS.y, AQUARIUM_DIMENSIONS.z);

  // Translate into the coordinate system of the box.
  translate(-AQUARIUM_DIMENSIONS.x/2, -AQUARIUM_DIMENSIONS.y/2, -AQUARIUM_DIMENSIONS.z/2);

  if (!DISABLE_CRAETURE) {
    this.creature.display();
  }

  for (var i = 0, len = this.herbivores.length; i < len; i++) {
    this.herbivores[i].display(); 
  }

  var things = [this.creature.head].concat(this.creature.parts).concat(this.herbivores);

  for (var i = 0, len = things.length; i < len; i++) {
    var thing = things[i];
    thing.position = constrainVector(thing.position, AQUARIUM_DIMENSIONS, thing.size);
  }

  popMatrix();
};

function getRandomLocation(dimensions) {
  var position = new PVector(
      floor(random(0, dimensions.x)),
      floor(random(0, dimensions.y)),
      floor(random(0, dimensions.z))
  );
  return position;
}

function createHerbivores(dimensions) {
  var herbs = [];
  var location = dimensions.get();
  location.div(2);

  for (var i = 0; i < 10; i++) {
    var h = new Herbivore(getRandomLocation(dimensions));
    herbs.push(h);
  }

  return herbs;
}
