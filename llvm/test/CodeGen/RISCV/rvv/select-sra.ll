; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefix=RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefix=RV64

; This test checks a regression in the select-to-sra transform, which was
; asserting (without a precondition) when the vector constants implicitly
; truncated their inputs, as we do on RV64.
define <4 x i32> @vselect_of_consts(<4 x i1> %cc) {
; RV32-LABEL: vselect_of_consts:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, 284280
; RV32-NEXT:    addi a0, a0, 291
; RV32-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; RV32-NEXT:    vmv.v.x v8, a0
; RV32-NEXT:    lui a0, 214376
; RV32-NEXT:    addi a0, a0, -2030
; RV32-NEXT:    vmerge.vxm v8, v8, a0, v0
; RV32-NEXT:    ret
;
; RV64-LABEL: vselect_of_consts:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, 284280
; RV64-NEXT:    addiw a0, a0, 291
; RV64-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; RV64-NEXT:    vmv.v.x v8, a0
; RV64-NEXT:    lui a0, 214376
; RV64-NEXT:    addiw a0, a0, -2030
; RV64-NEXT:    vmerge.vxm v8, v8, a0, v0
; RV64-NEXT:    ret
  %v = select <4 x i1> %cc, <4 x i32> <i32 878082066, i32 878082066, i32 878082066, i32 878082066>, <4 x i32> <i32 1164411171, i32 1164411171, i32 1164411171, i32 1164411171>
  ret <4 x i32> %v
}
