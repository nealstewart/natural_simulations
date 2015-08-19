var UPDATE_INTERVAL = 1000 / 60;

var STROKE = 0;
var WEIGHT = 0;
var FILL = 127;

var Creature = function(location, partCount, displayHead) {
  this.head = new Head(location, displayHead);

  var firstPart = new Part(this.head);
  this.parts = [firstPart]
  var prevPart = firstPart;

  for (var i = 1; i < partCount; i++) {
    var newPart = new Part(prevPart);
    prevPart = newPart;
    this.parts.push(newPart);
  }

  this.lastUpdate = Date.now();
};

Creature.prototype.update = function() {
  var that = this;

  var now = Date.now();
  if (now - this.lastUpdate < UPDATE_INTERVAL) {
    return
  }

  this.lastUpdate = now;

  this.head.update();

  this.parts.forEach(function(p) {
    p.update();
  });
};

Creature.prototype.display = function() {
  stroke(STROKE);
  strokeWeight(WEIGHT);
  fill(FILL);

  this.head.display();
  for (var i = 0, len = this.parts.length; i < len; i++) {
    this.parts[i].display();
  }
};
