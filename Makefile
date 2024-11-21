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
# $(SRC) -  aplicar o padrão à lista definida na variável SRC
ifeq ($(OS),Windows_NT)
	OBJ=$(patsubst src/%.c,.obj/windows/%.o,$(SRC))
else
	OBJ=$(patsubst src/%.c,.obj/linux/%.o,$(SRC))
endif

# CFLAGS é a variável para formar as flags de compilação
# -Wall - ativa todos os avisos do compilador
# -g - inclui informações de depuração no executável (necessário para debugar)
ifeq ($(OS),Windows_NT)
	CFLAGS := -fdiagnostics-color=always -Ilib/windows/include
	CFLAGS += -Wall -g
else
	CFLAGS := -Ilib/linux/include/SDL2 -D_REENTRANT
	CFLAGS += -Wall -g
endif

# LDFLAGS é a variável para as flsags de linkagem
ifeq ($(OS),Windows_NT)
	LDFLAGS := -Llib/windows/lib -lmingw32 -lSDL2main -lSDL2 -mwindows
#LDFLAGS := -Llib/windows/lib -lmingw32 -lSDL2main -lSDL2 -mwindows -static -lwinmm -loleaut32 -lSetupapi -lImm32 -lVersion -lOle32 -static-libgcc -static-libstdc++
else
	LDFLAGS := -Llib/linux/lib -lSDL2main -lSDL2 -Wl,-rpath,lib/linux/lib -Wl,--enable-new-dtags -Wl,-Bstatic -Wl,-Bdynamic -lm -ldl -lpthread -lrt
# LDFLAGS := -Llib/linux/lib -lSDL2main -lSDL2
endif

all: $(EXE) # ?????
.PHONY: all

# Regra para compilar arquivos objetos
ifeq ($(OS),Windows_NT)
$(OBJ): .obj/windows%.o : src/%.c
	@if not exist .obj\windows mkdir -p .obj\windows
else
$(OBJ): .obj/linux%.o : src/%.c
	mkdir -p .obj/linux
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
	@if exist .obj\windows rmdir /S /Q .obj\windows
	@if exist $(subst /,\,$(EXE)) del /Q $(subst /,\,$(EXE))
else
	@rm -rf .obj/linux
	@rm -f $(EXE)
endif
.PHONY: clean