set(LLVM_LINK_COMPONENTS
  BinaryFormat
  TargetParser
  )

add_llvm_unittest(BinaryFormatTests
  DwarfTest.cpp
  ELFTest.cpp
  MachOTest.cpp
  MsgPackDocumentTest.cpp
  MsgPackReaderTest.cpp
  MsgPackWriterTest.cpp
  SFrameTest.cpp
  SPIRVTest.cpp
  TestFileMagic.cpp

  DEPENDS
  spirv_enums_gen
  )
