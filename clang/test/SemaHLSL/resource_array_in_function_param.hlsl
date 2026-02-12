// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.3-library -x hlsl -o - -fsyntax-only %s -verify

// Test that resource arrays cannot be passed as function parameters

// Case 1: Unbounded resource array as function parameter
void testUnboundedArray(RWByteAddressBuffer bf[]) // expected-error {{resource array in a function parameter is not allowed}}
{
    bf[0].Store(0u, 10u);
}

// Case 2: Bounded resource array as function parameter  
void testBoundedArray(RWByteAddressBuffer bf[1]) // expected-error {{resource array in a function parameter is not allowed}}
{
    bf[0].Store(0u, 10u);
}

// Case 3: Struct containing resource array as function parameter
struct StructWithResourceArray
{
    RWByteAddressBuffer bf[1];
};

void testStructParam(StructWithResourceArray s) // expected-error {{resource array in a function parameter is not allowed}}
{
    s.bf[0].Store(0u, 10u);
}

// Case 4: Nested struct containing resource array
struct InnerStruct
{
    RWByteAddressBuffer resources[2];
};

struct OuterStruct
{
    InnerStruct inner;
    int data;
};

void testNestedStructParam(OuterStruct s) // expected-error {{resource array in a function parameter is not allowed}}
{
    s.inner.resources[0].Store(0u, 10u);
}

// Case 5: Multi-dimensional resource array
void testMultiDimArray(RWByteAddressBuffer bf[2][3]) // expected-error {{resource array in a function parameter is not allowed}}
{
    bf[0][0].Store(0u, 10u);
}

// Global resource array (this is allowed at global scope)
RWByteAddressBuffer DefaultMemory[] : register(u3, space3);

// Positive test: Using global resource array directly (not as parameter)
void useGlobalResourceArray()
{
    DefaultMemory[0].Store(0u, 10u);
}
