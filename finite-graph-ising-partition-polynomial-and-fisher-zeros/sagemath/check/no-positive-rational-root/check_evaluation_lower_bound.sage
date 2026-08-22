# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: Z_G(q) >= Omega_G(0) q^0
# 帰属: NN、QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/no-positive-rational-root/_prelude.sage")

for example in examples:
    _, _, _, multiplicities, polynomial = partition_data(*example)
    for q in positive_rationals:
        assert QQ(polynomial(q)) >= QQ(multiplicities[0]) * q**0

print("RESULT: PASS — every positive rational evaluation is bounded below by its constant term")
