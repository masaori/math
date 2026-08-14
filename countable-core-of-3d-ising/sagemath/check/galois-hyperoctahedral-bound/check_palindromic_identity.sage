# 対象ラベル: claim_galois_hyperoctahedral_bound
# X^{#E_L} Z_L(X^{-1}) = Z_L(X) の有限和の四段を検証する。
# 帰属: ZZ[X]、ZZ[X,X^{-1}] と有限集合の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

laurent_ring = LaurentPolynomialRing(ZZ, "Y")
Y = laurent_ring.gen()

for box_side in [1, 2]:
    polynomial, edge_count = partition_polynomial(box_side)
    coefficients = [polynomial[m] for m in range(edge_count + 1)]
    first_line = Y ** edge_count * sum(
        coefficients[m] * Y ** (-m) for m in range(edge_count + 1)
    )
    second_line = sum(
        coefficients[m] * Y ** (edge_count - m) for m in range(edge_count + 1)
    )
    assert first_line == second_line
    assert all(coefficients[m] == coefficients[edge_count - m]
               for m in range(edge_count + 1))
    third_line = sum(
        coefficients[edge_count - m] * Y ** (edge_count - m)
        for m in range(edge_count + 1)
    )
    fourth_line = laurent_ring(polynomial)
    assert second_line == third_line
    assert third_line == fourth_line

print("RESULT: PASS")
