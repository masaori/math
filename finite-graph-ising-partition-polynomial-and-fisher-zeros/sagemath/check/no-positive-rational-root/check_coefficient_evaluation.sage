# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: Z_G(q) = sum_m Omega_G(m) q^m
# 帰属: NN、QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/no-positive-rational-root/_prelude.sage")

for example in examples:
    _, _, _, multiplicities, polynomial = partition_data(*example)
    for q in positive_rationals:
        coefficient_sum = sum(
            (QQ(multiplicities[degree]) * q**degree for degree in range(len(multiplicities))),
            QQ.zero(),
        )
        assert QQ(polynomial(q)) == coefficient_sum

print("RESULT: PASS — every exact rational evaluation equals the multiplicity coefficient sum")
