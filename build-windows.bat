@echo off
set COMPILER=gcc
set OUTPUT=bin/windows/main
set SDL_INCLUDE=-IC:/SDL2/x86_64-w64-mingw32/include
set SDL_LIB=-LC:/SDL2/x86_64-w64-mingw32/lib

SETLOCAL EnableDelayedExpansion
rem Lê todas as linhas do arquivo compile_sources.txt
for /F "delims=" %%i in ('findstr /r "^" compile_sources.txt') DO (
    rem Concatena a linha à variável
    set SOURCES=!SOURCES! %%i
)

rem Lê todas as linhas do arquivo compile_SDLparams.txt
for /F "delims=" %%i in ('findstr /r "^" compile_SDLparams.txt') DO (
    rem Concatena a linha à variável
    set PARAMS_SDL=!PARAMS_SDL! %%i
)
rem Lê todas as linhas do arquivo compile_SDLparams_static.txt, para linkagem estática
for /F "delims=" %%i in ('findstr /r "^" compile_SDLparams_static.txt') DO (
    rem Concatena a linha à variável
    set PARAMS_SDL_STATIC=!PARAMS_SDL_STATIC! %%i
)

set COMMAND=%COMPILER% -fdiagnostics-color=always -g %SOURCES% -o %OUTPUT% %SDL_INCLUDE% %SDL_LIB% -lmingw32 %PARAMS_SDL% -mwindows
echo %COMMAND%
%COMMAND%

