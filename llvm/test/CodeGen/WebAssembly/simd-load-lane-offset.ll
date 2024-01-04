; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mattr=+simd128 | FileCheck %s

; Test SIMD v128.load{8,16,32,64}_lane instructions.

; TODO: Use the offset field by supporting more patterns. Right now only the
; equivalents of LoadPatNoOffset/StorePatNoOffset are supported.

target triple = "wasm32-unknown-unknown"

;===----------------------------------------------------------------------------
; v128.load8_lane / v128.store8_lane
;===----------------------------------------------------------------------------

define <16 x i8> @load_lane_i8_no_offset(i8* %p, <16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_no_offset:
; CHECK:         .functype load_lane_i8_no_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i8, i8* %p
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

define <16 x i8> @load_lane_i8_with_folded_offset(i8* %p, <16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_with_folded_offset:
; CHECK:         .functype load_lane_i8_with_folded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i8* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i8*
  %x = load i8, i8* %s
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

define <16 x i8> @load_lane_i8_with_folded_gep_offset(i8* %p, <16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_with_folded_gep_offset:
; CHECK:         .functype load_lane_i8_with_folded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 6
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i8, i8* %p, i32 6
  %x = load i8, i8* %s
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

define <16 x i8> @load_lane_i8_with_unfolded_gep_negative_offset(i8* %p, <16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_with_unfolded_gep_negative_offset:
; CHECK:         .functype load_lane_i8_with_unfolded_gep_negative_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const -6
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i8, i8* %p, i32 -6
  %x = load i8, i8* %s
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

define <16 x i8> @load_lane_i8_with_unfolded_offset(i8* %p, <16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_with_unfolded_offset:
; CHECK:         .functype load_lane_i8_with_unfolded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i8* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i8*
  %x = load i8, i8* %s
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

define <16 x i8> @load_lane_i8_with_unfolded_gep_offset(i8* %p, <16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_with_unfolded_gep_offset:
; CHECK:         .functype load_lane_i8_with_unfolded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 6
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i8, i8* %p, i32 6
  %x = load i8, i8* %s
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

define <16 x i8> @load_lane_i8_from_numeric_address(<16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_from_numeric_address:
; CHECK:         .functype load_lane_i8_from_numeric_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i8*
  %x = load i8, i8* %s
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

@gv_i8 = global i8 0
define <16 x i8> @load_lane_i8_from_global_address(<16 x i8> %v) {
; CHECK-LABEL: load_lane_i8_from_global_address:
; CHECK:         .functype load_lane_i8_from_global_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i8
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i8, i8* @gv_i8
  %t = insertelement <16 x i8> %v, i8 %x, i32 0
  ret <16 x i8> %t
}

define void @store_lane_i8_no_offset(<16 x i8> %v, i8* %p) {
; CHECK-LABEL: store_lane_i8_no_offset:
; CHECK:         .functype store_lane_i8_no_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* %p
  ret void
}

define void @store_lane_i8_with_folded_offset(<16 x i8> %v, i8* %p) {
; CHECK-LABEL: store_lane_i8_with_folded_offset:
; CHECK:         .functype store_lane_i8_with_folded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i8* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i8*
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* %s
  ret void
}

define void @store_lane_i8_with_folded_gep_offset(<16 x i8> %v, i8* %p) {
; CHECK-LABEL: store_lane_i8_with_folded_gep_offset:
; CHECK:         .functype store_lane_i8_with_folded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 6
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i8, i8* %p, i32 6
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* %s
  ret void
}

define void @store_lane_i8_with_unfolded_gep_negative_offset(<16 x i8> %v, i8* %p) {
; CHECK-LABEL: store_lane_i8_with_unfolded_gep_negative_offset:
; CHECK:         .functype store_lane_i8_with_unfolded_gep_negative_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const -6
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i8, i8* %p, i32 -6
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* %s
  ret void
}

define void @store_lane_i8_with_unfolded_offset(<16 x i8> %v, i8* %p) {
; CHECK-LABEL: store_lane_i8_with_unfolded_offset:
; CHECK:         .functype store_lane_i8_with_unfolded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i8* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i8*
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* %s
  ret void
}

define void @store_lane_i8_with_unfolded_gep_offset(<16 x i8> %v, i8* %p) {
; CHECK-LABEL: store_lane_i8_with_unfolded_gep_offset:
; CHECK:         .functype store_lane_i8_with_unfolded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 6
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i8, i8* %p, i32 6
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* %s
  ret void
}

define void @store_lane_i8_to_numeric_address(<16 x i8> %v) {
; CHECK-LABEL: store_lane_i8_to_numeric_address:
; CHECK:         .functype store_lane_i8_to_numeric_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i8*
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* %s
  ret void
}

define void @store_lane_i8_from_global_address(<16 x i8> %v) {
; CHECK-LABEL: store_lane_i8_from_global_address:
; CHECK:         .functype store_lane_i8_from_global_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i8
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store8_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <16 x i8> %v, i32 0
  store i8 %x, i8* @gv_i8
  ret void
}

;===----------------------------------------------------------------------------
; v128.load16_lane / v128.store16_lane
;===----------------------------------------------------------------------------

define <8 x i16> @load_lane_i16_no_offset(i16* %p, <8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_no_offset:
; CHECK:         .functype load_lane_i16_no_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i16, i16* %p
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

define <8 x i16> @load_lane_i16_with_folded_offset(i16* %p, <8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_with_folded_offset:
; CHECK:         .functype load_lane_i16_with_folded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i16* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i16*
  %x = load i16, i16* %s
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

define <8 x i16> @load_lane_i16_with_folded_gep_offset(i16* %p, <8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_with_folded_gep_offset:
; CHECK:         .functype load_lane_i16_with_folded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 12
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i16, i16* %p, i32 6
  %x = load i16, i16* %s
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

define <8 x i16> @load_lane_i16_with_unfolded_gep_negative_offset(i16* %p, <8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_with_unfolded_gep_negative_offset:
; CHECK:         .functype load_lane_i16_with_unfolded_gep_negative_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const -12
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i16, i16* %p, i32 -6
  %x = load i16, i16* %s
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

define <8 x i16> @load_lane_i16_with_unfolded_offset(i16* %p, <8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_with_unfolded_offset:
; CHECK:         .functype load_lane_i16_with_unfolded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i16* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i16*
  %x = load i16, i16* %s
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

define <8 x i16> @load_lane_i16_with_unfolded_gep_offset(i16* %p, <8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_with_unfolded_gep_offset:
; CHECK:         .functype load_lane_i16_with_unfolded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 12
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i16, i16* %p, i32 6
  %x = load i16, i16* %s
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

define <8 x i16> @load_lane_i16_from_numeric_address(<8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_from_numeric_address:
; CHECK:         .functype load_lane_i16_from_numeric_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i16*
  %x = load i16, i16* %s
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

@gv_i16 = global i16 0
define <8 x i16> @load_lane_i16_from_global_address(<8 x i16> %v) {
; CHECK-LABEL: load_lane_i16_from_global_address:
; CHECK:         .functype load_lane_i16_from_global_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i16
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i16, i16* @gv_i16
  %t = insertelement <8 x i16> %v, i16 %x, i32 0
  ret <8 x i16> %t
}

define void @store_lane_i16_no_offset(<8 x i16> %v, i16* %p) {
; CHECK-LABEL: store_lane_i16_no_offset:
; CHECK:         .functype store_lane_i16_no_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* %p
  ret void
}

define void @store_lane_i16_with_folded_offset(<8 x i16> %v, i16* %p) {
; CHECK-LABEL: store_lane_i16_with_folded_offset:
; CHECK:         .functype store_lane_i16_with_folded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i16* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i16*
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* %s
  ret void
}

define void @store_lane_i16_with_folded_gep_offset(<8 x i16> %v, i16* %p) {
; CHECK-LABEL: store_lane_i16_with_folded_gep_offset:
; CHECK:         .functype store_lane_i16_with_folded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 12
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i16, i16* %p, i32 6
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* %s
  ret void
}

define void @store_lane_i16_with_unfolded_gep_negative_offset(<8 x i16> %v, i16* %p) {
; CHECK-LABEL: store_lane_i16_with_unfolded_gep_negative_offset:
; CHECK:         .functype store_lane_i16_with_unfolded_gep_negative_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const -12
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i16, i16* %p, i32 -6
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* %s
  ret void
}

define void @store_lane_i16_with_unfolded_offset(<8 x i16> %v, i16* %p) {
; CHECK-LABEL: store_lane_i16_with_unfolded_offset:
; CHECK:         .functype store_lane_i16_with_unfolded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i16* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i16*
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* %s
  ret void
}

define void @store_lane_i16_with_unfolded_gep_offset(<8 x i16> %v, i16* %p) {
; CHECK-LABEL: store_lane_i16_with_unfolded_gep_offset:
; CHECK:         .functype store_lane_i16_with_unfolded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 12
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i16, i16* %p, i32 6
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* %s
  ret void
}

define void @store_lane_i16_to_numeric_address(<8 x i16> %v) {
; CHECK-LABEL: store_lane_i16_to_numeric_address:
; CHECK:         .functype store_lane_i16_to_numeric_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i16*
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* %s
  ret void
}

define void @store_lane_i16_from_global_address(<8 x i16> %v) {
; CHECK-LABEL: store_lane_i16_from_global_address:
; CHECK:         .functype store_lane_i16_from_global_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i16
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store16_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <8 x i16> %v, i32 0
  store i16 %x, i16* @gv_i16
  ret void
}

;===----------------------------------------------------------------------------
; v128.load32_lane / v128.store32_lane
;===----------------------------------------------------------------------------

define <4 x i32> @load_lane_i32_no_offset(i32* %p, <4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_no_offset:
; CHECK:         .functype load_lane_i32_no_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i32, i32* %p
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

define <4 x i32> @load_lane_i32_with_folded_offset(i32* %p, <4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_with_folded_offset:
; CHECK:         .functype load_lane_i32_with_folded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i32* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i32*
  %x = load i32, i32* %s
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

define <4 x i32> @load_lane_i32_with_folded_gep_offset(i32* %p, <4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_with_folded_gep_offset:
; CHECK:         .functype load_lane_i32_with_folded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i32, i32* %p, i32 6
  %x = load i32, i32* %s
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

define <4 x i32> @load_lane_i32_with_unfolded_gep_negative_offset(i32* %p, <4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_with_unfolded_gep_negative_offset:
; CHECK:         .functype load_lane_i32_with_unfolded_gep_negative_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const -24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i32, i32* %p, i32 -6
  %x = load i32, i32* %s
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

define <4 x i32> @load_lane_i32_with_unfolded_offset(i32* %p, <4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_with_unfolded_offset:
; CHECK:         .functype load_lane_i32_with_unfolded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i32* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i32*
  %x = load i32, i32* %s
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

define <4 x i32> @load_lane_i32_with_unfolded_gep_offset(i32* %p, <4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_with_unfolded_gep_offset:
; CHECK:         .functype load_lane_i32_with_unfolded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i32, i32* %p, i32 6
  %x = load i32, i32* %s
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

define <4 x i32> @load_lane_i32_from_numeric_address(<4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_from_numeric_address:
; CHECK:         .functype load_lane_i32_from_numeric_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i32*
  %x = load i32, i32* %s
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

@gv_i32 = global i32 0
define <4 x i32> @load_lane_i32_from_global_address(<4 x i32> %v) {
; CHECK-LABEL: load_lane_i32_from_global_address:
; CHECK:         .functype load_lane_i32_from_global_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i32
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i32, i32* @gv_i32
  %t = insertelement <4 x i32> %v, i32 %x, i32 0
  ret <4 x i32> %t
}

define void @store_lane_i32_no_offset(<4 x i32> %v, i32* %p) {
; CHECK-LABEL: store_lane_i32_no_offset:
; CHECK:         .functype store_lane_i32_no_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* %p
  ret void
}

define void @store_lane_i32_with_folded_offset(<4 x i32> %v, i32* %p) {
; CHECK-LABEL: store_lane_i32_with_folded_offset:
; CHECK:         .functype store_lane_i32_with_folded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i32* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i32*
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* %s
  ret void
}

define void @store_lane_i32_with_folded_gep_offset(<4 x i32> %v, i32* %p) {
; CHECK-LABEL: store_lane_i32_with_folded_gep_offset:
; CHECK:         .functype store_lane_i32_with_folded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i32, i32* %p, i32 6
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* %s
  ret void
}

define void @store_lane_i32_with_unfolded_gep_negative_offset(<4 x i32> %v, i32* %p) {
; CHECK-LABEL: store_lane_i32_with_unfolded_gep_negative_offset:
; CHECK:         .functype store_lane_i32_with_unfolded_gep_negative_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const -24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i32, i32* %p, i32 -6
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* %s
  ret void
}

define void @store_lane_i32_with_unfolded_offset(<4 x i32> %v, i32* %p) {
; CHECK-LABEL: store_lane_i32_with_unfolded_offset:
; CHECK:         .functype store_lane_i32_with_unfolded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i32* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i32*
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* %s
  ret void
}

define void @store_lane_i32_with_unfolded_gep_offset(<4 x i32> %v, i32* %p) {
; CHECK-LABEL: store_lane_i32_with_unfolded_gep_offset:
; CHECK:         .functype store_lane_i32_with_unfolded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i32, i32* %p, i32 6
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* %s
  ret void
}

define void @store_lane_i32_to_numeric_address(<4 x i32> %v) {
; CHECK-LABEL: store_lane_i32_to_numeric_address:
; CHECK:         .functype store_lane_i32_to_numeric_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i32*
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* %s
  ret void
}

define void @store_lane_i32_from_global_address(<4 x i32> %v) {
; CHECK-LABEL: store_lane_i32_from_global_address:
; CHECK:         .functype store_lane_i32_from_global_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i32
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store32_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <4 x i32> %v, i32 0
  store i32 %x, i32* @gv_i32
  ret void
}

;===----------------------------------------------------------------------------
; v128.load64_lane / v128.store64_lane
;===----------------------------------------------------------------------------

define <2 x i64> @load_lane_i64_no_offset(i64* %p, <2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_no_offset:
; CHECK:         .functype load_lane_i64_no_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i64, i64* %p
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

define <2 x i64> @load_lane_i64_with_folded_offset(i64* %p, <2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_with_folded_offset:
; CHECK:         .functype load_lane_i64_with_folded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i64* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i64*
  %x = load i64, i64* %s
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

define <2 x i64> @load_lane_i64_with_folded_gep_offset(i64* %p, <2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_with_folded_gep_offset:
; CHECK:         .functype load_lane_i64_with_folded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i64, i64* %p, i32 6
  %x = load i64, i64* %s
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

define <2 x i64> @load_lane_i64_with_unfolded_gep_negative_offset(i64* %p, <2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_with_unfolded_gep_negative_offset:
; CHECK:         .functype load_lane_i64_with_unfolded_gep_negative_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const -48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i64, i64* %p, i32 -6
  %x = load i64, i64* %s
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

define <2 x i64> @load_lane_i64_with_unfolded_offset(i64* %p, <2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_with_unfolded_offset:
; CHECK:         .functype load_lane_i64_with_unfolded_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i64* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i64*
  %x = load i64, i64* %s
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

define <2 x i64> @load_lane_i64_with_unfolded_gep_offset(i64* %p, <2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_with_unfolded_gep_offset:
; CHECK:         .functype load_lane_i64_with_unfolded_gep_offset (i32, v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i64, i64* %p, i32 6
  %x = load i64, i64* %s
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

define <2 x i64> @load_lane_i64_from_numeric_address(<2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_from_numeric_address:
; CHECK:         .functype load_lane_i64_from_numeric_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i64*
  %x = load i64, i64* %s
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

@gv_i64 = global i64 0
define <2 x i64> @load_lane_i64_from_global_address(<2 x i64> %v) {
; CHECK-LABEL: load_lane_i64_from_global_address:
; CHECK:         .functype load_lane_i64_from_global_address (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i64
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = load i64, i64* @gv_i64
  %t = insertelement <2 x i64> %v, i64 %x, i32 0
  ret <2 x i64> %t
}

define void @store_lane_i64_no_offset(<2 x i64> %v, i64* %p) {
; CHECK-LABEL: store_lane_i64_no_offset:
; CHECK:         .functype store_lane_i64_no_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* %p
  ret void
}

define void @store_lane_i64_with_folded_offset(<2 x i64> %v, i64* %p) {
; CHECK-LABEL: store_lane_i64_with_folded_offset:
; CHECK:         .functype store_lane_i64_with_folded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i64* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i64*
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* %s
  ret void
}

define void @store_lane_i64_with_folded_gep_offset(<2 x i64> %v, i64* %p) {
; CHECK-LABEL: store_lane_i64_with_folded_gep_offset:
; CHECK:         .functype store_lane_i64_with_folded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i64, i64* %p, i32 6
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* %s
  ret void
}

define void @store_lane_i64_with_unfolded_gep_negative_offset(<2 x i64> %v, i64* %p) {
; CHECK-LABEL: store_lane_i64_with_unfolded_gep_negative_offset:
; CHECK:         .functype store_lane_i64_with_unfolded_gep_negative_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const -48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i64, i64* %p, i32 -6
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* %s
  ret void
}

define void @store_lane_i64_with_unfolded_offset(<2 x i64> %v, i64* %p) {
; CHECK-LABEL: store_lane_i64_with_unfolded_offset:
; CHECK:         .functype store_lane_i64_with_unfolded_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i64* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i64*
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* %s
  ret void
}

define void @store_lane_i64_with_unfolded_gep_offset(<2 x i64> %v, i64* %p) {
; CHECK-LABEL: store_lane_i64_with_unfolded_gep_offset:
; CHECK:         .functype store_lane_i64_with_unfolded_gep_offset (v128, i32) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i64, i64* %p, i32 6
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* %s
  ret void
}

define void @store_lane_i64_to_numeric_address(<2 x i64> %v) {
; CHECK-LABEL: store_lane_i64_to_numeric_address:
; CHECK:         .functype store_lane_i64_to_numeric_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 42
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i64*
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* %s
  ret void
}

define void @store_lane_i64_from_global_address(<2 x i64> %v) {
; CHECK-LABEL: store_lane_i64_from_global_address:
; CHECK:         .functype store_lane_i64_from_global_address (v128) -> ()
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const gv_i64
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.store64_lane 0, 0
; CHECK-NEXT:    # fallthrough-return
  %x = extractelement <2 x i64> %v, i32 0
  store i64 %x, i64* @gv_i64
  ret void
}
