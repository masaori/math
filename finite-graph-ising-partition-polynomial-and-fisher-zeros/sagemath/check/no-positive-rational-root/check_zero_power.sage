# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: Omega_G(0) q^0 = Omega_G(0)
# 帰属: NN、QQ

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/no-positive-rational-root/_prelude.sage")

for example in examples:
    _, _, _, multiplicities, _ = partition_data(*example)
    for q in positive_rationals:
        assert QQ(multiplicities[0]) * q**0 == QQ(multiplicities[0])

print("RESULT: PASS — the degree-zero contribution equals the zero-broken-edge multiplicity")
