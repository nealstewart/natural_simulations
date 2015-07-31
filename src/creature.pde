var Creature = function() {
  this.position = new PVector(width/2, height/2);
  this.springPosition = this.position.get(); 
  this.velocity = new PVector(-20, 0);
  this.acceleration = new PVector(0, 0);
};

var SPRING_CONSTANT = 0.05;

Creature.prototype.getSpringForce = function() {
  var acc = PVector.sub(this.springPosition, this.position);
  
  acc.mult(SPRING_CONSTANT);

  return acc;
};

Creature.prototype.update = function() {
  this.acceleration = this.getSpringForce();
  this.velocity.add(this.acceleration);
  this.velocity.limit(5);
  this.position.add(this.velocity);
};

Creature.prototype.display = function() {
  stroke(0);
  strokeWeight(2);
  fill(127);
  ellipse(this.position.x, this.position.y, 48, 48);
};

Creature.prototype.checkEdges = function() {
  if (this.position.x > width) {
    this.position.x = 0;
  } else if (this.position.x < 0) {
    this.position.x = width;
  }

  if (this.position.y > height) {
    this.position.y = 0;
  } else if (this.position.y < 0) {
    this.position.y = height;
  }
};

var creature = new Creature();

var creatureDraw = function() {
  background(255, 255, 255);

  creature.update();
  creature.checkEdges();
  creature.display(); 
};
