
#include <stdio.h>
#include <stdlib.h>
#include "hardware/cpu/cpu.c"
extern uint16_t GET_HL();
CPU_t* cpu_;
CPU_t* cpu_pointer(){
    return cpu_;
}
Memory_t* mem_pointer(){
  return (cpu_->mem);
}
int main() {
    cpu_ = new_cpu();
    uint8_t number= 0xAB;
    //printf("%x\n", cpu_->reg.H);
    write_mem(0xAB00, number);
    //cpu_->reg.A = 0xFF;
    cpu_->reg.H = 0xAB;
    cpu_->reg.L = 0x00;
    printf("%x\n", read_mem(GET_HL()));
    SWAP_HL();
    printf("%x\n", read_mem(GET_HL()));
    //printf("%p\n", GET_HL());
    del_cpu();


    return 0;
}
