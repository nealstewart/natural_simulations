var Creature = function() {
  this.position = new PVector(500/2, 500/2);
  this.velocity = new PVector(-20, 0);
  this.acceleration = new PVector(0, 0);

  this.springPosition = this.position.get(); 
  this.springVelocity = new PVector(0, -0.5);

  this.downForce = new PVector(0, 4);
};

var SPRING_CONSTANT = 0.05;

Creature.prototype.getSpringForce = function() {
  var acc = PVector.sub(this.springPosition, this.position);
  
  acc.mult(SPRING_CONSTANT);

  return acc;
};

Creature.prototype.getForces = function() {
  return [
    this.getSpringForce()
  ];
};

Creature.prototype.update = function() {
  var that = this;
  this.getForces().forEach(function(f) {
      that.velocity.add(f);
  });
  this.velocity.limit(10);

  this.springPosition.add(this.springVelocity);

  this.position.add(this.velocity);
};

Creature.prototype.display = function() {
  stroke(0);
  strokeWeight(2);
  fill(127);
  ellipse(this.position.x, this.position.y, 48, 48);
};

Creature.prototype.checkEdges = function() {
  if (this.springPosition.x > width) {
    this.springPosition.x = 0;
  } else if (this.springPosition.x < 0) {
    this.springPosition.x = width;
  }

  if (this.springPosition.y > height) {
    this.springPosition.y = 0;
  } else if (this.springPosition.y < 0) {
    this.springPosition.y = height;
  }

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
