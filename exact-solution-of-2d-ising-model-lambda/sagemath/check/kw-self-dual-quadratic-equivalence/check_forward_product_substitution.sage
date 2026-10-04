# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \bigl(\xi\cdot(1+\xi)-\xi\bigr)+2\xi-1 = \bigl((1-\xi)-\xi\bigr)+2\xi-1
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in self_dual_points:
    left = (xi*(1+xi)-xi)+2*xi-1
    right = ((1-xi)-xi)+2*xi-1
    assert left == right, "forward_product_substitution: equality failed"
    checked += 1
assert checked == 2
print("RESULT: PASS (forward_product_substitution, %d algebraic points)" % checked)
