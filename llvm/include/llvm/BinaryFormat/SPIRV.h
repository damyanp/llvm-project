//===- SPIRV.h - SPIR-V enums ----------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// SPIR-V enum definitions shared by frontends and the SPIR-V backend.
// This header does not require the SPIR-V backend to be enabled.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_BINARYFORMAT_SPIRV_H
#define LLVM_BINARYFORMAT_SPIRV_H

namespace llvm {
namespace SPIRV {

namespace Decoration {
#define GET_Decoration_DECL
#include "llvm/BinaryFormat/SPIRVEnums.inc"
} // namespace Decoration

namespace BuiltIn {
#define GET_BuiltIn_DECL
#include "llvm/BinaryFormat/SPIRVEnums.inc"
} // namespace BuiltIn

namespace StorageClass {
#define GET_StorageClass_DECL
#include "llvm/BinaryFormat/SPIRVEnums.inc"
} // namespace StorageClass

} // namespace SPIRV
} // namespace llvm

#endif // LLVM_BINARYFORMAT_SPIRV_H
