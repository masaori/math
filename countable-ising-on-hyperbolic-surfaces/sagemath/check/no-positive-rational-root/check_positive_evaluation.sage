# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: Z_G(q) > 0
# 帰属: QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-positive-rational-root/_prelude.sage")

for example in examples:
    _, _, _, _, polynomial = partition_data(*example)
    for q in positive_rationals:
        assert QQ(polynomial(q)) > QQ.zero()

print("RESULT: PASS — no tested positive rational is a root of an exact Ising partition polynomial")
