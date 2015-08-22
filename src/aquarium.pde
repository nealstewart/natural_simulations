function Aquarium() {
  this.position = new PVector(0, 0, 0);
  this.dimensions = new PVector(1000, 500, 1000);
  var location = this.dimensions.get();
  location.div(2);

  this.creature = new Creature(this, location, 30, false);
}

Aquarium.prototype.update = function() {
  this.creature.update();
};

Aquarium.prototype.display = function(rotation) {
  pushMatrix();
  rotateX(rotation.x); 
  rotateY(rotation.y); 
  stroke(125);
  noFill();
  box(this.dimensions.x, this.dimensions.y, this.dimensions.z);
  translate(-this.dimensions.x/2, -this.dimensions.y/2, -this.dimensions.z/2)
  this.creature.display();
  popMatrix();
};
