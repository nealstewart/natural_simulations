import processing.opengl.*;

var aquarium;
var time;
var rotation;

void setup() {
	size(window.innerWidth, window.innerHeight, OPENGL);
  aquarium = new Aquarium();
  rotation = new PVector(0);
  window.addEventListener("keydown", function(e) {
      switch (e.keyIdentifier) {
        case "Down": {
          rotation.x += 0.1;
          break;
        }
        case "Up": {
          rotation.x -= 0.1;
          break;
        }
        case "Right": {
          rotation.y += 0.1;
          break;
        }
        case "Left": {
          rotation.y -= 0.1;
          break;
        }
      }
    });
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

  pushMatrix();
  translate(100, 200, -1000)
  aquarium.display(rotation);
  popMatrix();
}
