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
%define tam_cpu 24
%define tam_mem 0xFFFF

%define FLAG_MASK_ZERO 0b10000000;
%define FLAG_MASK_SUBTRACT 0b01000000;
%define FLAG_MASK_HALFCARRY 0b00100000;
%define FLAG_MASK_CARRY 0b00010000;

%define INTEL_MASK_ZERO   0x40
%define INTEL_MASK_CARRY  0x01
%define INTEL_MASK_HALFCARRY 0x10

extern malloc
extern calloc
extern free
extern SetFlag
extern cpu_pointer
extern mem_pointer

global new_cpu
global del_cpu
global write_mem
global read_mem
global GET_HL
global SET_HL
global update_flags



new_cpu:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov rdi, 1
  mov rsi, tam_cpu
  call calloc
  mov r12, rax

  mov rdi, 1
  mov rsi, tam_mem
  call calloc
  mov [r12 + offset_Memory], rax

  mov rax, r12

  pop r13
  pop r12
  pop rbp
  ret


del_cpu:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    call cpu_pointer
    mov r12, rax
    mov rdi, [r12 + offset_Memory]

    call free

    mov rdi, r12
    call free

    pop r13
    pop r12
    pop rbp
    ret


    ;rdi offset 16 bits
    ;rsi dato 8bits

write_mem:
      push rbp
      mov rbp, rsp
      push r12
      push r13


      mov r12, 0
      mov r13, 0
      mov r12w, di
      mov r13b, sil


      call cpu_pointer ;consigo el punero al cpu
      mov rax, [rax + offset_Memory]; ahora rax es el puntero a la memoria
      mov [rax + r12], r13b;escribo en al memoria
      pop r13
      pop r12
      pop rbp
      ret

read_mem:
        push rbp
        mov rbp, rsp
        push r12
        push r13


        mov r12, 0
        mov r13, 0
        mov r12w, di
        mov r13b, sil


        call cpu_pointer ;consigo el punero al cpu
        mov rax, [rax + offset_Memory]; ahora rax es el puntero a la memoria
        mov al, [rax + r12];leo de la memoria
        pop r13
        pop r12
        pop rbp
        ret

update_flags:
  push rbp
  mov rbp, rsp
  push r12
  push r15
  mov r15b, dil
    zero_flag:
      mov dil, INTEL_MASK_ZERO
      and dil, r15b
      mov dil, FLAG_MASK_ZERO
      mov rsi, 0
      jz call_zero
      mov rsi, 1
    call_zero:
      call SetFlag

    carry_flag:
      mov dil, INTEL_MASK_CARRY
      and dil, r15b
      mov dil, FLAG_MASK_CARRY
      mov rsi, 0
      jz call_carry
      mov rsi, 1
      call_carry:
        call SetFlag

    h_carry_flag:
      mov dil, INTEL_MASK_HALFCARRY
      and dil, r15b
      mov dil, FLAG_MASK_HALFCARRY
      mov rsi, 0
      jz call_h_carry
      mov rsi, 1
      call_h_carry:
          call SetFlag
    pop r15
    pop r12
    pop rbp
    ret

GET_HL:
  push rbp
  mov rbp, rsp

  call cpu_pointer
  mov dil, [rax + offset_registros_H]
  mov sil, [rax + offset_registros_L]
  shl di, 8
  shl si, 8
  shr si, 8
  or di, si
  mov rax, 0
  mov ax, di
  pop rbp
  ret

SET_HL:
  push rbp
  mov rbp, rsp
  push r12
  push r13

  mov r12, rdi
  call cpu_pointer
  mov r13, rax

  mov dil, r12b
  mov [r13 + offset_registros_L], dil
  shr r12, 8
  mov dil, r12b
  mov [r13 + offset_registros_H], dil

  pop r13
  pop r12
  pop rbp
  ret

global GET_16
GET_16:
  push rbp
  mov rbp, rsp


  mov dl, [rdi]
  mov sil, [rdi + 8]
  shl dx, 8
  shl si, 8
  shr si, 8
  or dx, si
  mov rax, 0
  mov ax, dx
  pop rbp
  ret

global SET_16
SET_16:
push rbp
mov rbp, rsp


mov [rdi + 8], dl
shr dx, 8
mov [rdi + offset_registros_H], dl


pop rbp
ret
