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

  this.head.update();

  this.parts.forEach(function(p) {
    p.update();
  });
};

Creature.prototype.display = function() {
  this.head.display();
  for (var i = 0, len = this.parts.length; i < len; i++) {
    this.parts[i].display();
  }
};
