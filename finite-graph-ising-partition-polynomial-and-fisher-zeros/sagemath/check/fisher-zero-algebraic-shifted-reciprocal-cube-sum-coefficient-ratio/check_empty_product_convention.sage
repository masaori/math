# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: QQbar[x] と評価後の QQbar における空積は各乗法単位元
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    assert prod((), data["polynomial_ring"].one()) == data["polynomial_ring"].one(), data["name"]
    assert prod((), QQbar(1)) == QQbar(1), data["name"]
print("RESULT: PASS — empty products equal the multiplicative identities in QQbar[x] and QQbar")
