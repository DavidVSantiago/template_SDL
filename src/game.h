#include <stdio.h>
#include <SDL2/SDL.h>
#pragma once

extern int game_isRunning;
extern SDL_Event game_event;

void gameloop();
void handleEvents();
void update();
void render();
void checkEvents();
