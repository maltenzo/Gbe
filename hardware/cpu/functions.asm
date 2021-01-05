%define offset_registros  0
%define offset_registros_A  0
%define offset_registros_B  1
%define offset_registros_C  2
%define offset_registros_D  3
%define offset_registros_E  4
%define offset_registros_F  5
%define offset_registros_H  6
%define offset_registros_L  7
%define offset_Memory 8
%define offset_pc 16
%define offset_sp 18
%define offset_flags 5

%define FLAG_MASK_ZERO 0b10000000;
%define FLAG_MASK_SUBTRACT 0b01000000;
%define FLAG_MASK_HALFCARRY 0b00100000;
%define FLAG_MASK_CARRY 0b00010000;

%define INTEL_MASK_ZERO   0x40
%define INTEL_MASK_CARRY  0x01
%define INTEL_MASK_HALFCARRY 0x10
;%define INTEL_MASK_SUBTRACT

extern mem_pointer
extern cpu_pointer
extern update_flags
extern GET_HL
extern SET_HL
extern GET_16
extern SET_16
global SetFlag:

;rdi = flag (de las definidas arriba)
;rsi = bool para ver si prendo la flag o la apago.
SetFlag:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, 0
    mov r13, 0

    mov r12, rdi
    mov r13, rsi

    call cpu_pointer
    add rax, offset_flags
    CMP r13, 0
    JE APAGAR
    JMP ENCENDER

    APAGAR:
      not r12b
      mov dil, [rax]
      and dil, r12b

      mov [rax],dil
      jmp FIN

    ENCENDER:
      or [rax], r12b

    FIN:
      pop r13
      pop r12
      pop rbp
      ret

global ADC
;rdi = puntero al registro de 8 bits
;rsi = valor de 8 bits
ADC:
  push rbp
  mov rbp, rsp
  push r12
  push r13
  push r14
  push r15

  mov r12, rdi ;puntero al registro
  mov r13b, sil ;numero
  mov r14b, [r12] ;numero en el registro pre-operacion

  ADC [r12],  r13b ;hago la suma con carry entre lo que hay en el registro y el numero. Luego lo guardo
  lahf
  shr rax, 8
  mov dil, al ;me guardo los flags del procesador
  ;actualizo los flags
  ;el flag sub no lo uso pues esto es una suma de numeros uint
  ;el resto de los flags puedo verlos por los flags del procesador
  call update_flags
  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag


  pop r15
  pop r14
  pop r13
  pop r12
  pop rbp
  ret

global ADC_A_R8
;rdi valor 8 bits
ADC_A_R8:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi

  call cpu_pointer
  mov rdi, rax
  add rdi, offset_registros_A
  mov rsi, r12
  call ADC

  pop r13
  pop r12
  pop rbp
  ret

global ADC_A_HL
;rdi
ADC_A_HL:
   push rbp
   mov rbp, rsp
   push r12
   push r13


   call GET_HL
   mov r12, 0
   mov r12w, ax
   call cpu_pointer

   mov rax, [rax + offset_Memory]
   mov dil, [rax + r12]
   call ADC_A_R8

   pop r13
   pop r12
   pop rbp
   ret

global ADC_A_N8
ADC_A_N8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call cpu_pointer

    mov rsi, r12
    add rax, offset_registros_A
    mov rdi, rax
    call ADC

    pop r13
    pop r12
    pop rbp
    ret

global ADD
ADD:
  push rbp
  mov rbp, rsp
  push r12
  push r13
  push r14
  push r15

  mov r12, rdi ;puntero al registro
  mov r13b, sil ;numero
  mov r14b, [r12] ;numero en el registro pre-operacion

  ADD [r12],  r13b ;hago la suma con carry entre lo que hay en el registro y el numero. Luego lo guardo
  lahf
  shr rax, 8
  mov dil, al ;me guardo los flags del procesador
  ;actualizo los flags
  ;el flag sub no lo uso pues esto es una suma de numeros uint
  ;el resto de los flags puedo verlos por los flags del procesador
  call update_flags
  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag


  pop r15
  pop r14
  pop r13
  pop r12
  pop rbp
  ret

global ADC_A_R8
;rdi valor 8 bits
ADD_A_R8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi

    call cpu_pointer
    mov rdi, rax
    add rdi, offset_registros_A
    mov rsi, r12
    call ADD

    pop r13
    pop r12
    pop rbp
    ret

global ADD_A_HL
  ;rdi
ADD_A_HL:
     push rbp
     mov rbp, rsp
     push r12
     push r13


     call GET_HL
     mov r12, 0
     mov r12w, ax
     call cpu_pointer

     mov rax, [rax + offset_Memory]
     mov dil, [rax + r12]
     call ADD_A_R8

     pop r13
     pop r12
     pop rbp
     ret

global ADD_A_N8
ADD_A_N8:
      push rbp
      mov rbp, rsp
      push r12
      push r13

      mov r12, rdi
      call cpu_pointer

      mov rsi, r12
      add rax, offset_registros_A
      mov rdi, rax
      call ADD

      pop r13
      pop r12
      pop rbp
      ret

global ADD_HL_R16
ADD_HL_R16:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  call GET_HL
  mov r12, [r12]
  add r12, rax

  lahf
  shr rax, 8
  mov rdi, rax
  call update_flags

  mov rdi, r12
  call SET_HL

  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag
  pop r13
  pop r12
  pop rbp
  ret



global AND
;rdi = *registro
;rsi  dato 8 bit

AND:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, [rdi]
  and r12b, sil
  mov [rdi],r12b
  lahf
  shr rax, 8
  mov rdi, rax
  call update_flags
  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag

  pop r13
  pop r12
  pop rbp
  ret

global AND_A_R8
AND_A_R8:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  call cpu_pointer

  mov rdi, rax
  mov rsi, r12
  call AND

  pop r13
  pop r12
  pop rbp
  ret

global AND_A_HL
AND_A_HL:
  push rbp
  mov rbp, rsp
  push r12
  push r13


  call GET_HL
  mov r12, 0
  mov r12w, ax
  call cpu_pointer

  mov rax, [rax + offset_Memory]
  mov dil, [rax + r12]
  call AND_A_R8

  pop r13
  pop r12
  pop rbp
  ret

global AND_A_N8
AND_A_N8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call cpu_pointer

    mov rdi, rax
    mov rsi, r12
    call AND

    pop r13
    pop r12
    pop rbp
    ret

global BIT_U3_R8
;rdi value 8b
;rsi bit 8b
BIT_U3_R8:
  push rbp
  mov rbp, rsp

  mov al, dil
  TEST al, sil
  lahf
  shr rax, 8
  mov rdi, rax
  call update_flags
  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag



  pop rbp
  ret

global BIT_U3_HL
BIT_U3_HL:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  Call GET_HL
  mov r13, rax
  call cpu_pointer
  mov rdi, [rax + offset_Memory]
  add rdi, r13
  mov rsi, r12
  call BIT_U3_R8

  pop r13
  pop r12
  ret

global CP_A_N8
CP_A_N8:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  call cpu_pointer

  mov dil, [rax]
  cmp dil, r12b

  lahf
  shr rax, 8

  mov rdi, rax
  call update_flags

  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 1
  call SetFlag

  pop r13
  pop r12
  pop rbp
  ret

global CP_A_R8
CP_A_R8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call cpu_pointer

    mov dil, [rax]
    cmp dil, r12b

    lahf
    shr rax, 8

    mov rdi, rax
    call update_flags

    mov rdi, FLAG_MASK_SUBTRACT
    mov rsi, 1
    call SetFlag

    pop r13
    pop r12
    pop rbp
    ret

global CP_A_HL
CP_A_HL:
    push rbp
    mov rbp, rsp
    push r12
    push r13


    call GET_HL
    mov r12, 0
    mov r12w, ax
    call cpu_pointer

    mov rax, [rax + offset_Memory]
    mov dil, [rax + r12]
    call CP_A_R8

    pop r13
    pop r12
    pop rbp
    ret

global DEC_R8
;rdi puntero al registro
DEC_R8:
  push rbp
  mov rbp, rsp

  DEC Byte [rdi]
  lahf
  shr rax, 8
  call update_flags

  call update_flags

  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 1
  call SetFlag

  pop rbp
  ret

global DEC_R16
DEC_R16:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  call GET_16
  mov rdi, r12
  mov rsi, rax
  DEC rsi
  lahf
  mov r13, rax
  call SET_16

  shr r13, 8
  mov rdi, r13
  call update_flags

  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 1
  call SetFlag


  pop r13
  pop r12
  pop rbp
  ret

global DEC_HL
DEC_HL:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  call GET_HL
  mov rdi, rax
  dec rdi
  lahf
  shr rax, 8
  mov r12, rax
  call SET_HL
  mov rdi, r12
  call update_flags

  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 1
  call SetFlag

  pop r13
  pop r12
  pop rbp
  ret

global INC_R8
INC_R8:
  push rbp
  mov rbp, rsp

  INC Byte [rdi]

  call update_flags

  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag

  pop rbp
  ret

global INC_R16
INC_R16:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call GET_16
    mov rdi, r12
    mov rsi, rax
    inc rsi
    lahf
    mov r13, rax
    call SET_16

    shr r13, 8
    mov rdi, r13
    call update_flags

    mov rdi, FLAG_MASK_SUBTRACT
    mov rsi, 0
    call SetFlag


    pop r13
    pop r12
    pop rbp
    ret

global INC_HL
INC_HL:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  call GET_HL
  mov rdi, rax
  inc rdi
  lahf
  mov r12, rax
  shr r12, 8

  call SET_HL
  mov rdi, r12
  call update_flags

  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag

  pop r13
  pop r12
  pop rbp
  ret

global OR
OR:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, [rdi]
  or r12b, sil
  mov [rdi],r12b
  lahf
  shr rax, 8
  mov rdi, rax
  call update_flags
  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 0
  call SetFlag

  pop r13
  pop r12
  pop rbp
  ret

global OR_A_R8
OR_A_R8:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  call cpu_pointer

  mov rdi, rax
  mov rsi, r12
  call OR

  pop r13
  pop r12
  pop rbp
  ret

global OR_A_HL
OR_A_HL:
  push rbp
  mov rbp, rsp
  push r12
  push r13


  call GET_HL
  mov r12, 0
  mov r12w, ax
  call cpu_pointer

  mov rax, [rax + offset_Memory]
  mov dil, [rax + r12]
  call OR_A_R8

  pop r13
  pop r12
  pop rbp
  ret

global OR_A_N8
OR_A_N8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call cpu_pointer

    mov rdi, rax
    mov rsi, r12
    call OR

    pop r13
    pop r12
    pop rbp
    ret


global SBC
;rdi = puntero al registro de 8 bits
;rsi = valor de 8 bits
SBC:
  push rbp
  mov rbp, rsp
  push r12
  push r13
  push r14
  push r15

  mov r12, rdi ;puntero al registro
  mov r13b, sil ;numero
  mov r14b, [r12] ;numero en el registro pre-operacion

  SBB [r12],  r13b ;hago la suma con carry entre lo que hay en el registro y el numero. Luego lo guardo
  lahf
  shr rax, 8
  mov dil, al ;me guardo los flags del procesador
  ;actualizo los flags
  ;el flag sub no lo uso pues esto es una suma de numeros uint
  ;el resto de los flags puedo verlos por los flags del procesador
  call update_flags
  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 1
  call SetFlag


  pop r15
  pop r14
  pop r13
  pop r12
  pop rbp
  ret

global SBC_A_R8
;rdi valor 8 bits
SBC_A_R8:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi

  call cpu_pointer
  mov rdi, rax
  add rdi, offset_registros_A
  mov rsi, r12
  call SBC

  pop r13
  pop r12
  pop rbp
  ret

global SBC_A_HL
;rdi
SBC_A_HL:
   push rbp
   mov rbp, rsp
   push r12
   push r13


   call GET_HL
   mov r12, 0
   mov r12w, ax
   call cpu_pointer

   mov rax, [rax + offset_Memory]
   mov dil, [rax + r12]
   call SBC_A_R8

   pop r13
   pop r12
   pop rbp
   ret

global SBC_A_N8
SBC_A_N8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call cpu_pointer

    mov rsi, r12
    add rax, offset_registros_A
    mov rdi, rax
    call SBC

    pop r13
    pop r12
    pop rbp
    ret

SUB:
  push rbp
  mov rbp, rsp
  push r12
  push r13
  push r14
  push r15

  mov r12, rdi ;puntero al registro
  mov r13b, sil ;numero
  mov r14b, [r12] ;numero en el registro pre-operacion

  SUB [r12],  r13b ;hago la suma con carry entre lo que hay en el registro y el numero. Luego lo guardo
  lahf
  shr rax, 8
  mov dil, al ;me guardo los flags del procesador
  ;actualizo los flags
  ;el flag sub no lo uso pues esto es una suma de numeros uint
  ;el resto de los flags puedo verlos por los flags del procesador
  call update_flags
  mov rdi, FLAG_MASK_SUBTRACT
  mov rsi, 1
  call SetFlag


  pop r15
  pop r14
  pop r13
  pop r12
  pop rbp
  ret

global SUB_A_R8
;rdi valor 8 bits
SUB_A_R8:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi

  call cpu_pointer
  mov rdi, rax
  add rdi, offset_registros_A
  mov rsi, r12
  call SUB

  pop r13
  pop r12
  pop rbp
  ret

global SUB_A_HL
;rdi
SUB_A_HL:
   push rbp
   mov rbp, rsp
   push r12
   push r13


   call GET_HL
   mov r12, 0
   mov r12w, ax
   call cpu_pointer

   mov rax, [rax + offset_Memory]
   mov dil, [rax + r12]
   call SUB_A_R8

   pop r13
   pop r12
   pop rbp
   ret

global SUB_A_N8
SUB_A_N8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call cpu_pointer

    mov rsi, r12
    add rax, offset_registros_A
    mov rdi, rax
    call SUB

    pop r13
    pop r12
    pop rbp
    ret

global XOR
XOR:
      push rbp
      mov rbp, rsp
      push r12
      push r13

      mov r12, [rdi]
      xor r12b, sil
      mov [rdi],r12b
      lahf
      shr rax, 8
      mov rdi, rax
      call update_flags
      mov rdi, FLAG_MASK_SUBTRACT
      mov rsi, 0
      call SetFlag

      pop r13
      pop r12
      pop rbp
      ret

global XOR_A_R8
XOR_A_R8:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  call cpu_pointer

  mov rdi, rax
  mov rsi, r12
  call XOR

  pop r13
  pop r12
  pop rbp
  ret

global XOR_A_HL
XOR_A_HL:
  push rbp
  mov rbp, rsp
  push r12
  push r13


  call GET_HL
  mov r12, 0
  mov r12w, ax
  call cpu_pointer

  mov rax, [rax + offset_Memory]
  mov dil, [rax + r12]
  call XOR_A_R8

  pop r13
  pop r12
  pop rbp
  ret

global XOR_A_N8
XOR_A_N8:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    call cpu_pointer

    mov rdi, rax
    mov rsi, r12
    call XOR

    pop r13
    pop r12
    pop rbp
    ret
