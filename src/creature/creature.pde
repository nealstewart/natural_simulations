var CREATURE_STATES = {
  EATING: "EATING"
};

var Creature = function(aquarium, location, partCount, displayHead) {
  this.state = CREATURE_STATES.EATING;
  this.attractor = null;
  this.head = new Head(aquarium, location, displayHead);
  this.parts = makeParts(this.head, partCount);
  this.lastUpdate = Date.now();
};

function makeParts(head, partCount) {
  var firstPart = new Part(head);
  var parts = [firstPart];

  var prevPart = firstPart;

  for (var i = 1; i < partCount; i++) {
    var newPart = new Part(prevPart);
    prevPart = newPart;
    parts.push(newPart);
  }

  return parts;
}

Creature.prototype.update = function() {
  var that = this;

  this.head.update(this.attractor.food);

  if (!this.attractor.food.isAlive()) {
    this.parts.push(new Part(this.parts[this.parts.length - 1]));
  }

  this.parts.forEach(function(p) {
    p.update();
  });

  this.attractor = null;
};

Creature.prototype.attract = function(f) {
  var dis = this.head.position.dist(f.position);
  if (!this.attractor || this.attractor.dis > dis) {
    this.attractor = {
      food: f,
      dis: dis
    };
  }
};

Creature.prototype.display = function() {
  this.head.display();
  var c = this.head.getColor();
  for (var i = 0, len = this.parts.length; i < len; i++) {
    this.parts[i].display(c);
  }
};
