var STATES = {
  IN_MIDDLE: "IN_MIDDLE",
  REVERSING: "REVERSING",
};

var BUBBLE_FORCE = 0.5;

var BEHIND_ADJUSTMENT = 100;

function getPositionBehind(position, velocity) {
  var position = position.get()
  var diff = velocity.get();
  diff.mult(BEHIND_ADJUSTMENT);
  position.sub(diff);
  return position;
}

var Head = function(position) {
  this.position = position; 
  this.velocity = new PVector(0.5, -0.5);

  this.x = {
    acceleration: new PVector(0, 0),
    state: STATES.IN_MIDDLE
  };

  this.y = {
    acceleration: new PVector(0, 0),
    state: STATES.IN_MIDDLE
  };
};

Head.prototype.update = function() {
  this.velocity.add(this.x.acceleration);
  this.velocity.add(this.y.acceleration);
  this.velocity.limit(3);
  this.position.add(this.velocity);
  this.checkEdges();
};

Head.prototype.display = function() {
  //ellipse(this.position.x, this.position.y, 48, 48);
};

Head.prototype.checkEdges = function() {
  if (this.x.state == STATES.IN_MIDDLE) {
    if (this.position.x > width) {
      this.x.state = STATES.REVERSING;
      this.x.acceleration = new PVector(-BUBBLE_FORCE, 0);
    } else if (this.position.x < 0) {
      this.x.state = STATES.REVERSING;
      this.x.acceleration = new PVector(BUBBLE_FORCE, 0);
    }
  } else if (this.x.state == STATES.REVERSING) {
    if (this.position.x < width && this.position.x >= 0) {
      this.x.state = STATES.IN_MIDDLE;
      this.x.acceleration = new PVector(0, 0);
    }
  }

  if (this.y.state == STATES.IN_MIDDLE) {
    if (this.position.y > height) {
      this.y.state = STATES.REVERSING;
      this.y.acceleration = new PVector(0, -BUBBLE_FORCE);
    } else if (this.position.y < 0) {
      this.y.state = STATES.REVERSING;
      this.y.acceleration = new PVector(0, BUBBLE_FORCE);
    }
  } else if (this.y.state == STATES.REVERSING) {
    if (this.position.y < height && this.position.y >= 0) {
      this.y.state = STATES.IN_MIDDLE;
      this.y.acceleration = new PVector(0, 0);
    }
  }
};

var Creature = function() {
  this.head = new Head(new PVector(500/2, 500/2));

  this.position = getPositionBehind(this.head.position, this.head.velocity); 
  this.velocity = this.getInitialVelocity();
  this.acceleration = new PVector(0, 0);

  this.downForce = new PVector(0, 4);
};

// TODO: Make this perpendicular to the velocity of the head.
Creature.prototype.getInitialVelocity = function() {
  return new PVector(-20, 0)
};

var SPRING_CONSTANT = 0.10;

Creature.prototype.getSpringForce = function() {
  var acc = PVector.sub(this.head.position, this.position);
  
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

  this.head.update();

  this.getForces().forEach(function(f) {
      that.velocity.add(f);
  });

  this.velocity.limit(20);

  this.position.add(this.velocity);
};

Creature.prototype.display = function() {
  stroke(0);
  strokeWeight(2);
  fill(127);
  ellipse(this.position.x, this.position.y, 48, 48);
  this.head.display();
};


var creature = new Creature();

var creatureDraw = function() {
  background(255, 255, 255);
  creature.update();
  creature.display(); 
};

