var WIDTH = 1000;
var HEIGHT = 1000;
var DEPTH = 1000;

function Aquarium() {
  this.position = new PVector(0, 0, 0);
  this.dimensions = new PVector(WIDTH, HEIGHT, DEPTH);
  var location = this.dimensions.get();
  location.div(2);

  this.creature = new Creature(this, location, 50, false);
}

Aquarium.prototype.update = function() {
  this.creature.update();
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

  popMatrix();
};

