var ROTATION_AMOUNT = 0.05;

function UserInput() {
  this.rotation = new PVector(0, 0);
  this.focused = true;

  this._onKeyDown = this._onKeyDown.bind(this);
  this._onFocus = this._onFocus.bind(this);
  this._onBlur = this._onBlur.bind(this);

  window.addEventListener("keydown", this._onKeyDown);
  window.addEventListener("focus", this._onFocus);
  window.addEventListener("blur", this._onBlur);
}

UserInput.prototype._onKeyDown = function(e) {
  switch (e.keyIdentifier) {
    case "Down": {
      this.rotation.x += ROTATION_AMOUNT;
      break;
    }
    case "Up": {
      this.rotation.x -= ROTATION_AMOUNT;
      break;
    }
    case "Right": {
      this.rotation.y -= ROTATION_AMOUNT;
      break;
    }
    case "Left": {
      this.rotation.y += ROTATION_AMOUNT;
      break;
    }
  }
};

UserInput.prototype._onBlur = function() {
  this.focused = false;
};

UserInput.prototype._onFocus = function() {
  this.focused = true;
};

UserInput.prototype.onMouseRelease = function() {
  this.lastMousePosition = null;
};

UserInput.prototype.onMouseDrag = function(mouseX, mouseY) {
  if (!this.lastMousePosition) {
    this.lastMousePosition = new PVector(mouseX, mouseY);
    return;
  }

  var newPos = new PVector(mouseX, mouseY);
  var diff = newPos.get();
  diff.sub(this.lastMousePosition);
  diff.mult(0.01);
  diff.rotate(PI/2);

  this.lastMousePosition = newPos;

  this.rotation.add(diff);
};
