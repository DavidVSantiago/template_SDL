#include <stdio.h>
#include <SDL2/SDL.h>

int main(int argc, char **argv) {
    if(SDL_Init(SDL_INIT_VIDEO) != 0) {
        printf("SDL_Init Error: %s\n",SDL_GetError());

        return 1;
    }

    SDL_Window *window = SDL_CreateWindow("r/gamedev", 100, 100, 640, 480, SDL_WINDOW_SHOWN);
    if(window == 0) {
        printf("SDL_Init Error: %s\n",SDL_GetError());
        SDL_Quit();
        return 1;
    }

    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if(renderer == 0) {
        printf("SDL_Init Error: %s\n",SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    SDL_Event event;
    int quit = 0;

    while(!quit) {
        while(SDL_PollEvent(&event)) {
            if(event.type == SDL_QUIT) {
                quit = 1;
            }
        }

        SDL_RenderClear(renderer);
        // renderTextures
        SDL_RenderPresent(renderer);
    }

    return 0;
}