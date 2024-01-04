; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv32 -mattr=+zfh -verify-machineinstrs \
; RUN:   < %s | FileCheck -check-prefix=RV32IZFH %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   < %s | FileCheck -check-prefix=RV64IZFH %s

; This file tests cases where simple floating point operations can be
; profitably handled though bit manipulation if a soft-float ABI is being used
; (e.g. fneg implemented by XORing the sign bit). This is typically handled in
; DAGCombiner::visitBITCAST, but this target-independent code may not trigger
; in cases where we perform custom legalisation (e.g. RV64F).

define half @fneg(half %a) nounwind {
; RV32I-LABEL: fneg:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048568
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IZFH-LABEL: fneg:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    lui a1, 1048568
; RV32IZFH-NEXT:    xor a0, a0, a1
; RV32IZFH-NEXT:    ret
;
; RV64I-LABEL: fneg:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lui a1, 1048568
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: fneg:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    lui a1, 1048568
; RV64IZFH-NEXT:    xor a0, a0, a1
; RV64IZFH-NEXT:    ret
  %1 = fneg half %a
  ret half %1
}

declare half @llvm.fabs.f16(half)

define half @fabs(half %a) nounwind {
; RV32I-LABEL: fabs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 17
; RV32I-NEXT:    srli a0, a0, 17
; RV32I-NEXT:    ret
;
; RV32IZFH-LABEL: fabs:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    slli a0, a0, 17
; RV32IZFH-NEXT:    srli a0, a0, 17
; RV32IZFH-NEXT:    ret
;
; RV64I-LABEL: fabs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 49
; RV64I-NEXT:    srli a0, a0, 49
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: fabs:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    slli a0, a0, 49
; RV64IZFH-NEXT:    srli a0, a0, 49
; RV64IZFH-NEXT:    ret
  %1 = call half @llvm.fabs.f16(half %a)
  ret half %1
}

declare half @llvm.copysign.f16(half, half)

; DAGTypeLegalizer::SoftenFloatRes_FCOPYSIGN will convert to bitwise
; operations if half precision floating point isn't supported. A combine could
; be written to do the same even when f16 is legal.

define half @fcopysign_fneg(half %a, half %b) nounwind {
; RV32I-LABEL: fcopysign_fneg:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    lui a2, 1048568
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    slli a0, a0, 17
; RV32I-NEXT:    srli a0, a0, 17
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IZFH-LABEL: fcopysign_fneg:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmv.h.x ft0, a1
; RV32IZFH-NEXT:    fmv.h.x ft1, a0
; RV32IZFH-NEXT:    fsgnjn.h ft0, ft1, ft0
; RV32IZFH-NEXT:    fmv.x.h a0, ft0
; RV32IZFH-NEXT:    ret
;
; RV64I-LABEL: fcopysign_fneg:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a1
; RV64I-NEXT:    lui a2, 1048568
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    slli a0, a0, 49
; RV64I-NEXT:    srli a0, a0, 49
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: fcopysign_fneg:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmv.h.x ft0, a1
; RV64IZFH-NEXT:    fmv.h.x ft1, a0
; RV64IZFH-NEXT:    fsgnjn.h ft0, ft1, ft0
; RV64IZFH-NEXT:    fmv.x.h a0, ft0
; RV64IZFH-NEXT:    ret
  %1 = fneg half %b
  %2 = call half @llvm.copysign.f16(half %a, half %1)
  ret half %2
}
