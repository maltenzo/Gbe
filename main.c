
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
    //printf("%x\n", cpu_->reg.H);
    //write_mem(0xABCD, number);
    //cpu_->reg.A = 0x0F;
    //cpu_->reg.H = 0xAB;
    //cpu_->reg.L = 0xCD;
    //uint16_t number= 0xFFFF;
    BIT_U3_HL(0x00);
    printf("%x\n", cpu_->reg.F);
    //printf("%x\n", cpu_->reg.L);
    //printf("%p\n", GET_HL());
    del_cpu();


    return 0;
}
