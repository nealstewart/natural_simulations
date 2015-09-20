var WIDTH = 1000;
var HEIGHT = 1000;
var DEPTH = 1000;

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
  this.foods = [];

  var location = this.dimensions.get();
  location.div(2);

  for (var i = 0; i < 10; i++) {
    var f = new Food(getRandomLocation(this.dimensions));
    this.foods.push(f);
  }

  this.creature = new Creature(this, location, 3, false);
}

Aquarium.prototype.update = function() {
  for (var i = 0, len = this.foods.length; i < len; i++) {
    this.creature.attract(this.foods[i]);
  }

  this.creature.update();

  var newFood = [];
  for (var i = 0, len = this.foods.length; i < len; i++) {
    var f = this.foods[i];
    if (f.isAlive()) {
      newFood.push(f);
    }
  }

  this.foods = newFood;
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
  translate(-this.dimensions.x/2, -this.dimensions.y/2, -this.dimensions.z/2)

  this.creature.display();

  for (var i = 0, len = this.foods.length; i < len; i++) {
    this.foods[i].display(); 
  }

  popMatrix();
};

