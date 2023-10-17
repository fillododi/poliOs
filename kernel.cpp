typedef void (*constructor)();
extern "C" constructor start_ctors;
extern "C" constructor end_ctors;
extern "C" void callConstructors(){
    for(constructor* i = &start_ctors; i!= &end_ctors; i++){
        (*i)();
    }
}

void print(char* str){
    unsigned short* videoMemory = (unsigned short*) 0xb8000; //here starts the memory reserved for characters on the screen. 2 bytes are one character (the second byte is for color)

    for(int i = 0; str[i] != '\0'; i++){
        videoMemory[i] = (videoMemory[i] & 0xFF00) | str[i];
    }
}

extern "C" void start(void* multiboot_structure, unsigned int magicNumber){
    print("Hello, World!");
    while(1){

    }
}