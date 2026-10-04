# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \bigl(\mathrm{KW}(\xi)-\xi\bigr)+\xi = 0+\xi
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in quadratic_points:
    left = (kw(xi)-xi)+xi
    right = 0+xi
    assert left == right, "conclusion_difference_substitution: equality failed"
    checked += 1
assert checked == 2
print("RESULT: PASS (conclusion_difference_substitution, %d algebraic points)" % checked)
