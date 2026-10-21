//===- SPIRVEnumValues.td - Shared SPIR-V values --------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Shared SPIR-V enum values. Backend operand requirements stay in
// SPIRVSymbolicOperands.td.
//
//===----------------------------------------------------------------------===//

class StorageClass<string name, bits<32> value> {
  string Name = name;
  bits<32> Value = value;
}

def SPIRVStorageClassUniformConstant : StorageClass<"UniformConstant", 0>;
def SPIRVStorageClassInput : StorageClass<"Input", 1>;
def SPIRVStorageClassUniform : StorageClass<"Uniform", 2>;
def SPIRVStorageClassOutput : StorageClass<"Output", 3>;
def SPIRVStorageClassWorkgroup : StorageClass<"Workgroup", 4>;
def SPIRVStorageClassCrossWorkgroup : StorageClass<"CrossWorkgroup", 5>;
def SPIRVStorageClassPrivate : StorageClass<"Private", 6>;
def SPIRVStorageClassFunction : StorageClass<"Function", 7>;
def SPIRVStorageClassGeneric : StorageClass<"Generic", 8>;
def SPIRVStorageClassPushConstant : StorageClass<"PushConstant", 9>;
def SPIRVStorageClassAtomicCounter : StorageClass<"AtomicCounter", 10>;
def SPIRVStorageClassImage : StorageClass<"Image", 11>;
def SPIRVStorageClassStorageBuffer : StorageClass<"StorageBuffer", 12>;
def SPIRVStorageClassCallableDataNV : StorageClass<"CallableDataNV", 5328>;
def SPIRVStorageClassIncomingCallableDataNV : StorageClass<"IncomingCallableDataNV", 5329>;
def SPIRVStorageClassRayPayloadNV : StorageClass<"RayPayloadNV", 5338>;
def SPIRVStorageClassHitAttributeNV : StorageClass<"HitAttributeNV", 5339>;
def SPIRVStorageClassIncomingRayPayloadNV : StorageClass<"IncomingRayPayloadNV", 5342>;
def SPIRVStorageClassShaderRecordBufferNV : StorageClass<"ShaderRecordBufferNV", 5343>;
def SPIRVStorageClassPhysicalStorageBufferEXT : StorageClass<"PhysicalStorageBufferEXT", 5349>;
def SPIRVStorageClassCodeSectionINTEL : StorageClass<"CodeSectionINTEL", 5605>;
def SPIRVStorageClassDeviceOnlyINTEL : StorageClass<"DeviceOnlyINTEL", 5936>;
def SPIRVStorageClassHostOnlyINTEL : StorageClass<"HostOnlyINTEL", 5937>;

class Decoration<string name, bits<32> value> {
  string Name = name;
  bits<32> Value = value;
}

def SPIRVDecorationRelaxedPrecision : Decoration<"RelaxedPrecision", 0>;
def SPIRVDecorationSpecId : Decoration<"SpecId", 1>;
def SPIRVDecorationBlock : Decoration<"Block", 2>;
def SPIRVDecorationBufferBlock : Decoration<"BufferBlock", 3>;
def SPIRVDecorationRowMajor : Decoration<"RowMajor", 4>;
def SPIRVDecorationColMajor : Decoration<"ColMajor", 5>;
def SPIRVDecorationArrayStride : Decoration<"ArrayStride", 6>;
def SPIRVDecorationMatrixStride : Decoration<"MatrixStride", 7>;
def SPIRVDecorationGLSLShared : Decoration<"GLSLShared", 8>;
def SPIRVDecorationGLSLPacked : Decoration<"GLSLPacked", 9>;
def SPIRVDecorationCPacked : Decoration<"CPacked", 10>;
def SPIRVDecorationBuiltIn : Decoration<"BuiltIn", 11>;
def SPIRVDecorationNoPerspective : Decoration<"NoPerspective", 13>;
def SPIRVDecorationFlat : Decoration<"Flat", 14>;
def SPIRVDecorationPatch : Decoration<"Patch", 15>;
def SPIRVDecorationCentroid : Decoration<"Centroid", 16>;
def SPIRVDecorationSample : Decoration<"Sample", 17>;
def SPIRVDecorationInvariant : Decoration<"Invariant", 18>;
def SPIRVDecorationRestrict : Decoration<"Restrict", 19>;
def SPIRVDecorationAliased : Decoration<"Aliased", 20>;
def SPIRVDecorationVolatile : Decoration<"Volatile", 21>;
def SPIRVDecorationConstant : Decoration<"Constant", 22>;
def SPIRVDecorationCoherent : Decoration<"Coherent", 23>;
def SPIRVDecorationNonWritable : Decoration<"NonWritable", 24>;
def SPIRVDecorationNonReadable : Decoration<"NonReadable", 25>;
def SPIRVDecorationUniform : Decoration<"Uniform", 26>;
def SPIRVDecorationUniformId : Decoration<"UniformId", 27>;
def SPIRVDecorationSaturatedConversion : Decoration<"SaturatedConversion", 28>;
def SPIRVDecorationStream : Decoration<"Stream", 29>;
def SPIRVDecorationLocation : Decoration<"Location", 30>;
def SPIRVDecorationComponent : Decoration<"Component", 31>;
def SPIRVDecorationIndex : Decoration<"Index", 32>;
def SPIRVDecorationBinding : Decoration<"Binding", 33>;
def SPIRVDecorationDescriptorSet : Decoration<"DescriptorSet", 34>;
def SPIRVDecorationOffset : Decoration<"Offset", 35>;
def SPIRVDecorationXfbBuffer : Decoration<"XfbBuffer", 36>;
def SPIRVDecorationXfbStride : Decoration<"XfbStride", 37>;
def SPIRVDecorationFuncParamAttr : Decoration<"FuncParamAttr", 38>;
def SPIRVDecorationFPRoundingMode : Decoration<"FPRoundingMode", 39>;
def SPIRVDecorationFPFastMathMode : Decoration<"FPFastMathMode", 40>;
def SPIRVDecorationLinkageAttributes : Decoration<"LinkageAttributes", 41>;
def SPIRVDecorationNoContraction : Decoration<"NoContraction", 42>;
def SPIRVDecorationInputAttachmentIndex : Decoration<"InputAttachmentIndex", 43>;
def SPIRVDecorationAlignment : Decoration<"Alignment", 44>;
def SPIRVDecorationMaxByteOffset : Decoration<"MaxByteOffset", 45>;
def SPIRVDecorationAlignmentId : Decoration<"AlignmentId", 46>;
def SPIRVDecorationMaxByteOffsetId : Decoration<"MaxByteOffsetId", 47>;
def SPIRVDecorationNoSignedWrap : Decoration<"NoSignedWrap", 4469>;
def SPIRVDecorationNoUnsignedWrap : Decoration<"NoUnsignedWrap", 4470>;
def SPIRVDecorationExplicitInterpAMD : Decoration<"ExplicitInterpAMD", 4999>;
def SPIRVDecorationOverrideCoverageNV : Decoration<"OverrideCoverageNV", 5248>;
def SPIRVDecorationPassthroughNV : Decoration<"PassthroughNV", 5250>;
def SPIRVDecorationViewportRelativeNV : Decoration<"ViewportRelativeNV", 5252>;
def SPIRVDecorationSecondaryViewportRelativeNV : Decoration<"SecondaryViewportRelativeNV", 5256>;
def SPIRVDecorationPerPrimitiveNV : Decoration<"PerPrimitiveNV", 5271>;
def SPIRVDecorationPerViewNV : Decoration<"PerViewNV", 5272>;
def SPIRVDecorationPerVertexNV : Decoration<"PerVertexNV", 5273>;
def SPIRVDecorationNonUniformEXT : Decoration<"NonUniformEXT", 5300>;
def SPIRVDecorationCountBuffer : Decoration<"CountBuffer", 5634>;
def SPIRVDecorationUserSemantic : Decoration<"UserSemantic", 5635>;
def SPIRVDecorationRestrictPointerEXT : Decoration<"RestrictPointerEXT", 5355>;
def SPIRVDecorationAliasedPointerEXT : Decoration<"AliasedPointerEXT", 5356>;
def SPIRVDecorationReferencedIndirectlyINTEL : Decoration<"ReferencedIndirectlyINTEL", 5602>;
def SPIRVDecorationClobberINTEL : Decoration<"ClobberINTEL", 5607>;
def SPIRVDecorationSideEffectsINTEL : Decoration<"SideEffectsINTEL", 5608>;
def SPIRVDecorationArgumentAttributeINTEL : Decoration<"ArgumentAttributeINTEL", 6409>;
def SPIRVDecorationCacheControlLoadINTEL : Decoration<"CacheControlLoadINTEL", 6442>;
def SPIRVDecorationCacheControlStoreINTEL : Decoration<"CacheControlStoreINTEL", 6443>;
def SPIRVDecorationHostAccessINTEL : Decoration<"HostAccessINTEL", 6188>;
def SPIRVDecorationInitModeINTEL : Decoration<"InitModeINTEL", 6190>;
def SPIRVDecorationImplementInRegisterMapINTEL : Decoration<"ImplementInRegisterMapINTEL", 6191>;
def SPIRVDecorationFunctionRoundingModeINTEL : Decoration<"FunctionRoundingModeINTEL", 5822>;
def SPIRVDecorationFunctionDenormModeINTEL : Decoration<"FunctionDenormModeINTEL", 5823>;
def SPIRVDecorationFunctionFloatingPointModeINTEL : Decoration<"FunctionFloatingPointModeINTEL", 6080>;
def SPIRVDecorationAliasScopeINTEL : Decoration<"AliasScopeINTEL", 5914>;
def SPIRVDecorationNoAliasINTEL : Decoration<"NoAliasINTEL", 5915>;
def SPIRVDecorationFPMaxErrorDecorationINTEL : Decoration<"FPMaxErrorDecorationINTEL", 6170>;
// Internal-only sentinel; never emitted as a decoration.
def SPIRVDecorationAuxDataInstructionMetadata : Decoration<"AuxDataInstructionMetadata", 0xFFFF>;

class BuiltIn<string name, bits<32> value> {
  string Name = name;
  bits<32> Value = value;
}

def Position : BuiltIn<"Position", 0>;
def PointSize : BuiltIn<"PointSize", 1>;
def ClipDistanceVariable : BuiltIn<"ClipDistanceVariable", 3>;
def CullDistanceVariable : BuiltIn<"CullDistanceVariable", 4>;
def VertexId : BuiltIn<"VertexId", 5>;
def InstanceId : BuiltIn<"InstanceId", 6>;
def PrimitiveId : BuiltIn<"PrimitiveId", 7>;
def InvocationId : BuiltIn<"InvocationId", 8>;
def Layer : BuiltIn<"Layer", 9>;
def ViewportIndex : BuiltIn<"ViewportIndex", 10>;
def TessLevelOuter : BuiltIn<"TessLevelOuter", 11>;
def TessLevelInner : BuiltIn<"TessLevelInner", 12>;
def TessCoord : BuiltIn<"TessCoord", 13>;
def PatchVertices : BuiltIn<"PatchVertices", 14>;
def FragCoord : BuiltIn<"FragCoord", 15>;
def PointCoord : BuiltIn<"PointCoord", 16>;
def FrontFacing : BuiltIn<"FrontFacing", 17>;
def SampleId : BuiltIn<"SampleId", 18>;
def SamplePosition : BuiltIn<"SamplePosition", 19>;
def SampleMask : BuiltIn<"SampleMask", 20>;
def FragDepth : BuiltIn<"FragDepth", 22>;
def HelperInvocation : BuiltIn<"HelperInvocation", 23>;
def NumWorkgroups : BuiltIn<"NumWorkgroups", 24>;
def WorkgroupSize : BuiltIn<"WorkgroupSize", 25>;
def WorkgroupId : BuiltIn<"WorkgroupId", 26>;
def LocalInvocationId : BuiltIn<"LocalInvocationId", 27>;
def GlobalInvocationId : BuiltIn<"GlobalInvocationId", 28>;
def LocalInvocationIndex : BuiltIn<"LocalInvocationIndex", 29>;
def WorkDim : BuiltIn<"WorkDim", 30>;
def GlobalSize : BuiltIn<"GlobalSize", 31>;
def EnqueuedWorkgroupSize : BuiltIn<"EnqueuedWorkgroupSize", 32>;
def GlobalOffset : BuiltIn<"GlobalOffset", 33>;
def GlobalLinearId : BuiltIn<"GlobalLinearId", 34>;
def SubgroupSize : BuiltIn<"SubgroupSize", 36>;
def SubgroupMaxSize : BuiltIn<"SubgroupMaxSize", 37>;
def NumSubgroups : BuiltIn<"NumSubgroups", 38>;
def NumEnqueuedSubgroups : BuiltIn<"NumEnqueuedSubgroups", 39>;
def SubgroupId : BuiltIn<"SubgroupId", 40>;
def SubgroupLocalInvocationId : BuiltIn<"SubgroupLocalInvocationId", 41>;
def VertexIndex : BuiltIn<"VertexIndex", 42>;
def InstanceIndex : BuiltIn<"InstanceIndex", 43>;
def SubgroupEqMask : BuiltIn<"SubgroupEqMask", 4416>;
def SubgroupGeMask : BuiltIn<"SubgroupGeMask", 4417>;
def SubgroupGtMask : BuiltIn<"SubgroupGtMask", 4418>;
def SubgroupLeMask : BuiltIn<"SubgroupLeMask", 4419>;
def SubgroupLtMask : BuiltIn<"SubgroupLtMask", 4420>;
def BaseVertex : BuiltIn<"BaseVertex", 4424>;
def BaseInstance : BuiltIn<"BaseInstance", 4425>;
def DrawIndex : BuiltIn<"DrawIndex", 4426>;
def PrimitiveShadingRateKHR : BuiltIn<"PrimitiveShadingRateKHR", 4432>;
def ShadingRateKHR : BuiltIn<"ShadingRateKHR", 4444>;
def DeviceIndex : BuiltIn<"DeviceIndex", 4438>;
def ViewIndex : BuiltIn<"ViewIndex", 4440>;
def BaryCoordNoPerspAMD : BuiltIn<"BaryCoordNoPerspAMD", 4492>;
def BaryCoordNoPerspCentroidAMD : BuiltIn<"BaryCoordNoPerspCentroidAMD", 4493>;
def BaryCoordNoPerspSampleAMD : BuiltIn<"BaryCoordNoPerspSampleAMD", 4494>;
def BaryCoordSmoothAMD : BuiltIn<"BaryCoordSmoothAMD", 4495>;
def BaryCoordSmoothCentroid : BuiltIn<"BaryCoordSmoothCentroid", 4496>;
def BaryCoordSmoothSample : BuiltIn<"BaryCoordSmoothSample", 4497>;
def BaryCoordPullModel : BuiltIn<"BaryCoordPullModel", 4498>;
def FragStencilRefEXT : BuiltIn<"FragStencilRefEXT", 5014>;
def ViewportMaskNV : BuiltIn<"ViewportMaskNV", 5253>;
def SecondaryPositionNV : BuiltIn<"SecondaryPositionNV", 5257>;
def SecondaryViewportMaskNV : BuiltIn<"SecondaryViewportMaskNV", 5258>;
def PositionPerViewNV : BuiltIn<"PositionPerViewNV", 5261>;
def ViewportMaskPerViewNV : BuiltIn<"ViewportMaskPerViewNV", 5262>;
def FullyCoveredEXT : BuiltIn<"FullyCoveredEXT", 5264>;
def TaskCountNV : BuiltIn<"TaskCountNV", 5274>;
def PrimitiveCountNV : BuiltIn<"PrimitiveCountNV", 5275>;
def PrimitiveIndicesNV : BuiltIn<"PrimitiveIndicesNV", 5276>;
def ClipDistancePerViewNV : BuiltIn<"ClipDistancePerViewNV", 5277>;
def CullDistancePerViewNV : BuiltIn<"CullDistancePerViewNV", 5278>;
def LayerPerViewNV : BuiltIn<"LayerPerViewNV", 5279>;
def MeshViewCountNV : BuiltIn<"MeshViewCountNV", 5280>;
def MeshViewIndices : BuiltIn<"MeshViewIndices", 5281>;
def BaryCoordNV : BuiltIn<"BaryCoordNV", 5286>;
def BaryCoordNoPerspNV : BuiltIn<"BaryCoordNoPerspNV", 5287>;
def FragSizeEXT : BuiltIn<"FragSizeEXT", 5292>;
def FragInvocationCountEXT : BuiltIn<"FragInvocationCountEXT", 5293>;
def LaunchIdNV : BuiltIn<"LaunchIdNV", 5319>;
def LaunchSizeNV : BuiltIn<"LaunchSizeNV", 5320>;
def WorldRayOriginNV : BuiltIn<"WorldRayOriginNV", 5321>;
def WorldRayDirectionNV : BuiltIn<"WorldRayDirectionNV", 5322>;
def ObjectRayOriginNV : BuiltIn<"ObjectRayOriginNV", 5323>;
def ObjectRayDirectionNV : BuiltIn<"ObjectRayDirectionNV", 5324>;
def RayTminNV : BuiltIn<"RayTminNV", 5325>;
def RayTmaxNV : BuiltIn<"RayTmaxNV", 5326>;
def InstanceCustomIndexNV : BuiltIn<"InstanceCustomIndexNV", 5327>;
def ObjectToWorldNV : BuiltIn<"ObjectToWorldNV", 5330>;
def WorldToObjectNV : BuiltIn<"WorldToObjectNV", 5331>;
def HitTNV : BuiltIn<"HitTNV", 5332>;
def HitKindNV : BuiltIn<"HitKindNV", 5333>;
def IncomingRayFlagsNV : BuiltIn<"IncomingRayFlagsNV", 5351>;

// Retain the entry present in the backend's existing BuiltIn enum.
def PackedVectorFormat4x8Bit : BuiltIn<"PackedVectorFormat4x8Bit", 0>;
