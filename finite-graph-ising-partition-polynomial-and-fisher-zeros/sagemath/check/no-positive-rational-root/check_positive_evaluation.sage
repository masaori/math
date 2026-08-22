# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: Z_G(q) >= 2
# 帰属: QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/no-positive-rational-root/_prelude.sage")

for example in examples:
    _, _, _, _, polynomial = partition_data(*example)
    for q in positive_rationals:
        assert QQ(polynomial(q)) >= QQ(2)

print("RESULT: PASS — every tested positive rational evaluation is at least two")
