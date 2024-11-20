COMPILER=gcc#variável que define o compilador
EXE=bin/linux/game#variável que define o nome do executável .exe

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
CFLAGS := -I/usr/include/SDL2 -D_REENTRANT
CFLAGS += -Wall -g

# LDFLAGS é a variável para as flsags de linkagem
LDFLAGS := -L/usr/lib/x86_64-linux-gnu -lSDL2main -lSDL2 -Wl,--enable-new-dtags -Wl,-Bstatic -Wl,-Bdynamic -lm -ldl -lpthread -lrt

all: $(EXE) # ?????
.PHONY: all

$(OBJ): .obj/%.o : src/%.c
	@mkdir -p .obj
	$(COMPILER) $(CFLAGS) -c $< -o $@

$(EXE): $(OBJ)
	$(COMPILER) -o $@ $^ $(LDFLAGS)

clean:
	rm $(OBJ) $(EXE)
.PHONY: clean