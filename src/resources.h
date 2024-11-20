#pragma once
#include <SDL2/SDL.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct {
    SDL_Window *window;
    SDL_Renderer *renderer;
    
} Resources;

// Função para acessar a instância
Resources* getResourceInstance();
