
#include "wren_bindings.h"

namespace nlrs
{

void set_led_color(int id, const led_color& color)
{
    auto corsair_led_color = CorsairLedColor{ static_cast<CorsairLedId>(id), color.r, color.g, color.b };
    CorsairSetLedsColors(1, &corsair_led_color);
}

void get_led_keys(WrenVM* vm)
{
    CorsairLedPositions* led_positions = CorsairGetLedPositions();

    wrenSetSlotNewList(vm, 0);
    for (int i = 0; i < led_positions->numberOfLed; ++i)
    {
        wrenSetSlotDouble(vm, 1, double(static_cast<int>(led_positions->pLedPosition[i].ledId)));
        wrenInsertInList(vm, 0, -1, 1);
    }
}

}
