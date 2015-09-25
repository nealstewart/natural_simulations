var RED = color(255, 0, 0);
var GRAY = color(128, 128, 128);

var HEAD_MAX_SPEED = 5;
var HEAD_ATTRACTION_ADJUSTMENT = 10;
var HEAD_SIZE = 10;

var STATES = {
  IN_MIDDLE: "IN_MIDDLE",
  REVERSING: "REVERSING"
};

var Head = function(aquarium, position, shouldDisplay) {
  this.aquarium = aquarium;
  this.shouldDisplay = shouldDisplay;
  this.position = position;
  this.velocity = new PVector(0,0,0);
  this.size = HEAD_SIZE;
};

Head.prototype.getAttraction = function(attractor) {
  if (!attractor) {
    return new PVector(0, 0, 0);
  }
  var myPos = this.position.get();
  var force = attractor.position.get();
  force.sub(myPos);
  force.normalize();
  force.mult(HEAD_ATTRACTION_ADJUSTMENT);
  return force;
}

Head.prototype.update = function(attractor) {
  var distance = this.position.dist(attractor.position);

  if (distance < 10) {
    this.velocity = new PVector(0, 0, 0);
    attractor.hurt();

  } else {
    this.velocity.add(this.getAttraction(attractor));
    this.velocity.limit(HEAD_MAX_SPEED);
    this.position.add(this.velocity);
  }
};

Head.prototype.getColor = function() {
  return GRAY;
};

Head.prototype.display = function() {
  pushMatrix();
  translate(this.position.x, this.position.y, this.position.z);
  fill(this.getColor());
  sphere(HEAD_SIZE);
  popMatrix();
};
