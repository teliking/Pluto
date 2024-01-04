; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s
; ModuleID = '<stdin>'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"
target triple = "i386-apple-darwin10.0"
module asm ".globl _foo"
module asm "_foo: ret"
module asm ".globl _i"
module asm ".set _i, 0"
@i = extern_weak global i32		; <i32*> [#uses=2]
@j = common global i32 0		; <i32*> [#uses=1]
@ed = common global double 0.000000e+00, align 8		; <double*> [#uses=1]

define i32 @main() nounwind ssp {
; CHECK-LABEL: @main(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB4:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    br i1 icmp ne (i32* @i, i32* null), label [[BB1:%.*]], label [[BB3:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* @i, align 4
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    [[STOREMERGE:%.*]] = phi i32 [ [[TMP0]], [[BB1]] ], [ 0, [[BB:%.*]] ]
; CHECK-NEXT:    store i32 [[STOREMERGE]], i32* @j, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = sitofp i32 [[STOREMERGE]] to double
; CHECK-NEXT:    [[TMP2:%.*]] = call double @sin(double [[TMP1]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    [[TMP3:%.*]] = fadd double [[TMP2]], [[D_0:%.*]]
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[L_0:%.*]], 1
; CHECK-NEXT:    br label [[BB4]]
; CHECK:       bb4:
; CHECK-NEXT:    [[D_0]] = phi double [ undef, [[ENTRY:%.*]] ], [ [[TMP3]], [[BB3]] ]
; CHECK-NEXT:    [[L_0]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP4]], [[BB3]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp sgt i32 [[L_0]], 99
; CHECK-NEXT:    br i1 [[TMP5]], label [[BB5:%.*]], label [[BB]]
; CHECK:       bb5:
; CHECK-NEXT:    store double [[D_0]], double* @ed, align 8
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %bb4

bb:		; preds = %bb4
  br i1 icmp ne (i32* @i, i32* null), label %bb1, label %bb2

bb1:		; preds = %bb
  %0 = load i32, i32* @i, align 4		; <i32> [#uses=1]
  br label %bb3

bb2:		; preds = %bb
  br label %bb3

bb3:		; preds = %bb2, %bb1
  %storemerge = phi i32 [ %0, %bb1 ], [ 0, %bb2 ]		; <i32> [#uses=2]
  store i32 %storemerge, i32* @j
  %1 = sitofp i32 %storemerge to double		; <double> [#uses=1]
  %2 = call double @sin(double %1) nounwind readonly		; <double> [#uses=1]
  %3 = fadd double %2, %d.0		; <double> [#uses=1]
  %4 = add i32 %l.0, 1		; <i32> [#uses=1]
  br label %bb4

bb4:		; preds = %bb3, %entry
  %d.0 = phi double [ undef, %entry ], [ %3, %bb3 ]		; <double> [#uses=2]
  %l.0 = phi i32 [ 0, %entry ], [ %4, %bb3 ]		; <i32> [#uses=2]
  %5 = icmp sgt i32 %l.0, 99		; <i1> [#uses=1]
  br i1 %5, label %bb5, label %bb

bb5:		; preds = %bb4
  store double %d.0, double* @ed, align 8
  ret i32 0
}

declare double @sin(double) nounwind readonly
