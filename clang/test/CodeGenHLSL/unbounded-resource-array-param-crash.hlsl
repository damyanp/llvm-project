// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.3-compute -finclude-default-header -emit-llvm -disable-llvm-passes -o - %s -verify

// Verify the compiler emits a diagnostic instead of crashing when an unbounded
// resource array is used as a function parameter (llvm/llvm-project#180808).

void Tests1(RWByteAddressBuffer bf[]) { // expected-error {{incomplete resource array in a function parameter}}
    bf[0].Store(0u, 10u);
}

RWByteAddressBuffer DefaultMemory[] : register(u3, space3);

[numthreads(1,1,1)]
void main() {
    Tests1(DefaultMemory);
}
