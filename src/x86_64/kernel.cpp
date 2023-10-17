#include "types.h"

void print(){
    uint16_t* videoMemory = (uint16_t*) 0xb8000; //here starts the memory reserved for characters on the screen. 2 bytes are one character (the second byte is for color)
    videoMemory[0] = 0x00002f4f;
    videoMemory[1] = 0xffff2f4f;
}

extern "C" void start(void* multiboot_structure, uint32_t magicNumber){
    print();
    while(1){

    }
}