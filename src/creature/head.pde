var BUBBLE_FORCE = 2;
var STATES = {
  IN_MIDDLE: "IN_MIDDLE",
  REVERSING: "REVERSING",
};

var Head = function(position, shouldDisplay) {
  this.shouldDisplay = shouldDisplay;
  this.position = position;
  this.velocity = new PVector(random(10), -random(10));

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
  this.velocity.limit(5);
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

