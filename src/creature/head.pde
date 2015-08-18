var BUBBLE_FORCE = 2;
var MAX_VELOCITY_ON_AXIS = 30
var STATES = {
  IN_MIDDLE: "IN_MIDDLE",
  REVERSING: "REVERSING"
};

function randomVelocity() {
  return new PVector(
      random(MAX_VELOCITY_ON_AXIS) - MAX_VELOCITY_ON_AXIS / 2,
      random(MAX_VELOCITY_ON_AXIS) - MAX_VELOCITY_ON_AXIS / 2
  );
}

var Head = function(position, shouldDisplay) {
  this.shouldDisplay = shouldDisplay;
  this.position = position;
  this.velocity = randomVelocity();

  this.x = {
    acceleration: 0,
    state: STATES.IN_MIDDLE
  };

  this.y = {
    acceleration: 0,
    state: STATES.IN_MIDDLE
  };
};

Head.prototype.update = function() {
  var bubble = new PVector(this.x.acceleration, this.y.acceleration);
  this.velocity.add(bubble);
  this.velocity.limit(5);
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
      newState = {
        state: STATES.REVERSING,
        acceleration: -BUBBLE_FORCE
      };

    } else if (position < 0) {
      newState = {
        state: STATES.REVERSING,
        acceleration: BUBBLE_FORCE
      };

    } else {
      newState = currentState;
    }

  } else if (currentState.state == STATES.REVERSING) {
    if (position < maximum && position >= 0) {
      newState = {
        state: STATES.IN_MIDDLE,
        acceleration: 0
      };

    } else {
      newState = currentState;
    }
  }

  return newState;
}

Head.prototype.checkEdges = function() {
  this.x = accToKeepWithin(this.position.x, this.x, width);
  this.y = accToKeepWithin(this.position.y, this.y, height);
};

