; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl

@glob = dso_local local_unnamed_addr global i32 0, align 4

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeui(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: test_igeui:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeui_sext(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: test_igeui_sext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    addi r3, r3, -1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeui_z(i32 zeroext %a) {
; CHECK-LABEL: test_igeui_z:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, 0
  %sub = zext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeui_sext_z(i32 zeroext %a) {
; CHECK-LABEL: test_igeui_sext_z:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r3, -1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, 0
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeui_store(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: test_igeui_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    stw r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @glob
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeui_sext_store(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: test_igeui_sext_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    addi r3, r3, -1
; CHECK-NEXT:    stw r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, i32* @glob
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeui_z_store(i32 zeroext %a) {
; CHECK-LABEL: test_igeui_z_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis r3, r2, glob@toc@ha
; CHECK-NEXT:    li r4, 1
; CHECK-NEXT:    stw r4, glob@toc@l(r3)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, 0
  %conv1 = zext i1 %cmp to i32
  store i32 %conv1, i32* @glob
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeui_sext_z_store(i32 zeroext %a) {
; CHECK-LABEL: test_igeui_sext_z_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis r3, r2, glob@toc@ha
; CHECK-NEXT:    li r4, -1
; CHECK-NEXT:    stw r4, glob@toc@l(r3)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i32 %a, 0
  %conv1 = sext i1 %cmp to i32
  store i32 %conv1, i32* @glob
  ret void
}

