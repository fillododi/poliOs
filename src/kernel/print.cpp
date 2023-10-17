#include "print.h"
#include "types.h"

const static size_t NUM_COLS = 80;
const static size_t NUM_ROWS = 25;

struct Char {
    uint8_t character;
    uint8_t color;
};

struct Char* buffer = (struct Char*) 0xb8000;
size_t row = 0;
size_t col = 0;
uint8_t color = COLOR_WHITE | COLOR_BLACK << 4;

void clearRow(size_t row){
    struct Char empty = (struct Char){
        character: ' ',
        color: color
    };
    for(size_t col = 0; col < NUM_COLS; col++){
        buffer[row*NUM_ROWS + col] = empty;
    }
}

void clearScreen(){
    for(size_t i = 0; i < NUM_ROWS; i++){
        clearRow(i);
    }
}

void printNewLine(){
    col = 0;
    if(row <= NUM_ROWS){
        row++;
        return;
    }
    for(size_t row = 1; row < NUM_ROWS; row++){
        for(size_t col = 0; col < NUM_COLS; col++){
            struct Char character = buffer[row*NUM_COLS + col];
            buffer[(row-1)*NUM_COLS + col] = character;
        }
    }
    clearRow(NUM_ROWS - 1);
}

void printChar(char character){
    if(character == '\n'){
        printNewLine();
        return;
    }
    if(col >= NUM_COLS){
        printNewLine();
    }
    buffer[row*NUM_COLS + col] = (struct Char){
        character: (uint8_t) character,
        color: color
    };
    col++;
}

void printString(char* string){
    for(size_t i = 0; 1; i++){
        char character = (uint8_t)string[i];
        if(character == '\0'){
            return;
        }
        printChar(character);
    }
}

void setPrintColor(uint8_t foreground, uint8_t background){
    color = foreground | background << 4;
}