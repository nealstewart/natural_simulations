function Aquarium() {
  this.position = new PVector(0, 0, 0);

  this.dimensions = new PVector(1000, 500, 1000);
  var location = this.dimensions.get();
  location.div(2);

  this.creature = new Creature(location, 30, false);
}

Aquarium.prototype.update = function() {
  this.creature.update();
};

Aquarium.prototype.display = function() {
  pushMatrix();
  this.creature.display();
  popMatrix();
};
