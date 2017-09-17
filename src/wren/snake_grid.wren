import "cue_sdk" for Keyboard

class SnakeGrid {
    construct new() {
        _map = [
            [Keyboard.key1, Keyboard.key2, Keyboard.key3, Keyboard.key4, Keyboard.key5, Keyboard.key6, Keyboard.key7, Keyboard.key8 , Keyboard.key9],
            [Keyboard.keyQ, Keyboard.keyW, Keyboard.keyE, Keyboard.keyR, Keyboard.keyT, Keyboard.keyY, Keyboard.keyU, Keyboard.keyI, Keyboard.keyO],
            [Keyboard.keyA, Keyboard.keyS, Keyboard.keyD, Keyboard.keyF, Keyboard.keyG, Keyboard.keyH, Keyboard.keyJ, Keyboard.keyK, Keyboard.keyL],
            [Keyboard.keyZ, Keyboard.keyX, Keyboard.keyC, Keyboard.keyV, Keyboard.keyB, Keyboard.keyN, Keyboard.keyM, Keyboard.keyCommaAndLessThan, Keyboard.keyPeriodAndBiggerThan ]
        ]
    }

    static width { 9 }
    static height { 4 }

    [index] {
        return _map[index]
    }

    iterate(iter) {
        if (iter == null) {
            iter = 0
        } else {
            iter = iter + 1
        }

        if (iter == _map.count) {
            return false
        } else {
            return iter
        }
    }

    iteratorValue(iter) {
        return _map[iter]
    }
}
