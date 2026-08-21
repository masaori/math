# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: Omega_G(0) >= 2
# 帰属: NN

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-positive-rational-root/_prelude.sage")

for example in examples:
    _, _, _, multiplicities, _ = partition_data(*example)
    assert multiplicities[0] >= NN(2)

print("RESULT: PASS — every example has two distinct zero-broken-edge configurations")
