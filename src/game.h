#pragma once
#include <SDL2/SDL.h>
#include <stdio.h>
#include "resources.h"

void gameInit();
void gameloop();
void handleEvents();
void update();
void render();