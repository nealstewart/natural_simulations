var BEHIND_ADJUSTMENT = 5;

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

function getPositionBehind(position, velocity) {
  var position = position.get()
  var diff = velocity.get();
  diff.mult(BEHIND_ADJUSTMENT);
  position.sub(diff);
  return position;
}

