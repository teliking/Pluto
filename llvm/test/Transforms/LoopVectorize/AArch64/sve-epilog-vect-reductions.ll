; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -loop-vectorize -mtriple aarch64-unknown-linux-gnu -mattr=+sve -epilogue-vectorization-force-VF=2 -S | FileCheck %s

;
; Integer reduction with interleaving & a start value of 5
;
define i64 @int_reduction_add(i64* %a, i64 %N) {
; CHECK-LABEL: @int_reduction_add(
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 4
; CHECK-NEXT:    [[MIN_ITERS_CHECK1:%.*]] = icmp ult i64 [[N]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK1]], label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 4
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], [[TMP3]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <vscale x 2 x i64> [ insertelement (<vscale x 2 x i64> zeroinitializer, i64 5, i32 0), [[VECTOR_PH]] ], [ [[TMP18:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <vscale x 2 x i64> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP19:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 2
; CHECK-NEXT:    [[TMP7:%.*]] = add i64 [[TMP6]], 0
; CHECK-NEXT:    [[TMP8:%.*]] = mul i64 [[TMP7]], 1
; CHECK-NEXT:    [[TMP9:%.*]] = add i64 [[INDEX]], [[TMP8]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[TMP4]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[TMP9]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i64, i64* [[TMP10]], i32 0
; CHECK-NEXT:    [[TMP13:%.*]] = bitcast i64* [[TMP12]] to <vscale x 2 x i64>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP13]], align 4
; CHECK-NEXT:    [[TMP14:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP15:%.*]] = mul i32 [[TMP14]], 2
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i64, i64* [[TMP10]], i32 [[TMP15]]
; CHECK-NEXT:    [[TMP17:%.*]] = bitcast i64* [[TMP16]] to <vscale x 2 x i64>*
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP17]], align 4
; CHECK-NEXT:    [[TMP18]] = add <vscale x 2 x i64> [[WIDE_LOAD]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP19]] = add <vscale x 2 x i64> [[WIDE_LOAD3]], [[VEC_PHI2]]
; CHECK-NEXT:    [[TMP20:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP21:%.*]] = mul i64 [[TMP20]], 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP21]]
; CHECK-NEXT:    [[TMP22:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP22]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <vscale x 2 x i64> [[TMP19]], [[TMP18]]
; CHECK-NEXT:    [[TMP23:%.*]] = call i64 @llvm.vector.reduce.add.nxv2i64(<vscale x 2 x i64> [[BIN_RDX]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    [[N_VEC_REMAINING:%.*]] = sub i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    [[MIN_EPILOG_ITERS_CHECK:%.*]] = icmp ult i64 [[N_VEC_REMAINING]], 2
; CHECK-NEXT:    br i1 [[MIN_EPILOG_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i64 [ 5, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ], [ [[TMP23]], [[VEC_EPILOG_ITER_CHECK]] ]
; CHECK-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; CHECK-NEXT:    [[N_MOD_VF5:%.*]] = urem i64 [[N]], 2
; CHECK-NEXT:    [[N_VEC6:%.*]] = sub i64 [[N]], [[N_MOD_VF5]]
; CHECK-NEXT:    [[TMP24:%.*]] = insertelement <2 x i64> zeroinitializer, i64 [[BC_MERGE_RDX]], i32 0
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX8:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT11:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI9:%.*]] = phi <2 x i64> [ [[TMP24]], [[VEC_EPILOG_PH]] ], [ [[TMP29:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP25:%.*]] = add i64 [[INDEX8]], 0
; CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[TMP25]]
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds i64, i64* [[TMP26]], i32 0
; CHECK-NEXT:    [[TMP28:%.*]] = bitcast i64* [[TMP27]] to <2 x i64>*
; CHECK-NEXT:    [[WIDE_LOAD10:%.*]] = load <2 x i64>, <2 x i64>* [[TMP28]], align 4
; CHECK-NEXT:    [[TMP29]] = add <2 x i64> [[WIDE_LOAD10]], [[VEC_PHI9]]
; CHECK-NEXT:    [[INDEX_NEXT11]] = add nuw i64 [[INDEX8]], 2
; CHECK-NEXT:    [[TMP30:%.*]] = icmp eq i64 [[INDEX_NEXT11]], [[N_VEC6]]
; CHECK-NEXT:    br i1 [[TMP30]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    [[TMP31:%.*]] = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> [[TMP29]])
; CHECK-NEXT:    [[CMP_N7:%.*]] = icmp eq i64 [[N]], [[N_VEC6]]
; CHECK-NEXT:    br i1 [[CMP_N7]], label [[FOR_END_LOOPEXIT:%.*]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC6]], [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[ITER_CHECK:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX12:%.*]] = phi i64 [ 5, [[ITER_CHECK]] ], [ [[TMP23]], [[VEC_EPILOG_ITER_CHECK]] ], [ [[TMP31]], [[VEC_EPILOG_MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi i64 [ [[BC_MERGE_RDX12]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[ADD:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[IV]]
; CHECK-NEXT:    [[TMP32:%.*]] = load i64, i64* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ADD]] = add i64 [[TMP32]], [[SUM]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    [[ADD_LCSSA4:%.*]] = phi i64 [ [[ADD]], [[FOR_BODY]] ], [ [[TMP31]], [[VEC_EPILOG_MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i64 [ [[TMP23]], [[MIDDLE_BLOCK]] ], [ [[ADD_LCSSA4]], [[FOR_END_LOOPEXIT]] ]
; CHECK-NEXT:    ret i64 [[ADD_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum = phi i64 [ 5, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i64, i64* %a, i64 %iv
  %0 = load i64, i64* %arrayidx
  %add = add i64 %0, %sum
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i64 %add
}

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.interleave.count", i32 2}
!2 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}
