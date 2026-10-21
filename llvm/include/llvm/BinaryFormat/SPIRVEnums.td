//===- SPIRVEnums.td - Shared SPIR-V enum generation ----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

include "llvm/TableGen/SearchableTable.td"
include "llvm/BinaryFormat/SPIRVEnumValues.td"

foreach category = ["Decoration", "BuiltIn", "StorageClass"] in {
  def category : GenericEnum {
    let FilterClass = category;
    let NameField = "Name";
    let ValueField = "Value";
  }
}
