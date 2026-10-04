# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \mathrm{KW}(\xi) = \bigl(\mathrm{KW}(\xi)-\xi\bigr)+\xi
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = kw(xi)
    right = (kw(xi)-xi)+xi
    assert left == right, "conclusion_insert_difference: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (conclusion_insert_difference, %d algebraic points)" % checked)
