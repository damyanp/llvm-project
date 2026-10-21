# Handoff: share SPIR-V enums between the SPIR-V backend and Clang

## Status

- Code branch: `share-spirv-enums` on `https://github.com/damyanp/llvm-project`.
- Commit: `36e98e325cc5` "[SPIRV][Clang] Share SPIR-V enum definitions with frontends".
- Base: upstream `main` at `284217fb0b98`.
- Delivery rules: push to the `damyanp` fork only. Do not open a PR. Do not push to `llvm/llvm-project`.
- The history report that started this work is `cghlslruntime-integer-constants-report.md` (in this handoff branch).

## Problem

`CGHLSLRuntime.cpp` used integers for SPIR-V Decoration, BuiltIn, and address-space values.
The SPIR-V enums came from TableGen inside the SPIR-V backend
(`llvm/lib/Target/SPIRV/MCTargetDesc/SPIRVBaseInfo.h`). Clang could not include them.
See upstream PR llvm/llvm-project#233504 review by `spall`.

## Design (implemented)

- `llvm/include/llvm/BinaryFormat/SPIRVEnumValues.td`: target-independent name/value records.
  23 StorageClass + 78 Decoration + 94 BuiltIn = 195 entries.
- `llvm/include/llvm/BinaryFormat/SPIRVEnums.td`: `GenericEnum` definitions.
- `llvm/include/llvm/BinaryFormat/SPIRV.h`: public header. It includes generated
  `llvm/BinaryFormat/SPIRVEnums.inc`. Target `spirv_enums_gen` is built even when the SPIR-V target is disabled.
- Same names as before (not `enum class`): `llvm::SPIRV::Decoration::BuiltIn`,
  `llvm::SPIRV::BuiltIn::FragCoord`, `llvm::SPIRV::StorageClass::Workgroup`.
- Backend: `SPIRVSymbolicOperands.td` reads values from the shared records. Capabilities,
  extensions, versions, and lookup tables stay private. `SPIRVBaseInfo.h` includes the public header.
- BuiltIn keeps `GenericEnum` inheritance in the backend, because `SPIRVBuiltins.td` GetBuiltins uses
  `TypeOf_Value = "BuiltIn"`.
- Legacy quirk kept: BuiltIn contains `PackedVectorFormat4x8Bit = 0`. Do not fix it in this change.
- Clang CodeGen: enum names replace the integers. HLSL input/output address spaces use
  `getTargetAddressSpace(LangAS::hlsl_input/hlsl_output)`. `addSPIRVBuiltinDecoration` still takes
  `unsigned`, because attribute values are integers.
- Clang Sema: `SemaSPIRV.cpp` uses the shared StorageClass enum. It checks the integer before the cast.
  The allowlist is unchanged (Workgroup=4, CrossWorkgroup=5, Function=7).
- Build: the BinaryFormat CMake sets `LLVM_TABLEGEN_PROJECT LLVM` to use the full `llvm-tblgen`
  (`llvm-min-tblgen` has no searchable-table emitter). `LLVMConfig.cmake.in` adds an empty
  `spirv_enums_gen` target for standalone Clang builds. Module maps treat `SPIRV.h` as textual.

## Validation done (first PC)

- Build: Release with `/Od /Ob0`, assertions ON, `LLVM_ENABLE_PROJECTS=clang`, `LLVM_TARGETS_TO_BUILD=X86`,
  `LLVM_EXPERIMENTAL_TARGETS_TO_BUILD=DirectX;SPIRV`, `CLANG_ENABLE_CIR=OFF`, Ninja, MSVC.
- SPIR-V enabled: build passed. Lit (58 related tests) passed.
- SPIR-V disabled: build passed. Lit (50 related tests) passed.
- Unit tests passed: `BinaryFormatTests --gtest_filter=SPIRVTest.*` (3), `SPIRVTests --gtest_filter=SPIRVEnumsTest.*` (1).
- All 195 generated enum values and all backend lookup tables match the old output. Eight other backend
  TableGen outputs match (only anonymous record numbers in comments differ).
- Installed headers compile in a standalone check. Incremental rebuild after a `.td` change rebuilds the expected targets.
- Not done: a full Clang modules build. It failed on Windows because of MSVC standard-library module errors
  that are not related to this change.

## Possible next steps

- Rebase on new upstream `main` when needed. Push with `--force-with-lease` only.
- Test on Linux, if available (modules build, `LLVM_ENABLE_MODULES=ON`).
- Update the history report, if requested.
- Prepare for upstream review only when the user asks. Do not open a PR without an explicit request.
