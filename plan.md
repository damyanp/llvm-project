# Share SPIR-V enums with Clang

## Problem

Clang needs names for SPIR-V values. The current enum declarations are in
`llvm\lib\Target\SPIRV\MCTargetDesc\SPIRVBaseInfo.h`.
They use a generated file from the SPIR-V backend build.
Clang must not include this private header or require that backend.

## Agreed scope

- Publish the complete `Decoration`, `BuiltIn`, and `StorageClass` enums
  that LLVM currently defines.
- Use one set of value records for Clang and the backend.
- Replace the related integer constants in `CGHLSLRuntime.cpp`.
- Replace the local `StorageClass` enum in `SemaSPIRV.cpp`.
- Replace the input and output address-space constants in
  `CGHLSLRuntime.cpp` with the existing Clang target mapping.
- Support builds with the SPIR-V backend disabled.
- Do not change emitted IR, accepted inputs, or diagnostics.

Do not add other enum groups, an external package, or a grammar download.
Do not update the history report as part of this change.

## Delivery

Do not open any pull requests.
Before implementation, check the working tree and fetch `main` from
`upstream` (`llvm/llvm-project`).
Fast-forward the local `main` to that fetched commit.
If local changes or divergent commits prevent this, stop and ask the
user. Do not stash, reset, rebase, or discard work.
Create the local branch `share-spirv-enums` from the updated `main`.
Keep the work in this local repository. Do not create a worktree.

After the changes pass the checks, commit only the files for this task.
Include the required Copilot commit trailers.
Push the branch to `origin`, which is
`https://github.com/damyanp/llvm-project.git`.
Do not push to `upstream`, which is the LLVM repository.
Do not force-push. Confirm that the remote branch points to the local
commit before reporting completion.

The user explicitly requested an up-to-date `main`, the push to their
fork, and the new branch name. This permits the fetch, push, and remote
commit check needed for this task, not other network operations.

## Proposed design

### 1. Put value records in a public location

Add these files:

| File | Purpose |
|---|---|
| `llvm\include\llvm\BinaryFormat\SPIRVEnumValues.td` | Names and numeric values for the three enum groups |
| `llvm\include\llvm\BinaryFormat\SPIRVEnums.td` | `GenericEnum` definitions for the public header |
| `llvm\include\llvm\BinaryFormat\SPIRV.h` | Public C++ header |
| `llvm\include\llvm\BinaryFormat\CMakeLists.txt` | Header generation rule |

Generate `llvm\BinaryFormat\SPIRVEnums.inc` in the build include directory.
The public header includes this file under the three declaration macros.

Use the existing namespace layout:

```cpp
llvm::SPIRV::Decoration::BuiltIn
llvm::SPIRV::Decoration::Location
llvm::SPIRV::BuiltIn::FragCoord
llvm::SPIRV::StorageClass::Workgroup
```

Keep the current enum type names and values. Do not change these enums to
`enum class` in this change. That would require unrelated backend edits.

The value records must not depend on `Operand`, `i32`, or backend files.
Keep the backend print methods, version limits, capability requirements,
extension requirements, and lookup tables private.

### 2. Make the backend use those records

In `SPIRVSymbolicOperands.td`, include the shared value records.
Change the three operand multiclasses to read each value from its record,
instead of defining that value again.
Preserve existing record names where other TableGen files use them.

Keep the backend `Operand<i32>` definitions for instruction operands.
Remove `GenericEnum` inheritance for Decoration and StorageClass.
Keep it for BuiltIn: the backend GetBuiltins table needs the enum record
to format typed values. Do not include its private C++ declaration block.
The public wrapper supplies the C++ declarations.

In `SPIRVBaseInfo.h`, include `llvm/BinaryFormat/SPIRV.h`.
Remove the three local enum declaration blocks.
Keep all backend functions and all other enum groups in place.

This gives each value one definition and each C++ enum one declaration.
It does not move the whole backend header into the public API.

Source inspection during implementation found that the original
BuiltIn enum also contains `PackedVectorFormat4x8Bit = 0`.
Preserve that entry in the shared records. Correcting its classification
is outside this refactor. The full comparison covers 195 enum entries.

### 3. Generate the header without a backend dependency

Add the BinaryFormat subdirectory to
`llvm\include\llvm\CMakeLists.txt`.
Add a public generation target, provisionally named `spirv_enums_gen`.
Use the existing `-gen-searchable-tables` emitter on `SPIRVEnums.td`.

There is an important build constraint:

- The LLVM include tree normally selects `llvm-min-tblgen`.
- `SearchableTableEmitter.cpp` is part of full `llvm-tblgen`, not
  `llvm-min-tblgen`.
- In the new subdirectory, explicitly select the full LLVM TableGen
  project, rather than the inherited `LLVM_HEADERS` project.
- Do not move the searchable-table emitter into the minimal tool.
- Do not add this generated header as a dependency of TableGen, Support,
  or the intrinsic header generator. Full `llvm-tblgen` already depends
  on `intrinsics_gen`; a reverse dependency would create a build cycle.

Add explicit generation dependencies for `clangCodeGen`, `clangSema`,
`SPIRVCommonTableGen`, and the header tests.
Add the generation target to `llvm-headers`.
Check that installed LLVM headers include the generated file.
Update the module map for the macro-driven include if needed.
Add the empty generation target to `LLVMConfig.cmake.in`, as with the
other public generated headers. Standalone Clang builds need that target
when they use a pre-built LLVM package.

The header needs no SPIR-V library link dependency.

### 4. Update Clang

In `CGHLSLRuntime.cpp`, include the public header.
Replace the decoration and built-in constants with the shared names.
Remove comments that only repeat those names.

Keep integer-valued attribute inputs at their existing boundary.
For example, `Attr->getBuiltIn()` must retain its current behavior.
Do not add a cast to an enum just to hide an unsigned attribute value.
Use enum-typed parameters for fixed-value helpers where this does not
change those boundaries.

The static load and store helpers do not have an `ASTContext`.
Pass the mapped target address space from their callers.
Use the existing pattern:

```cpp
Ctx.getTargetAddressSpace(LangAS::hlsl_input)
Ctx.getTargetAddressSpace(LangAS::hlsl_output)
```

Do not substitute SPIR-V storage classes for LLVM address spaces.
They use different values. For example, `StorageClass::Input` is `1`,
but the current HLSL input address space is `7`.

In `SemaSPIRV.cpp`, remove the local enum and use the shared
`StorageClass` enum.
Keep the current allowlist: `Workgroup`, `CrossWorkgroup`, and `Function`.
The larger enum must not make other storage classes valid.
Check the integer before converting it to an enum.
Account for the other enum members in the switch without adding an
uninitialized address-space path.

## Todos

Before todo 1, fetch upstream `main`, fast-forward local `main`, and
create the agreed branch.

1. Extract the three value sets and add public header generation.
2. Connect the backend to the shared records and public declarations.
3. Update Clang CodeGen, Sema, and address-space handling.
4. Add focused tests and check the build and installation paths.
5. Commit the checked changes and push `share-spirv-enums` to the fork.

Todo 2 and todo 3 require todo 1.
Todo 4 requires todo 2 and todo 3.
Todo 5 requires todo 4.
SQL tracks execution status.

## Validation and acceptance

1. Compare all extracted names and values with the original TableGen
   output, not only the values used by Clang.
2. Add BinaryFormat header tests for representative values from all
   three groups. Include both the public header and `SPIRVBaseInfo.h`
   in a backend-enabled compile check to detect duplicate declarations.
3. Compare backend symbolic operand tables before and after the change.
   Names, numeric values, requirements, and lookup behavior must match.
4. Run the affected HLSL semantic tests. Include position, vertex ID,
   instance ID, location, flat decoration, and explicit built-in
   attributes. Keep the existing numeric IR checks.
5. Run the SPIR-V generic pointer cast tests. Confirm that the original
   three storage classes are accepted and other values are rejected.
6. Build the affected Clang libraries with SPIR-V disabled. Run the
   IR-only tests that do not require that backend.
7. Build with SPIR-V enabled. Run the affected backend code generation
   tests and the focused header tests.
8. Build and install `llvm-headers` from a clean build. Compile a small
   consumer against the installed header without backend include paths.
9. Check an incremental build after a shared value record changes.
   Both Clang and backend outputs must rebuild through declared dependencies.

Start with focused tests. Use broader suites only if those tests show
that a wider check is needed. Do not change expected IR or diagnostics
to make this refactor pass.

## Evidence from the local checkout

- `SPIRVBaseInfo.h:147-155` declares the private decoration and built-in enums.
- `SPIRVSymbolicOperands.td:870-909` combines storage-class values and backend data.
- `SPIRVSymbolicOperands.td:1346-1466` does the same for decorations and built-ins.
- `llvm\include\llvm\CMakeLists.txt:1-3` selects the minimal TableGen tool.
- `llvm\utils\TableGen\CMakeLists.txt:10-16,76` explains the minimal tool
  constraint and places the searchable-table emitter in the full tool.
- `llvm\CMakeLists.txt:1554-1555` lists the generated header dependencies.
- `CGHLSLRuntime.cpp:1015-1016` already uses the Clang address-space mapping.
- `SemaSPIRV.cpp:16-26,143-183` defines and checks the local storage-class enum.

This is a proposal based on local source inspection. No repository files
have been changed, and the proposed build rules have not been run.
