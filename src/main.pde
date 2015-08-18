var creature;

void setup() {
	size(window.innerWidth, window.innerHeight);
  var location = new PVector(width/2, height/2);
  creature = new Creature(location, 400, false);
}

void draw() {
  background(255, 255, 255);
  creature.update();
  creature.display();
}
