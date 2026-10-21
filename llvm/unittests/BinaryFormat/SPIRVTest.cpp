//===- SPIRVTest.cpp - Tests for shared SPIR-V enums
//-------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/BinaryFormat/SPIRV.h"
#include "gtest/gtest.h"

using namespace llvm;

TEST(SPIRVTest, Decorations) {
  EXPECT_EQ(SPIRV::Decoration::BuiltIn, 11);
  EXPECT_EQ(SPIRV::Decoration::NoPerspective, 13);
  EXPECT_EQ(SPIRV::Decoration::Flat, 14);
  EXPECT_EQ(SPIRV::Decoration::Centroid, 16);
  EXPECT_EQ(SPIRV::Decoration::Sample, 17);
  EXPECT_EQ(SPIRV::Decoration::Location, 30);
  EXPECT_EQ(SPIRV::Decoration::NoSignedWrap, 4469);
}

TEST(SPIRVTest, BuiltIns) {
  EXPECT_EQ(SPIRV::BuiltIn::Position, 0);
  EXPECT_EQ(SPIRV::BuiltIn::FragCoord, 15);
  EXPECT_EQ(SPIRV::BuiltIn::VertexIndex, 42);
  EXPECT_EQ(SPIRV::BuiltIn::InstanceIndex, 43);
  EXPECT_EQ(SPIRV::BuiltIn::ShadingRateKHR, 4444);
  EXPECT_EQ(SPIRV::BuiltIn::IncomingRayFlagsNV, 5351);
  EXPECT_EQ(SPIRV::BuiltIn::PackedVectorFormat4x8Bit, 0);
}

TEST(SPIRVTest, StorageClasses) {
  EXPECT_EQ(SPIRV::StorageClass::Input, 1);
  EXPECT_EQ(SPIRV::StorageClass::Output, 3);
  EXPECT_EQ(SPIRV::StorageClass::Workgroup, 4);
  EXPECT_EQ(SPIRV::StorageClass::CrossWorkgroup, 5);
  EXPECT_EQ(SPIRV::StorageClass::Function, 7);
  EXPECT_EQ(SPIRV::StorageClass::HostOnlyINTEL, 5937);
}
