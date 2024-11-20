#include "resources.h"

// Ponteiro para a instância única
static Resources* instance = NULL;

// Função para acessar a instância
Resources* getResourceInstance() {
    if (instance == NULL) {
        // Inicializa a instância na primeira chamada
        instance = (Resources*)malloc(sizeof(Resources));
        if (instance == NULL) {
            fprintf(stderr, "Falha ao alocar memória para Singleton\n");
            exit(EXIT_FAILURE);
        }
    }
    return instance;
}
// Opcional: função para liberar a instância
void freeResourceInstance() {
    if (instance != NULL) {
        free(instance);
        instance = NULL;
    }
}