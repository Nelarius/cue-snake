
foreign class LedColor {
    construct new(red, green, blue) {}
    foreign r
    foreign r=(val)
    foreign g
    foreign g=(val)
    foreign b
    foreign b=(val)
}

class Keyboard {
    static keyInvalid { 0 }
    static keyEscape { 1 }
    static keyF1 { 2 }
    static keyF2 { 3 }
    static keyF3 { 4 }
    static keyF4 { 5 }
    static keyF5 { 6 }
    static keyF6 { 7 }
    static keyF7 { 8 }
    static keyF8 { 9 }
    static keyF9 { 10 }
    static keyF10 { 11 }
    static keyF11 { 12 }
    static keyGraveAccentAndTilde { 13 }
    static key1 { 14 }
    static key2 { 15 }
    static key3 { 16 }
    static key4 { 17 }
    static key5 { 18 }
    static key6 { 19 }
    static key7 { 20 }
    static key8 { 21 }
    static key9 { 22 }
    static key0 { 23 }
    static keyMinusAndUnderscore { 24 }
    static keyTab { 25 }
    static keyQ { 26 }
    static keyW { 27 }
    static keyE { 28 }
    static keyR { 29 }
    static keyT { 30 }
    static keyY { 31 }
    static keyU { 32 }
    static keyI { 33 }
    static keyO { 34 }
    static keyP { 35 }
    static keyBracketLeft { 36 }
    static keyCapsLock { 37 }
    static keyA { 38 }
    static keyS { 39 }
    static keyD { 40 }
    static keyF { 41 }
    static keyG { 42 }
    static keyH { 43 }
    static keyJ { 44 }
    static keyK { 45 }
    static keyL { 46 }
    static keySemicolonAndColon { 47 }
    static keyApostropheAndDoubleQuote { 48 }
    static keyLeftShift { 49 }
    static keyNonUsBackslash { 50 }
    static keyZ { 51 }
    static keyX { 52 }
    static keyC { 53 }
    static keyV { 54 }
    static keyB { 55 }
    static keyN { 56 }
    static keyM { 57 }
    static keyCommaAndLessThan { 58 }
    static keyPeriodAndBiggerThan { 59 }
    static keySlashAndQuestionMark { 60 }
    static keyLeftCtrl { 61 }
    static keyLeftGui { 62 }
    static keyLeftAlt { 63 }
    static keyLang2 { 64 }
    static keySpace { 65 }
    static keyLang1 { 66 }
    static keyInternational2 { 67 }
    static keyRightAlt { 68 }
    static keyRightGui { 69 }
    static keyApplication { 70 }
    static keyLedProgramming { 71 }
    static keyBrightness { 72 }
    static keyF12 { 73 }
    static keyPrintScreen { 74 }
    static keyScrollLock { 75 }
    static keyPauseBreak { 76 }
    static keyInsert { 77 }
    static keyHome { 78 }
    static keyPageUp { 79 }
    static keyBracketRight { 80 }
    static keyBackslash { 81 }
    static keyNonUsTilde { 82 }
    static keyEnter { 83 }
    static keyInternational1 { 84 }
    static keyEqualsAndPlus { 85 }
    static keyInternational3 { 86 }
    static keyBackspace { 87 }
    static keyDelete { 88 }
    static keyEnd { 89 }
    static keyPageDown { 90 }
    static keyRightShift { 91 }
    static keyRightCtrl { 92 }
    static keyUpArrow { 93 }
    static keyLeftArrow { 94 }
    static keyDownArrow { 95 }
    static keyRightArrow { 96 }
    static keyWinLock { 97 }
    static keyMute { 98 }
    static keyStop { 99 }
    static keyScanPreviousTrack { 100 }
    static keyPlayPause { 101 }
    static keyScanNextTrack { 102 }
    static keyNumLock { 103 }
    static keyKeypadSlash { 104 }
    static keyKeypadAsterisk { 105 }
    static keyKeypadMinus { 106 }
    static keyKeypadPlus { 107 }
    static keyKeypadEnter { 108 }
    static keyKeypad7 { 109 }
    static keyKeypad8 { 110 }
    static keyKeypad9 { 111 }
    static keyKeypadComma { 112 }
    static keyKeypad4 { 113 }
    static keyKeypad5 { 114 }
    static keyKeypad6 { 115 }
    static keyKeypad1 { 116 }
    static keyKeypad2 { 117 }
    static keyKeypad3 { 118 }
    static keyKeypad0 { 119 }
    static keyKeypadPeriodAndDelete { 120 }
    static keyG1 { 121 }
    static keyG2 { 122 }
    static keyG3 { 123 }
    static keyG4 { 124 }
    static keyG5 { 125 }
    static keyG6 { 126 }
    static keyG7 { 127 }
    static keyG8 { 128 }
    static keyG9 { 129 }
    static keyG10 { 130 }
    static keyVolumeUp { 131 }
    static keyVolumeDown { 132 }
    static keyMR { 133 }
    static keyM1 { 134 }
    static keyM2 { 135 }
    static keyM3 { 136 }
    static keyG11 { 137 }
    static keyG12 { 138 }
    static keyG13 { 139 }
    static keyG14 { 140 }
    static keyG15 { 141 }
    static keyG16 { 142 }
    static keyG17 { 143 }
    static keyG18 { 144 }
    static keyInternational5 { 145 }
    static keyInternational4 { 146 }
    static keyFn { 147 }
}

class CueSdk {
    // @key an instance of Keyboard
    // @color an instance of LedColor
    foreign static setLedColor(key, color)

    // @returns a list of available keys
    foreign static getLedKeys()
}
