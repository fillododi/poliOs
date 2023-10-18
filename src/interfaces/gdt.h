#ifndef __GDT_H
#define __GDT_H

#include "types.h"

class GlobalDescriptorTable {
    public:
        class SegmentDescriptor {
        private :
            uint16_t limit_low;
            uint16_t base_low;
            uint8_t  base_mid;
            uint8_t  access;
            uint8_t  flags_limit_high;
            uint8_t  base_high;
        public:
            SegmentDescriptor(uint32_t base, uint32_t limit, uint8_t access);
            uint32_t getBase();
            uint32_t getLimit();
        } __attribute__((packed));
        SegmentDescriptor nullSegment;
        SegmentDescriptor unusedSegment;
        SegmentDescriptor codeSegment;
        SegmentDescriptor dataSegment;

    public:
        GlobalDescriptorTable();
        ~GlobalDescriptorTable();
        uint16_t getCodeSegment();
        uint16_t getDataSegment();
};

#endif