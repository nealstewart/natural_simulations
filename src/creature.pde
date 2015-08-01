var STATES = {
  IN_MIDDLE: "IN_MIDDLE",
  REVERSING: "REVERSING",
};

var BUBBLE_FORCE = 0.5;

var BEHIND_ADJUSTMENT = 5;

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
  ellipse(this.position.x, this.position.y, 48, 48);
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

var PART_SIZE = 5;
var Part = function(leader) {
  this.leader = leader;
  this.position = getPositionBehind(leader.position, leader.velocity); 
  this.acceleration = new PVector(0, 0);
  this.velocity = this.getInitialVelocity();
  this.resetForces();
};

// TODO: Make this perpendicular to the velocity of the leader.
Part.prototype.getInitialVelocity = function() {
  return new PVector(-20, 0)
};

var SPRING_CONSTANT = 0.10;
Part.prototype.getSpringForce = function() {
  var acc = PVector.sub(this.leader.position, this.position);
  
  acc.mult(SPRING_CONSTANT);

  return acc;
};

Part.prototype.resetForces = function() {
  this.forces = [];
};

Part.prototype.addLeaderForce = function() {
  this.forces.push(this.getSpringForce());
};

var BOUNCE_FORCE = 5;

Part.prototype.bounce = function(p) {
  if (this === p) {
    return;
  }

  var dist = PVector.sub(this.position, p.position);

  if (dist.mag() < PART_SIZE) {
    var repulsion = dist.get();
    repulsion.normalize();
    repulsion.mult(BOUNCE_FORCE);

    p.forces.push(repulsion);
  }
};

Part.prototype.update = function() {
  var that = this;

  this.forces.forEach(function(f) {
    that.velocity.add(f);
  });

  this.velocity.limit(20);

  this.position.add(this.velocity);
};

Part.prototype.display = function() {
  ellipse(this.position.x, this.position.y, PART_SIZE, PART_SIZE);
};

var Creature = function() {
  this.head = new Head(new PVector(500/2, 500/2));

  this.parts = [new Part(this.head)]
  var prevPart = this.parts[0];

  for (var i = 0; i < 300; i++) {
    var newPart = new Part(prevPart);
    prevPart = newPart;
    this.parts.push(newPart);
  }

  this.lastUpdate = Date.now();
};

var UPDATE_AMOUNT = 1000 / 70;
Creature.prototype.update = function() {
  var that = this;

  var now = Date.now();

  if (now - this.lastUpdate < UPDATE_AMOUNT) {
    return
  }

  this.lastUpdate = now;

  this.head.update();

  this.parts.forEach(function(p) {
    p.resetForces();
    p.addLeaderForce();

    that.parts.forEach(function(otherP) {
      p.bounce(otherP);
    });

    p.update();
  });
};

Creature.prototype.display = function() {
  stroke(0);
  strokeWeight(2);
  fill(127);

  this.head.display();
  for (var i = 0, len = this.parts.length; i < len; i++) {
    this.parts[i].display();
  }
};

var creature = new Creature();

var creatureDraw = function() {
  background(255, 255, 255);
  creature.update();
  creature.display(); 
};

