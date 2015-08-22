import processing.opengl.*;

var aquarium;
var time;

void setup() {
	size(window.innerWidth, window.innerHeight, OPENGL);
  aquarium = new Aquarium();
}

void draw() {
  if (!time) {
    time = new Time();
    window.superTime = time;
  }
  background(255, 255, 255);

  var steps = time.getSteps();

  for (var i = 0; i < steps; i++) {
    aquarium.update();
  }

  aquarium.display();
}
