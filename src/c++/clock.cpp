#include "clock.h"

namespace nlrs
{

clock::clock()
    : previous_millis_(0u),
    delta_millis_(17),
    scale_factor_(1.f)
{}

void clock::scale(float s)
{
    scale_factor_ = s;
}

void clock::update()
{
    u32 frameMillis = SDL_GetTicks();
    delta_millis_ = frameMillis - previous_millis_;
    previous_millis_ = frameMillis;
}

void clock::wait(u32 wait_millis)
{
    if (delta_millis_ < wait_millis)
    {
        SDL_Delay(wait_millis - delta_millis_);
    }
}

}
