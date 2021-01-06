//
// Created by maltenzo on 1/1/21.
//
#ifndef EMULADOR_INSTRUCTIONS_H
#define EMULADOR_INSTRUCTIONS_H
#include <stdint.h>
#include <stdbool.h>

extern void SetFlag(int flag, bool value);//chequeado

extern void ADC(uint8_t* target, uint8_t value);//chequeado
extern void ADC_A_R8(uint8_t value);
extern void ADC_A_HL();
extern void ADC_A_N8(uint8_t value);

extern void ADD(uint8_t* target, uint8_t value);
extern void ADD_A_R8(uint8_t value);
extern void ADD_A_HL();
extern void ADD_A_N8(uint8_t value);
extern void ADD_HL_R16(uint16_t value);

extern void AND(uint8_t* target, uint8_t value);
extern void AND_A_R8(uint8_t value);
extern void AND_A_HL();
extern void AND_A_N8(uint8_t value);

extern void BIT_U3_R8(uint8_t value, uint8_t bit);
extern void BIT_U3_HL(uint8_t bit);


extern void CP_A_R8(uint8_t value);
extern void CP_A_HL();
extern void CP_A_N8(uint8_t value);

extern void DEC_R8(uint8_t* target);
extern void DEC_HL();
extern void DEC_R16(uint16_t* target);

extern void INC_R8(uint8_t* target);
extern void INC_R16(uint16_t* registro);
extern void INC_HL();

extern void LD_A_N16(uint16_t addr);
extern void LD_A_R16(uint16_t addr);
extern void LD_R8_N8(uint8_t* reg, uint8_t inmediato);
extern void LD_R8_R8(uint8_t* target, uint8_t value);
extern void LD_HL_N8(uint8_t value);
extern void LD_HL_R8(uint8_t value);
extern void LD_R8_HL(uint8_t* target);
extern void LD_R16_A(uint16_t A);
extern void LD_N16_A(uint16_t addr);
extern void LD_R16_N16(uint16_t* registro, uint16_t inmediato);
extern void LDH_A_C();
extern void LDH_C_A();
extern void LDH_A_N16(uint16_t value);
extern void LDH_N16_A(uint16_t value);
extern void LD_HLI_A();
extern void LD_HLD_A();
extern void LD_A_HLI();
extern void LD_A_HLD();
extern void LD_SP_N16(uint16_t value);
extern void LD_N16_SP(uint16_t addr);
extern void LD_HL_SP_E8(uint8_t offset);
extern void LD_SP_HL();


extern void OR(uint8_t* target, uint8_t value);
extern void OR_A_R8(uint8_t value);
extern void OR_A_HL();
extern void OR_A_N8(uint8_t value);

extern void RES_U3_R8(uint8_t* target, uint8_t bit);
extern void RES_U3_HL(uint8_t bit);

extern void RL(uint16_t addr, bool carry);
extern void RLZ(uint8_t* target, bool carry, bool zero_flag);

extern void SBC(uint8_t* target, uint8_t value);
extern void SBC_A_R8(uint8_t value);
extern void SBC_A_HL();
extern void SBC_A_N8(uint8_t value);

extern void SET_U3_R8(uint8_t* target, uint8_t bit);
extern void SET_U3_HL(uint8_t bit);

extern void SUB(uint8_t* target, uint8_t value);
extern void SUB_A_R8(uint8_t value);
extern void SUB_A_HL();
extern void SUB_A_N8(uint8_t value);

extern void SWAP_R8(uint8_t* target);
extern void SWAP_HL();

extern void XOR(uint8_t* target, uint8_t value);
extern void XOR_A_R8(uint8_t value);
extern void XOR_A_HL();
extern void XOR_A_N8(uint8_t value);

/*

extern void ADD_HL_SP();
extern void ADD_SP_E8(uint8_t offset);





extern void CALL(uint16_t addr);
extern void CALL_N16(uint16_t addr);
extern void CALLNZ_N16(uint16_t addr);
extern void CALLZ_N16(uint16_t addr);
extern void CALLNC_N16(uint16_t addr);printf("%x\n", cpu_->reg.F);
extern void CALLC_N16(uint16_t addr);

extern void CCF();
extern void CPL();



extern void DAA();

extern void DEC_SP();
extern void DI();


extern void EI();

extern void HALT();


extern void INC_SP();

extern void JP(uint16_t target);
extern void JP_HL();
extern void JP_N16(uint16_t addr);
extern void JPNZ_N16(uint16_t target);
extern void JPZ_N16(uint16_t target);
extern void JPNC_N16(uint16_t target);
extern void JPC_N16(uint16_t target);
extern void JR(uint8_t value);
extern void JR_N8(uint8_t value);
extern void JRNZ_N8(uint8_t value);
extern void JRZ_N8(uint8_t value);
extern void JRNC_N8(uint8_t value);
extern void JRC_N8(uint8_t value);




extern void NOP();



extern void POP_AF();
extern void POP_R16(uint16_t* value);

extern void PUSH_AF();
extern void PUSH_R16(uint16_t value);

extern void RET();
extern void RET_Impl();
extern void RETI();
extern void RETNZ();
extern void RETZ();
extern void RETNC();
extern void RETC();
extern void RST_VEC(uint16_t addr);




extern void RL_R8(uint8_t* target);
extern void RL_HL();
extern void RLA();
extern void RLC_R8(uint8_t* target);
extern void RLC_HL();
extern void RLCA();
extern void RR_HL();
extern void RR_R8(uint8_t* target);
extern void RR_A();
extern void RRC_R8(uint8_t* target);
extern void RRC_HL();
extern void RR(uint16_t addr, bool carry);
extern void RRZ(uint8_t* target, bool carry, bool zero_flag);
extern void RRC_A();



extern void SCF();
extern void SLA_R8(uint8_t* target);

extern void SLA_HL();
extern void SR(uint8_t* target, bool include_top_bit);

extern void SRA_R8(uint8_t* target);
extern void SRA_HL();
extern void SRL_R8(uint8_t* target);
extern void SRL_HL();




extern void STOP();








*/




















#endif //EMULADOR_INSTRUCTIONS_H
