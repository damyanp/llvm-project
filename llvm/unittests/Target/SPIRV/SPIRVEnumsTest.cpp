//===- SPIRVEnumsTest.cpp - Tests for shared SPIR-V operands
//----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/SPIRVBaseInfo.h"
#include "llvm/BinaryFormat/SPIRV.h"
#include "gtest/gtest.h"

using namespace llvm;

TEST(SPIRVEnumsTest, SymbolicOperands) {
  EXPECT_EQ(
      getSymbolicOperandMnemonic(SPIRV::OperandCategory::DecorationOperand,
                                 SPIRV::Decoration::BuiltIn),
      "BuiltIn");
  EXPECT_EQ(getSymbolicOperandMnemonic(SPIRV::OperandCategory::BuiltInOperand,
                                       SPIRV::BuiltIn::FragCoord),
            "FragCoord");
  EXPECT_EQ(
      getSymbolicOperandMnemonic(SPIRV::OperandCategory::StorageClassOperand,
                                 SPIRV::StorageClass::Workgroup),
      "Workgroup");
}
