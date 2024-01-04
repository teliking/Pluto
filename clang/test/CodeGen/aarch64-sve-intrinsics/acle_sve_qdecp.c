// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svqdecp_n_s32_b8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv16i1(i32 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    ret i32 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z21test_svqdecp_n_s32_b8iu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv16i1(i32 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    ret i32 [[TMP0]]
//
int32_t test_svqdecp_n_s32_b8(int32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s32,_b8,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_s32_b16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv8i1(i32 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret i32 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_s32_b16iu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv8i1(i32 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i32 [[TMP1]]
//
int32_t test_svqdecp_n_s32_b16(int32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s32,_b16,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_s32_b32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv4i1(i32 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CHECK-NEXT:    ret i32 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_s32_b32iu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv4i1(i32 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i32 [[TMP1]]
//
int32_t test_svqdecp_n_s32_b32(int32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s32,_b32,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_s32_b64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv2i1(i32 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CHECK-NEXT:    ret i32 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_s32_b64iu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv2i1(i32 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i32 [[TMP1]]
//
int32_t test_svqdecp_n_s32_b64(int32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s32,_b64,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_s64_b8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv16i1(i64 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    ret i64 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z21test_svqdecp_n_s64_b8lu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv16i1(i64 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    ret i64 [[TMP0]]
//
int64_t test_svqdecp_n_s64_b8(int64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s64,_b8,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_s64_b16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv8i1(i64 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret i64 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_s64_b16lu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv8i1(i64 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i64 [[TMP1]]
//
int64_t test_svqdecp_n_s64_b16(int64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s64,_b16,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_s64_b32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv4i1(i64 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CHECK-NEXT:    ret i64 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_s64_b32lu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv4i1(i64 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i64 [[TMP1]]
//
int64_t test_svqdecp_n_s64_b32(int64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s64,_b32,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_s64_b64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv2i1(i64 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CHECK-NEXT:    ret i64 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_s64_b64lu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv2i1(i64 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i64 [[TMP1]]
//
int64_t test_svqdecp_n_s64_b64(int64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_s64,_b64,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u32_b8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv16i1(i32 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    ret i32 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z21test_svqdecp_n_u32_b8ju10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv16i1(i32 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    ret i32 [[TMP0]]
//
uint32_t test_svqdecp_n_u32_b8(uint32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u32,_b8,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u32_b16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv8i1(i32 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret i32 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_u32_b16ju10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv8i1(i32 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i32 [[TMP1]]
//
uint32_t test_svqdecp_n_u32_b16(uint32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u32,_b16,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u32_b32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv4i1(i32 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CHECK-NEXT:    ret i32 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_u32_b32ju10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv4i1(i32 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i32 [[TMP1]]
//
uint32_t test_svqdecp_n_u32_b32(uint32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u32,_b32,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u32_b64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv2i1(i32 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CHECK-NEXT:    ret i32 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_u32_b64ju10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv2i1(i32 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i32 [[TMP1]]
//
uint32_t test_svqdecp_n_u32_b64(uint32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u32,_b64,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u64_b8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv16i1(i64 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    ret i64 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z21test_svqdecp_n_u64_b8mu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv16i1(i64 [[OP:%.*]], <vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    ret i64 [[TMP0]]
//
uint64_t test_svqdecp_n_u64_b8(uint64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u64,_b8,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u64_b16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv8i1(i64 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret i64 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_u64_b16mu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv8i1(i64 [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i64 [[TMP1]]
//
uint64_t test_svqdecp_n_u64_b16(uint64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u64,_b16,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u64_b32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv4i1(i64 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CHECK-NEXT:    ret i64 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_u64_b32mu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv4i1(i64 [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i64 [[TMP1]]
//
uint64_t test_svqdecp_n_u64_b32(uint64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u64,_b32,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_n_u64_b64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv2i1(i64 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CHECK-NEXT:    ret i64 [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svqdecp_n_u64_b64mu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv2i1(i64 [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret i64 [[TMP1]]
//
uint64_t test_svqdecp_n_u64_b64(uint64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_n_u64,_b64,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sqdecp.nxv8i16(<vscale x 8 x i16> [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svqdecp_s16u11__SVInt16_tu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sqdecp.nxv8i16(<vscale x 8 x i16> [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svint16_t test_svqdecp_s16(svint16_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_s16,,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sqdecp.nxv4i32(<vscale x 4 x i32> [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svqdecp_s32u11__SVInt32_tu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sqdecp.nxv4i32(<vscale x 4 x i32> [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svint32_t test_svqdecp_s32(svint32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_s32,,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.sqdecp.nxv2i64(<vscale x 2 x i64> [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svqdecp_s64u11__SVInt64_tu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.sqdecp.nxv2i64(<vscale x 2 x i64> [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svint64_t test_svqdecp_s64(svint64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_s64,,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.uqdecp.nxv8i16(<vscale x 8 x i16> [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svqdecp_u16u12__SVUint16_tu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.uqdecp.nxv8i16(<vscale x 8 x i16> [[OP:%.*]], <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svqdecp_u16(svuint16_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_u16,,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.uqdecp.nxv4i32(<vscale x 4 x i32> [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svqdecp_u32u12__SVUint32_tu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.uqdecp.nxv4i32(<vscale x 4 x i32> [[OP:%.*]], <vscale x 4 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svqdecp_u32(svuint32_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_u32,,)(op, pg);
}

// CHECK-LABEL: @test_svqdecp_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.uqdecp.nxv2i64(<vscale x 2 x i64> [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svqdecp_u64u12__SVUint64_tu10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.uqdecp.nxv2i64(<vscale x 2 x i64> [[OP:%.*]], <vscale x 2 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svqdecp_u64(svuint64_t op, svbool_t pg)
{
  return SVE_ACLE_FUNC(svqdecp,_u64,,)(op, pg);
}
