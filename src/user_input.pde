var ROTATION_AMOUNT = 0.05;

function UserInput() {
  this.rotation = new PVector(0, 0);
  this.focused = true;
  this.lastPosition = null;

  this._onKeyDown = this._onKeyDown.bind(this);
  this._onFocus = this._onFocus.bind(this);
  this._onBlur = this._onBlur.bind(this);
  this._onTouchMove = this._onTouchMove.bind(this);
  this._onTouchEnd = this._onTouchEnd.bind(this);
  this._onTouchStart = this._onTouchStart.bind(this);

  window.addEventListener("keydown", this._onKeyDown);
  window.addEventListener("focus", this._onFocus);
  window.addEventListener("blur", this._onBlur);
  window.addEventListener("touchmove", this._onTouchMove);
  window.addEventListener("touchend", this._onTouchEnd);
  window.addEventListener("touchstart", this._onTouchStart);
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

UserInput.prototype.onMouseDrag = function(mouseX, mouseY) {
  this._trackDrag(mouseX, mouseY);
};

UserInput.prototype.onMouseRelease = function() {
  this.lastPosition = null;
};

UserInput.prototype._onBlur = function() {
  this.focused = false;
};

UserInput.prototype._onFocus = function() {
  this.focused = true;
};

UserInput.prototype._onTouchStart = function(e) {
  e.preventDefault();
};

UserInput.prototype._onTouchEnd = function(e) {
  e.preventDefault();
  this.lastPosition = null;
};

UserInput.prototype._onTouchMove = function(e) {
  e.preventDefault();
  var touch = e.touches[0];
  this._trackDrag(touch.clientX, touch.clientY);
};

UserInput.prototype._trackDrag = function(x, y) {
  var newPos = new PVector(x, y);
  if (!this.lastPosition) {
    this.lastPosition = newPos;
    return;
  }

  var diff = newPos.get();
  diff.sub(this.lastPosition);
  diff.mult(0.01);
  diff.rotate(PI/2);

  this.lastPosition = newPos;

  this.rotation.add(diff);
}
