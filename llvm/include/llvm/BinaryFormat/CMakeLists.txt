# Searchable tables require full llvm-tblgen, not llvm-min-tblgen.
set(LLVM_TABLEGEN_PROJECT LLVM)
set(LLVM_TARGET_DEFINITIONS SPIRVEnums.td)
tablegen(LLVM SPIRVEnums.inc -gen-searchable-tables)
add_public_tablegen_target(spirv_enums_gen)
