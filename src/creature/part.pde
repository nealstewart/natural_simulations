var BEHIND_ADJUSTMENT = 2;
var PART_SIZE = 5;
var BOUNCE_FORCE = 5;
var SPRING_CONSTANT = 0.2;

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

// XXX: Not done yet.
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

  this.resetForces();
  this.addLeaderForce();

  this.forces.forEach(function(f) {
    that.velocity.add(f);
  });

  this.velocity.limit(20);

  this.position.add(this.velocity);
};

Part.prototype.display = function() {
  var diff = PVector.sub(this.leader.position, this.position);
  line(this.leader.position.x, this.leader.position.y, this.position.x, this.position.y);
};

function getPositionBehind(position, velocity) {
  var position = position.get()
  var diff = velocity.get();
  diff.mult(BEHIND_ADJUSTMENT);
  position.sub(diff);
  return position;
}

