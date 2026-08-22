# 対象ラベル: theorem_fisher_zeros_nonzero
# 式ペア: Omega_G(0) > 0 および Omega_G(d) > 0

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zeros-nonzero/_prelude.sage")

for data in examples:
    degree = data["degree"]
    multiplicities = data["multiplicities"]
    assert multiplicities[0] > 0, data["name"]
    assert multiplicities[degree] > 0, data["name"]

print("RESULT: PASS — every exact example has positive constant and leading coefficients")
