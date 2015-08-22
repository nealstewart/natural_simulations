var BEHIND_ADJUSTMENT = 2;
var PART_SIZE = 5;
var BOUNCE_FORCE = 5;
var SPRING_CONSTANT = 0.2;

// distance units per tick
var MAX_SPEED = 6;

var STROKE = 0;
var WEIGHT = 0;
var FILL = 127;

var Part = function(leader) {
  this.leader = leader;
  this.position = getPositionBehind(leader.position, leader.velocity);
  this.acceleration = new PVector(0, 0);
  this.velocity = this.getInitialVelocity();
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

  that.velocity.add(this.getSpringForce());

  this.velocity.limit(MAX_SPEED);

  this.position.add(this.velocity);
};

Part.prototype.display = function() {
  pushMatrix();
  translate(this.position.x, this.position.y, this.position.z);
  noStroke();
  fill(204, 0);
  sphere(3);
  popMatrix();
};

function getPositionBehind(position, velocity) {
  var position = position.get()
  var diff = velocity.get();
  diff.mult(BEHIND_ADJUSTMENT);
  position.sub(diff);
  return position;
}

