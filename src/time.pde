var TICKS_PER_SECOND = 60;
var TIME_STEP = floor(1000 / TICKS_PER_SECOND);

function Time() {
  this.epoch = Date.now();
  this.lastUpdate = this.epoch;
}

Time.prototype.getSteps = function() {
  var now = Date.now();
  var thisStep = floor((now - this.epoch) / TIME_STEP);
  var lastStep = floor((this.lastUpdate - this.epoch) / TIME_STEP);
  var steps = thisStep - lastStep;

  this.lastUpdate = now;
  return steps;
};

