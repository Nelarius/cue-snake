#include "clock.h"
#include "cue_sdk.h"
#include "wren_bindings.h"
#include "SDL.h"

using namespace nlrs;

int main(int argc, char** argv)
{
    SDL_Init(SDL_INIT_EVERYTHING);

    // it seems a window has to be open in order for keyboard input to be detected
    SDL_Window* window = SDL_CreateWindow("asdfasdf", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 100, 100, SDL_WINDOW_RESIZABLE);

    cue_sdk cue;

    wrenpp::VM vm;

    bind_cue_sdk(vm);

    wrenpp::Method update_method;
    wrenpp::Method up_method;
    wrenpp::Method down_method;
    wrenpp::Method left_method;
    wrenpp::Method right_method;

    vm.executeString(
        "import \"snake_game\" for Game\n"
        "var game = Game.new()\n"
    );

    update_method = vm.method("main", "game", "update()");
    up_method = vm.method("main", "game", "onUp()");
    down_method = vm.method("main", "game", "onDown()");
    left_method = vm.method("main", "game", "onLeft()");
    right_method = vm.method("main", "game", "onRight()");

    bool running = true;

    clock timer;
    while (running)
    {
        SDL_Event event;
        while (SDL_PollEvent(&event))
        {
            if (event.type == SDL_QUIT)
            {
                running = false;
            }
            else if (event.type == SDL_KEYUP)
            {
                if (event.key.keysym.scancode == SDL_SCANCODE_ESCAPE)
                {
                    running = false;
                }
            }
            else if (event.type == SDL_KEYDOWN)
            {
                switch (event.key.keysym.scancode)
                {
                case SDL_SCANCODE_DOWN: down_method(); break;
                case SDL_SCANCODE_UP:  up_method(); break;
                case SDL_SCANCODE_LEFT: left_method(); break;
                case SDL_SCANCODE_RIGHT: right_method(); break;
                }
            }
        }

        update_method();

        timer.update();
        timer.wait(16u);
    }

    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
