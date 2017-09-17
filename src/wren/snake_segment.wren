import "assert" for Assert
import "snake_grid" for SnakeGrid

class Vec2 {
    construct new(x, y) {
        _x = x
        _y = y
    }

    x { _x }
    y { _y }
    x=(x) {
        _x = x
    }
    y=(y) {
        _y = y
    }

    ==(rhs) {
        if (!rhs) {
            return false
        }
        return (_x == rhs.x) && (_y == rhs.y)
    }

    !=(rhs) {
        if (!rhs) {
            return false
        }
        return _x != rhs.x || _y != rhs.y
    }

    +(rhs) {
        var newPos = Vec2.new(_x + rhs.x, _y + rhs.y)

        if (newPos.x < 0) {
            newPos.x = SnakeGrid.width - 1
        } else if (newPos.x == SnakeGrid.width) {
            newPos.x = 0
        }

        if (newPos.y < 0) {
            newPos.y = SnakeGrid.height - 1
        } else if (newPos.y == SnakeGrid.height) {
            newPos.y = 0
        }

        return newPos
    }
}

class SnakeSegment {
    construct new(pos) {
        _pos = pos
    }

    addChild(child) {
        Assert.isNull(_child, "SnakeSegment already has a child")
        _child = child
    }

    child { _child }

    position { _pos }
    position=(pos) {
        _pos = pos
    }

    moveTo(newPos) {
        _prevPos = _pos
        Assert.notNull(_pos, "_pos was null in SnakeSegment.move")
        Assert.notNull(newPos, "newPos was null in SnakeSegment.null")
        _pos = newPos

        if (_child) {
            _child.moveTo(_prevPos)
        }
    }

    containsPosition(pos) {
        var child = this

        while (child) {
            if  (child.position == pos) {
                return true
            }

            child = child.child
        }
    }

    iterate(iter) {
        if (iter == null) {
            iter = this
        } else {
            iter = iter.child
        }

        if (iter == null) {
            return false
        } else {
            return iter
        }
    }

    iteratorValue(iter) {
        return iter
    }
}
