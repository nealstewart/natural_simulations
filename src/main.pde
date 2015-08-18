var creature;

void setup() {
  var width = 1280;
  var height = 800;
	size(width, height);
  var location = new PVector(width/2, height/2);
  creature = new Creature(location, 40, false);
}

void draw() {
  background(255, 255, 255);
  creature.update();
  creature.display();
}
