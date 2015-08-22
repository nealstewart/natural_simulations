import processing.opengl.*;

var aquarium;
var time;
var rotation;
var ROTATION_AMOUNT = 0.01;

void setup() {
	size(window.innerWidth, window.innerHeight, OPENGL);
  aquarium = new Aquarium();
  rotation = new PVector(0);

  window.addEventListener("keydown", function(e) {
      switch (e.keyIdentifier) {
        case "Down": {
          rotation.x += ROTATION_AMOUNT;
          break;
        }
        case "Up": {
          rotation.x -= ROTATION_AMOUNT;
          break;
        }
        case "Right": {
          rotation.y += ROTATION_AMOUNT;
          break;
        }
        case "Left": {
          rotation.y -= ROTATION_AMOUNT;
          break;
        }
      }
    });

}

var mousing = false;
var lastMousePosition;

void mouseDragged() {
  if (!lastMousePosition) {
    lastMousePosition = new PVector(mouseX, mouseY);
    return;
  }
  var newPos = new PVector(mouseX, mouseY);
  var diff = newPos.get();
  diff.sub(lastMousePosition);
  diff.mult(0.01);
  diff.rotate(PI/2);
  lastMousePosition = newPos;
  rotation.add(diff);
}

void mouseReleased() {
  lastMousePosition = null;
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
