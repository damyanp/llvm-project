# Check that --requires only runs tests whose REQUIRES/UNSUPPORTED clauses are
# satisfied by the supplied feature set, dropping all other tests silently.

# RUN: %{lit} --requires=Half %{inputs}/requires-filter | FileCheck --check-prefix=HALF %s
#
# HALF: Testing: 2 of 6 tests
# HALF-DAG: PASS: requires-filter :: needs-half.txt
# HALF-DAG: PASS: requires-filter :: needs-half-or-foo.txt
# HALF-NOT: needs-half-and-bar.txt
# HALF-NOT: needs-foo.txt
# HALF-NOT: no-requires.txt
# HALF-NOT: half-but-unsupported.txt
# HALF-NOT: UNSUPPORTED
# HALF: Passed{{ *}}: 2

# RUN: %{lit} --requires=Half,Bar %{inputs}/requires-filter | FileCheck --check-prefix=HALFBAR %s
#
# HALFBAR: Testing: 3 of 6 tests
# HALFBAR-DAG: PASS: requires-filter :: needs-half.txt
# HALFBAR-DAG: PASS: requires-filter :: needs-half-or-foo.txt
# HALFBAR-DAG: PASS: requires-filter :: needs-half-and-bar.txt
# HALFBAR-NOT: needs-foo.txt
# HALFBAR-NOT: no-requires.txt
# HALFBAR-NOT: half-but-unsupported.txt
# HALFBAR-NOT: UNSUPPORTED
# HALFBAR: Passed{{ *}}: 3

# Verify LIT_REQUIRES env var works as well.
# RUN: env LIT_REQUIRES=Foo %{lit} %{inputs}/requires-filter | FileCheck --check-prefix=FOO %s
#
# FOO: Testing: 2 of 6 tests
# FOO-DAG: PASS: requires-filter :: needs-foo.txt
# FOO-DAG: PASS: requires-filter :: needs-half-or-foo.txt
# FOO: Passed{{ *}}: 2
