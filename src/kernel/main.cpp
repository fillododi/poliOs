#include "types.h"
#include "print.h"

typedef void (*constructor)();
extern "C" constructor start_ctors;
extern "C" constructor end_ctors;
extern "C" void callConstructors(){
    for(constructor* i = &start_ctors; i!= &end_ctors; i++){
        (*i)();
    }
}

extern "C" void start(void* multiboot_structure, uint32_t magicNumber){
    clearScreen();
    setPrintColor(COLOR_GREEN, COLOR_BLACK);
    printString("Hello ");
    setPrintColor(COLOR_LIGHT_RED, COLOR_BLACK);
    printString("World!\n");
    while(1);
}