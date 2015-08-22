var BUBBLE_FORCE = 2;
var MAX_SPEED = 5;

var STATES = {
  IN_MIDDLE: "IN_MIDDLE",
  REVERSING: "REVERSING"
};

function randomVelocity() {
  var vector = new PVector(MAX_SPEED, 0);
  vector.rotate(random(2 * PI));
  return vector;
}

var STATE_A = {
  acceleration: 0,
  state: STATES.IN_MIDDLE
};

var STATE_B = {
  state: STATES.REVERSING,
  acceleration: -BUBBLE_FORCE
};

var STATE_C = {
  state: STATES.REVERSING,
  acceleration: BUBBLE_FORCE
};

var Head = function(aquarium, position, shouldDisplay) {
  this.aquarium = aquarium;
  this.shouldDisplay = shouldDisplay;
  this.position = position;
  this.velocity = randomVelocity();

  this.x = STATE_A;
  this.y = STATE_A;
};

Head.prototype.update = function() {
  var bubble = new PVector(this.x.acceleration, this.y.acceleration);
  this.velocity.add(bubble);
  this.velocity.limit(MAX_SPEED);
  this.position.add(this.velocity);
  this.checkEdges();
};

Head.prototype.display = function() {
  if (!this.shouldDisplay) {
    return;
  }

  ellipse(this.position.x, this.position.y, 48, 48);
};

function accToKeepWithin(position, currentState, maximum) {
  var newState;
  if (currentState.state == STATES.IN_MIDDLE) {
    if (position > maximum) {
      newState = STATE_B;

    } else if (position < 0) {
      newState = STATE_C;

    } else {
      newState = currentState;
    }

  } else if (currentState.state == STATES.REVERSING) {
    if (position < maximum && position >= 0) {
      newState = STATE_A;

    } else {
      newState = currentState;
    }
  }

  return newState;
}

Head.prototype.checkEdges = function() {
  this.x = accToKeepWithin(this.position.x, this.x, this.aquarium.dimensions.x);
  this.y = accToKeepWithin(this.position.y, this.y, this.aquarium.dimensions.y);
};
