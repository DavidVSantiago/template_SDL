#include <SDL2/SDL.h>
#include <stdio.h>
#include "game.h"
#include "resources.h"

int main(int argc, char **argv) {
    if(SDL_Init(SDL_INIT_VIDEO) != 0) {printf("SDL_Init Error: %s\n",SDL_GetError());return 1;}
    
    Resources* res = getResourceInstance(); // obtém a intancia de recursos
    /** Inicializa a janela*/
    res->window = SDL_CreateWindow("Programa", 100, 100, 640, 480, SDL_WINDOW_SHOWN);
    if(res->window == 0) {printf("SDL_Init Error: %s\n",SDL_GetError());SDL_Quit();return 1;}

    /* Inicializa o renderizador*/
    res->renderer = SDL_CreateRenderer(res->window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if(res->renderer == 0) {printf("SDL_Init Error: %s\n",SDL_GetError());SDL_DestroyWindow(res->window);SDL_Quit();return 1;}

    gameInit();

    SDL_DestroyRenderer(res->renderer);
    SDL_DestroyWindow(res->window);
    SDL_Quit();

    return 0;
}