# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \mathrm{KW}(\xi)\cdot(1+\xi) = 1-\xi
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = kw(xi)*(1+xi)
    right = 1-xi
    assert left == right, "forward_product_identity: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (forward_product_identity, %d algebraic points)" % checked)
