// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.3-library -x hlsl -o - -fsyntax-only %s -verify

// Test that incomplete (unbounded) resource arrays cannot be passed as function
// parameters, but bounded resource arrays and single resources are allowed.

// Case 1: Unbounded resource array as function parameter - NOT ALLOWED
void testUnboundedArray(RWByteAddressBuffer bf[]) // expected-error {{incomplete resource array in a function parameter}}
{
    bf[0].Store(0u, 10u);
}

// Case 2: Bounded resource array as function parameter - ALLOWED
void testBoundedArray(RWByteAddressBuffer bf[1])
{
    bf[0].Store(0u, 10u);
}

// Case 3: Single resource as function parameter - ALLOWED
void testSingleResource(RWByteAddressBuffer buf)
{
    buf.Store(0u, 10u);
}

// Case 4: Struct containing incomplete resource array as function parameter - NOT ALLOWED
struct StructWithIncompleteResourceArray
{
    RWByteAddressBuffer bf[];
};

void testStructWithIncompleteArray(StructWithIncompleteResourceArray s) // expected-error {{incomplete resource array in a function parameter}}
{
    s.bf[0].Store(0u, 10u);
}

// Case 5: Struct containing bounded resource array as function parameter - ALLOWED
struct StructWithBoundedResourceArray
{
    RWByteAddressBuffer bf[1];
};

void testStructWithBoundedArray(StructWithBoundedResourceArray s)
{
    s.bf[0].Store(0u, 10u);
}

// Case 6: Nested struct containing incomplete resource array - NOT ALLOWED
struct InnerStructIncomplete
{
    RWByteAddressBuffer resources[];
};

struct OuterStructIncomplete
{
    InnerStructIncomplete inner;
    int data;
};

void testNestedStructIncomplete(OuterStructIncomplete s) // expected-error {{incomplete resource array in a function parameter}}
{
    s.inner.resources[0].Store(0u, 10u);
}

// Case 7: Nested struct containing bounded resource array - ALLOWED
struct InnerStructBounded
{
    RWByteAddressBuffer resources[2];
};

struct OuterStructBounded
{
    InnerStructBounded inner;
    int data;
};

void testNestedStructBounded(OuterStructBounded s)
{
    s.inner.resources[0].Store(0u, 10u);
}

// Global unbounded resource array (this is allowed at global scope)
RWByteAddressBuffer DefaultMemory[] : register(u3, space3);

// Positive test: Using global resource array directly (not as parameter)
void useGlobalResourceArray()
{
    DefaultMemory[0].Store(0u, 10u);
}
