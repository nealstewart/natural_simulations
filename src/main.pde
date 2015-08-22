import processing.opengl.*;

var creature;
var time;

void setup() {
	size(window.innerWidth, window.innerHeight, OPENGL);
  var location = new PVector(width/2, height/2);
  creature = new Creature(location, 30, false);
}

void draw() {
  if (!time) {
    time = new Time();
    window.superTime = time;
  }
  background(255, 255, 255);

  var steps = time.getSteps();

  for (var i = 0; i < steps; i++) {
    creature.update();
  }

  creature.display();
}
