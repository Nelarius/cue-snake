import "assert" for Assert
import "cue_sdk" for LedColor, Keyboard, CueSdk
import "snake_segment" for SnakeSegment, Vec2
import "snake_grid" for SnakeGrid
import "random" for Random

class FlashHelper {
    construct new(frequency) {
        _frequency = frequency
        _elapsed = 0.0
    }

    step(dt) {
        _elapsed = _elapsed + dt
        return (Num.pi * _elapsed * _frequency).sin
    }
}

class GameState {
    update(dt) {}
    onUp() {}
    onDown() {}
    onLeft() {}
    onRight() {}
}

class FlashSnake is GameState {
    construct new(gameManager, frequency, grid, snake, color) {
        // TODO: duration
        Assert.notNull(grid, "grid was null in FlashSnake constructor")
        Assert.notNull(snake, "snake was null in FlashSnake constructor")
        Assert.notNull(color, "color was null in FlashSnake constructor")
        Assert.notNull(gameManager, "gameManager was null in FlashSnake constructor")
        _gameManager = gameManager
        _flash = FlashHelper.new(frequency)
        _grid = grid
        _snake = snake
        _color = color

        _duration = 4.0
        _elapsed = 0.0
    }

    update(dt) {
        var ampl = _flash.step(dt)
        var computedColor = LedColor.new(_color.r*ampl, _color.g*ampl, _color.b*ampl)

        for (segment in _snake) {
            CueSdk.setLedColor(_grid[segment.position.y][segment.position.x], computedColor)
        }

        _elapsed = _elapsed + dt

        if (_elapsed >= _duration) {
            var snakeGame = SnakeGame.new(_gameManager)
            _gameManager.setState(snakeGame)
        }
    }
}

class SnakeGame is GameState {
    construct new(gameManager) {
        _gameManager = gameManager

        var initialColor = LedColor.new(255, 255, 255)
        _keys = CueSdk.getLedKeys()
        for (key in _keys) {
            CueSdk.setLedColor(key, initialColor)
        }

        _black = LedColor.new(0, 0, 0)
        _green = LedColor.new(100, 255, 20)
        _red   = LedColor.new(255, 0, 0)
        _purple = LedColor.new(255, 50, 255)
        _yellow = LedColor.new(255, 255, 50)

        var fuchsia = LedColor.new(255, 0, 255)
        CueSdk.setLedColor(Keyboard.keyUpArrow, fuchsia)
        CueSdk.setLedColor(Keyboard.keyDownArrow, fuchsia)
        CueSdk.setLedColor(Keyboard.keyLeftArrow, fuchsia)
        CueSdk.setLedColor(Keyboard.keyRightArrow, fuchsia)

        _grid = SnakeGrid.new()
        // _snake is the head of a linked list whose nodes consist of
        // instances of SnakeSegment
        _snake = SnakeSegment.new(Vec2.new(0, 0))
        _snakeLength = 1
        _direction = Vec2.new(1, 0)

        _random = Random.new(12345)
        _food = Vec2.new(_random.int(1, SnakeGrid.width), _random.int(1, SnakeGrid.height))

        _updateRate = 0.5
        _elapsedTime = 0.0
    }

    update(dt) {
        _elapsedTime = _elapsedTime + dt

        if (_elapsedTime < _updateRate) {
            return
        } else {
            _elapsedTime = 0.0
        }

        for (row in _grid) {
            for (key in row) {
                CueSdk.setLedColor(key, _black)
            }
        }

        Assert.notNull(_purple, "_purple was null")
        Assert.notNull(_yellow, "_yellow was null")
        Assert.notNull(_direction, "_direction was null")
        Assert.notNull(_food, "_food was null")
        Assert.notNull(_snake, "_snake was null")

        var nextPosition = _snake.position + _direction

        // if the snake self-intersects, then transition to the flash state
        if (_snake.containsPosition(nextPosition)) {
            var flashState = FlashSnake.new(_gameManager, 5.0, _grid, _snake, _red)
            _gameManager.setState(flashState)
        }

        if (nextPosition == _food) {
            var newSegment = SnakeSegment.new(nextPosition)
            newSegment.addChild(_snake)
            _snake = newSegment

            _snakeLength = _snakeLength + 1
            if (_snakeLength == SnakeGrid.width * SnakeGrid.height) {
                var flashState = FlashSnake.new(_gameManager, 5.0, _grid, _snake, _green)
                _gameManager.setState(flashState)
            }

            while (_snake.containsPosition(_food)) {
                _food = Vec2.new(_random.int(0, SnakeGrid.width), _random.int(SnakeGrid.height))
            }
        } else {
            _snake.moveTo(nextPosition)
        }

        CueSdk.setLedColor(_grid[_food.y][_food.x], _yellow)

        for (segment in _snake) {
            CueSdk.setLedColor(_grid[segment.position.y][segment.position.x], _purple)
        }
    }

    onUp() {
        _direction = Vec2.new(0, -1)
    }

    onDown() {
        _direction = Vec2.new(0, 1)
    }

    onLeft() {
        _direction = Vec2.new(-1, 0)
    }

    onRight() {
        _direction = Vec2.new(1, 0)
    }
}

class Game {
    construct new() {
        _snakeGame = SnakeGame.new(this)
        _currentState = _snakeGame

        _elapsedTime = System.clock
    }

    setState(newState) {
        _currentState = newState
    }

    update() {
        var delta = System.clock - _elapsedTime
        _currentState.update(delta)
        _elapsedTime = System.clock
    }

    onUp() {
        _currentState.onUp()
    }

    onDown() {
        _currentState.onDown()
    }

    onLeft() {
        _currentState.onLeft()
    }

    onRight() {
        _currentState.onRight()
    }
}
