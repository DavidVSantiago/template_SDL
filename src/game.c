#include "game.h"

/** ATRIBUTOS */
int game_isRunning;
SDL_Event game_event;
Resources* res = NULL;

// Definições das funções 
void gameInit(){
    res = getResourceInstance(); // obtém a intância de recursos
    game_isRunning = 1;
    gameloop();
}
void gameloop() {
    while (game_isRunning) {

        handleEvents();// trata os eventos
        update();
        render();
    }
}

void handleEvents() {
    /** Teste de eventos do SDL*/
    while (SDL_PollEvent(&game_event)) {
        switch (game_event.type) {
            case SDL_QUIT:
                game_isRunning = 0;
                break;
            case SDL_KEYDOWN:
                if (game_event.key.keysym.sym == SDLK_ESCAPE) game_isRunning = 0;
        }
    }
}
void update() {
}
void render() {
    SDL_RenderClear(res->renderer);
    SDL_RenderPresent(res->renderer);
}
