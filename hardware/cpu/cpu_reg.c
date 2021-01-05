#include "cpu.h"
/*
 The CPU is composed of 8 different "registers". Registers are responsible for holding on to little pieces of data that the CPU can manipulate when it executes various instructions. The Game Boy's CPU is an 8-Bit CPU, meaning that each of its registers can hold 8 bits (a.k.a 1 byte) of data. The CPU has 8 different registers labled as "a", "b", "c", "d", "e", "f", "h", "l".
 */
struct registros{
    uint8_t A;
    uint8_t B;
    uint8_t C;
    uint8_t D;
    uint8_t E;
    uint8_t F;
    uint8_t H;
    uint8_t L;
};
/*
 While the CPU only has 8 bit registers, there are instructions that allow the game to read and write 16 bits (i.e. 2 bytes) at the same time (denoted as u16 in Rust - a 16 bit unsigned integer). Therefore, we'll need the ability to read an write these "virtual" 16 bit registers. These registers are refered to as "af" ("a" and "f" combined), "bc" ("b" and "c" combined), "de" ("d" and "e" combinded), and finally "hl" ("h" and "l" combined).


extern uint16_t* get_af(struct registros* r);
extern uint16_t* get_bc(struct registros* r);
extern uint16_t* get_de(struct registros* r);
extern uint16_t* get_hl(struct registros* r);
*/

/* los flags estan en el registro f, los bits no mencionados son siempre 0

    Bit 7: "zero"
    Bit 6: "subtraction"
    Bit 5: "half carry"
    Bit 4: "carry"
*/
