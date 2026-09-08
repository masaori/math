# Exact finite model for the componentwise calculation in
# `odd_eigenspace_is_complex_subspace`.
K.<ii> = QuadraticField(-1)
E = matrix(K, [
    [0, 0, 0, 1],
    [0, 0, 1, 0],
    [0, 1, 0, 0],
    [1, 0, 0, 0],
])
zero = vector(K, [0, 0, 0, 0])
f = vector(K, [1 + ii, 2 - ii, -2 + ii, -1 - ii])
g = vector(K, [3 - 2*ii, -1 + ii, 1 - ii, -3 + 2*ii])
a = K(2 - 3*ii)
rows = range(E.nrows())

assert E * f == -f
assert E * g == -g

def pass_equal(left, right, label):
    if left != right:
        raise AssertionError(f"{label}: {left} != {right}")
    print(f"PASS: {label}")
    print("RESULT: PASS")
