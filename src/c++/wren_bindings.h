#include "CUESDK.h"
#include "Wren++.h"

namespace nlrs
{

struct led_color
{
    int r, g, b;
};

void set_led_color(int ledId, const led_color&);
void get_led_keys(WrenVM*);

inline void bind_cue_sdk(wrenpp::VM& vm)
{
    vm.beginModule("cue_sdk")
        .bindClass<led_color, int, int, int>("LedColor")
            .bindGetter<decltype(led_color::r), &led_color::r>("r")
            .bindGetter<decltype(led_color::g), &led_color::g>("g")
            .bindGetter<decltype(led_color::b), &led_color::b>("b")
            .bindSetter<decltype(led_color::r), &led_color::r>("r=(_)")
            .bindSetter<decltype(led_color::g), &led_color::g>("g=(_)")
            .bindSetter<decltype(led_color::b), &led_color::b>("b=(_)")
        .endClass()
        .beginClass("CueSdk")
            .bindFunction<void(*)(int, const led_color&), &set_led_color>(true, "setLedColor(_,_)")
            .bindCFunction(true, "getLedKeys()", &get_led_keys)
        .endClass()
    .endModule();
}

}
