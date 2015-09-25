import processing.opengl.*;

var aquarium;
var time;
var focused = true;

void setup() {
	size(window.innerWidth, window.innerHeight, OPENGL);
  aquarium = new Aquarium();
  input = new UserInput();
}

void mouseDragged() {
  input.onMouseDrag(mouseX, mouseY);
}

void mouseReleased() {
  input.onMouseRelease();
}

void draw() {
  if (!time) {
    time = new Time();
  }

  var steps = time.getSteps();

  for (var i = 0; i < steps; i++) {
    aquarium.update();
  }

  if (!focused) {
    return;
  }

  pushMatrix();

  background(255, 255, 255);

  translate(window.innerWidth/2, window.innerHeight/2);
  translate(0, 0, -3000)

  rotateX(input.rotation.x); 
  rotateY(input.rotation.y); 

  stroke(125);
  noFill();

  aquarium.display();

  popMatrix();
}
