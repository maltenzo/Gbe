//
// Created by maltenzo on 1/1/21.
//
#include <stdint.h>
const uint32_t VRAM_BEGIN = 0x8000;
const uint32_t VRAM_END = 0x9FFF;
const uint32_t VRAM_size = VRAM_END - VRAM_BEGIN;

enum PixelValue{
    Zero,
    One,
    Two,
    Three
};

typedef enum PixelValue Tile[8][8];

Tile* empty_tile(){
    Tile* t;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            (*t)[i][j] = Zero;
        }
    }

    return t;
}

