# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: (1+1)\cdot\xi = 2\xi
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = (1+1)*xi
    right = 2*xi
    assert left == right, "double_definition: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (double_definition, %d algebraic points)" % checked)
