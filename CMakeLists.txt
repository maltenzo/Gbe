cmake_minimum_required(VERSION 3.17)
project(emulador C)

set(CMAKE_C_STANDARD 11)

add_executable(emulador main.c hardware/Memory.cpp hardware/cpu/cpu_reg.c hardware/cpu/cpu.c hardware/cpu/instructions.h includes.h hardware/cpu/cpu.h hardware/GPU.c)