; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=tahiti -verify-machineinstrs -o - < %s | FileCheck %s --check-prefixes=GFX,GFX6
; RUN: llc -global-isel -march=amdgcn -mcpu=fiji -verify-machineinstrs -o - < %s | FileCheck %s --check-prefixes=GFX,GFX8

declare i16 @llvm.abs.i16(i16, i1)
declare i32 @llvm.abs.i32(i32, i1)
declare i64 @llvm.abs.i64(i64, i1)
declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1)

define amdgpu_cs i16 @abs_sgpr_i16(i16 inreg %arg) {
; GFX-LABEL: abs_sgpr_i16:
; GFX:       ; %bb.0:
; GFX-NEXT:    s_sext_i32_i16 s0, s0
; GFX-NEXT:    s_abs_i32 s0, s0
; GFX-NEXT:    ; return to shader part epilog
  %res = call i16 @llvm.abs.i16(i16 %arg, i1 false)
  ret i16 %res
}

define amdgpu_cs i32 @abs_sgpr_i32(i32 inreg %arg) {
; GFX-LABEL: abs_sgpr_i32:
; GFX:       ; %bb.0:
; GFX-NEXT:    s_abs_i32 s0, s0
; GFX-NEXT:    ; return to shader part epilog
  %res = call i32 @llvm.abs.i32(i32 %arg, i1 false)
  ret i32 %res
}

define amdgpu_cs i64 @abs_sgpr_i64(i64 inreg %arg) {
; GFX-LABEL: abs_sgpr_i64:
; GFX:       ; %bb.0:
; GFX-NEXT:    s_ashr_i32 s2, s1, 31
; GFX-NEXT:    s_add_u32 s0, s0, s2
; GFX-NEXT:    s_cselect_b32 s4, 1, 0
; GFX-NEXT:    s_and_b32 s4, s4, 1
; GFX-NEXT:    s_cmp_lg_u32 s4, 0
; GFX-NEXT:    s_mov_b32 s3, s2
; GFX-NEXT:    s_addc_u32 s1, s1, s2
; GFX-NEXT:    s_xor_b64 s[0:1], s[0:1], s[2:3]
; GFX-NEXT:    ; return to shader part epilog
  %res = call i64 @llvm.abs.i64(i64 %arg, i1 false)
  ret i64 %res
}

define amdgpu_cs <4 x i32> @abs_sgpr_v4i32(<4 x i32> inreg %arg) {
; GFX-LABEL: abs_sgpr_v4i32:
; GFX:       ; %bb.0:
; GFX-NEXT:    s_abs_i32 s0, s0
; GFX-NEXT:    s_abs_i32 s1, s1
; GFX-NEXT:    s_abs_i32 s2, s2
; GFX-NEXT:    s_abs_i32 s3, s3
; GFX-NEXT:    ; return to shader part epilog
  %res = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %arg, i1 false)
  ret <4 x i32> %res
}

define amdgpu_cs i16 @abs_vgpr_i16(i16 %arg) {
; GFX6-LABEL: abs_vgpr_i16:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX6-NEXT:    v_sub_i32_e32 v1, vcc, 0, v0
; GFX6-NEXT:    v_max_i32_e32 v0, v0, v1
; GFX6-NEXT:    v_readfirstlane_b32 s0, v0
; GFX6-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: abs_vgpr_i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_sub_u16_e32 v1, 0, v0
; GFX8-NEXT:    v_max_i16_e32 v0, v0, v1
; GFX8-NEXT:    v_readfirstlane_b32 s0, v0
; GFX8-NEXT:    ; return to shader part epilog
  %res = call i16 @llvm.abs.i16(i16 %arg, i1 false)
  ret i16 %res
}

define amdgpu_cs i32 @abs_vgpr_i32(i32 %arg) {
; GFX6-LABEL: abs_vgpr_i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_sub_i32_e32 v1, vcc, 0, v0
; GFX6-NEXT:    v_max_i32_e32 v0, v0, v1
; GFX6-NEXT:    v_readfirstlane_b32 s0, v0
; GFX6-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: abs_vgpr_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_sub_u32_e32 v1, vcc, 0, v0
; GFX8-NEXT:    v_max_i32_e32 v0, v0, v1
; GFX8-NEXT:    v_readfirstlane_b32 s0, v0
; GFX8-NEXT:    ; return to shader part epilog
  %res = call i32 @llvm.abs.i32(i32 %arg, i1 false)
  ret i32 %res
}

define amdgpu_cs i64 @abs_vgpr_i64(i64 %arg) {
; GFX6-LABEL: abs_vgpr_i64:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_ashrrev_i32_e32 v2, 31, v1
; GFX6-NEXT:    v_add_i32_e32 v0, vcc, v0, v2
; GFX6-NEXT:    v_addc_u32_e32 v1, vcc, v1, v2, vcc
; GFX6-NEXT:    v_xor_b32_e32 v0, v0, v2
; GFX6-NEXT:    v_xor_b32_e32 v1, v1, v2
; GFX6-NEXT:    v_readfirstlane_b32 s0, v0
; GFX6-NEXT:    v_readfirstlane_b32 s1, v1
; GFX6-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: abs_vgpr_i64:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_ashrrev_i32_e32 v2, 31, v1
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, v0, v2
; GFX8-NEXT:    v_addc_u32_e32 v1, vcc, v1, v2, vcc
; GFX8-NEXT:    v_xor_b32_e32 v0, v0, v2
; GFX8-NEXT:    v_xor_b32_e32 v1, v1, v2
; GFX8-NEXT:    v_readfirstlane_b32 s0, v0
; GFX8-NEXT:    v_readfirstlane_b32 s1, v1
; GFX8-NEXT:    ; return to shader part epilog
  %res = call i64 @llvm.abs.i64(i64 %arg, i1 false)
  ret i64 %res
}

define amdgpu_cs <4 x i32> @abs_vgpr_v4i32(<4 x i32> %arg) {
; GFX6-LABEL: abs_vgpr_v4i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_sub_i32_e32 v4, vcc, 0, v0
; GFX6-NEXT:    v_max_i32_e32 v0, v0, v4
; GFX6-NEXT:    v_sub_i32_e32 v4, vcc, 0, v1
; GFX6-NEXT:    v_max_i32_e32 v1, v1, v4
; GFX6-NEXT:    v_sub_i32_e32 v4, vcc, 0, v2
; GFX6-NEXT:    v_max_i32_e32 v2, v2, v4
; GFX6-NEXT:    v_sub_i32_e32 v4, vcc, 0, v3
; GFX6-NEXT:    v_max_i32_e32 v3, v3, v4
; GFX6-NEXT:    v_readfirstlane_b32 s0, v0
; GFX6-NEXT:    v_readfirstlane_b32 s1, v1
; GFX6-NEXT:    v_readfirstlane_b32 s2, v2
; GFX6-NEXT:    v_readfirstlane_b32 s3, v3
; GFX6-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: abs_vgpr_v4i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_sub_u32_e32 v4, vcc, 0, v0
; GFX8-NEXT:    v_max_i32_e32 v0, v0, v4
; GFX8-NEXT:    v_sub_u32_e32 v4, vcc, 0, v1
; GFX8-NEXT:    v_max_i32_e32 v1, v1, v4
; GFX8-NEXT:    v_sub_u32_e32 v4, vcc, 0, v2
; GFX8-NEXT:    v_max_i32_e32 v2, v2, v4
; GFX8-NEXT:    v_sub_u32_e32 v4, vcc, 0, v3
; GFX8-NEXT:    v_max_i32_e32 v3, v3, v4
; GFX8-NEXT:    v_readfirstlane_b32 s0, v0
; GFX8-NEXT:    v_readfirstlane_b32 s1, v1
; GFX8-NEXT:    v_readfirstlane_b32 s2, v2
; GFX8-NEXT:    v_readfirstlane_b32 s3, v3
; GFX8-NEXT:    ; return to shader part epilog
  %res = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %arg, i1 false)
  ret <4 x i32> %res
}
