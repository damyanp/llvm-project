// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.3-compute -x hlsl -o - -fsyntax-only %s -verify

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

// Global resource array (this is allowed)
RWByteAddressBuffer DefaultMemory[] : register(u3, space3);

[numthreads(1, 1, 1)]
void main()
{
    // These calls should fail due to invalid parameter types
    testUnboundedArray(DefaultMemory); // Parameter error already reported above
    
    RWByteAddressBuffer localArray[1];
    testBoundedArray(localArray); // Parameter error already reported above
    
    StructWithResourceArray s;
    testStructParam(s); // Parameter error already reported above
    
    OuterStruct outer;
    testNestedStructParam(outer); // Parameter error already reported above
}

// Positive test: Single resource (not array) as parameter is allowed
void testSingleResource(RWByteAddressBuffer buf) // This is OK - single resource, not an array
{
    buf.Store(0u, 10u);
}

// Positive test: Using global resource array directly (not as parameter)
void useGlobalResourceArray()
{
    DefaultMemory[0].Store(0u, 10u);
}

[numthreads(1, 1, 1)]
void main2()
{
    RWByteAddressBuffer singleBuf;
    testSingleResource(singleBuf); // OK
    useGlobalResourceArray(); // OK
}
