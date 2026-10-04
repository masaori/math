# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: 0+\xi = \xi
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = 0+xi
    right = xi
    assert left == right, "conclusion_zero: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (conclusion_zero, %d algebraic points)" % checked)
