#include "game.h"
#include "resources.h"

int game_isRunning = 1;
SDL_Event game_event;
// Resources* res = NULL; 

// Definições das funções
void gameloop() {
    // res = getResourceInstance(); // obtem a intancia de recursos
    while (game_isRunning) {
        checkEvents(); // trata os eventos

        handleEvents();
        update();
        render();
    }
}

void handleEvents() {}
void update() {
}
void render() {
    // SDL_RenderClear(res->renderer);
    // SDL_RenderPresent(res->renderer);
}
void checkEvents() {
    // while (SDL_PollEvent(&game_event)) {
    //     switch (game_event.type) {
    //         case SDL_QUIT:
    //             game_isRunning = 0;
    //             break;
    //         case SDL_KEYDOWN:
    //             if (game_event.key.keysym.sym == SDLK_ESCAPE) game_isRunning = 0;
    //     }
    // }
}
