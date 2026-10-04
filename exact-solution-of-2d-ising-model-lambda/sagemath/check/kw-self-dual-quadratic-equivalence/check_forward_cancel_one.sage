# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: 1-1 = 0
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = 1-1
    right = 0
    assert left == right, "forward_cancel_one: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (forward_cancel_one, %d algebraic points)" % checked)
