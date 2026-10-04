# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: (1+\xi)\cdot\bigl(\mathrm{KW}(\xi)-\xi\bigr) = (1+\xi)\cdot\mathrm{KW}(\xi)-(1+\xi)\cdot\xi
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = (1+xi)*(kw(xi)-xi)
    right = (1+xi)*kw(xi)-(1+xi)*xi
    assert left == right, "difference_distribution: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (difference_distribution, %d algebraic points)" % checked)
