# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: Omega_G(0) >= 1
# 帰属: NN

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-positive-rational-root/_prelude.sage")

for example in examples:
    _, _, _, multiplicities, _ = partition_data(*example)
    assert multiplicities[0] >= NN.one()

print("RESULT: PASS — every example has at least one zero-broken-edge configuration")
