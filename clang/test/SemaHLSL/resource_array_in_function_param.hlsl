// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.3-library -finclude-default-header -o - %s -verify

// Test that incomplete (unbounded) resource arrays cannot be passed as function
// parameters, but bounded resource arrays and single resources are allowed.

// Case 1: Unbounded resource array as function parameter - NOT ALLOWED
void testUnboundedArray(RWBuffer<float> bf[]) // expected-error {{incomplete resource array in a function parameter}}
{
}

// Case 2: Bounded resource array as function parameter - ALLOWED
void testBoundedArray(RWBuffer<float> bf[1])
{
}

// Case 3: Single resource as function parameter - ALLOWED
void testSingleResource(RWBuffer<float> buf)
{
}

// Global unbounded resource array (this is allowed at global scope)
RWBuffer<float> DefaultMemory[] : register(u3, space3);
