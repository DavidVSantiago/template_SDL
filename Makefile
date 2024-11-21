COMPILER=gcc#variável que define o compilador

# variável que define o nome do executável .exe
ifeq ($(OS),Windows_NT)
	EXE=bin/windows/game
else
	EXE=bin/linux/game
endif

# variável que define os arquivos fonte a serem compilados. o '\' é um separador para novas linhas
SRC = \
	src/resources.c \
	src/game.c \
	src/main.c

# lista de arquivos objetos, referentes a cada arquivo fonte.
# src/%.c - obter todos os fontes .c da pasta src
# .obj/%.o - gerar todos os objetos .o na pasta .obj
# $(SRC) -  aplicar o padrão à lista definida na variável SRC
OBJ=$(patsubst src/%.c,.obj/%.o,$(SRC))

# CFLAGS é a variável para formar as flags de compilação
# -Wall - ativa todos os avisos do compilador
# -g - inclui informações de depuração no executável (necessário para debugar)
ifeq ($(OS),Windows_NT)
	CFLAGS := -fdiagnostics-color=always -IC:/SDL2/x86_64-w64-mingw32/include
	CFLAGS += -Wall -g
else
	CFLAGS := -I/usr/include/SDL2 -D_REENTRANT
	CFLAGS += -Wall -g
endif

# LDFLAGS é a variável para as flsags de linkagem
ifeq ($(OS),Windows_NT)
	LDFLAGS := -LC:/SDL2/x86_64-w64-mingw32/lib -lmingw32 -lSDL2main -lSDL2 -mwindows
else
	LDFLAGS := -L/usr/lib/x86_64-linux-gnu -lSDL2main -lSDL2
endif

all: $(EXE) # ?????
.PHONY: all

# Regra para compilar arquivos objetos
$(OBJ): .obj/%.o : src/%.c
ifeq ($(OS),Windows_NT)
	@if not exist .obj mkdir -p .obj
else
	mkdir -p .obj
endif
	$(COMPILER) $(CFLAGS) -c $< -o $@

# Regra para linkar e gerar o executável
$(EXE): $(OBJ)
ifeq ($(OS),Windows_NT)
	@if not exist $(dir $@) mkdir $(subst /,\,$(dir $@))
else
	mkdir -p $(dir $@)
endif
	$(COMPILER) -o $@ $^ $(LDFLAGS)

# Regra para limpar os arquivos gerados
clean:
ifeq ($(OS),Windows_NT)
	@if exist .obj rmdir /S /Q .obj
	@if exist $(subst /,\,$(EXE)) del /Q $(subst /,\,$(EXE))
else
	@rm -rf .obj
	@rm -f $(EXE)
endif
.PHONY: clean