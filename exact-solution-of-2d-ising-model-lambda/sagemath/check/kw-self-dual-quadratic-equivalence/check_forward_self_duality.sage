# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \xi\cdot(1+\xi) = \mathrm{KW}(\xi)\cdot(1+\xi)
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in self_dual_points:
    left = xi*(1+xi)
    right = kw(xi)*(1+xi)
    assert left == right, "forward_self_duality: equality failed"
    checked += 1
assert checked == 2
print("RESULT: PASS (forward_self_duality, %d algebraic points)" % checked)
