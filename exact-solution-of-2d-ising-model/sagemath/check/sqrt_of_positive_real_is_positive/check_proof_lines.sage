# 対象ラベル: sqrt_of_positive_real_is_positive
# x ∈ ℝ_{>0} について √x > 0 の証明の各行を確かめる。
#   前置き: x > 0 なので x ≥ 0。y := √x は y ≥ 0 かつ y^2 = x（definition_of_sqrt_r_positive）
#   背理法の鎖（y = 0 と仮定）:
#     1 行目: x = y^2（definition_of_sqrt_r_positive の y^2 = x を右辺から左辺へ）
#     2 行目: y^2 = 0^2（仮定 y = 0）
#     3 行目: 0^2 = 0·0（square_of_real_number_is_product（r → 0））
#     4 行目: 0·0 = 0（ℝ で 0·x = 0 の x → 0）
#   結論: y ≠ 0 と y ≥ 0 から y > 0
# 帰属: x ∈ QQ_{>0} と、その非負の平方根 y ∈ AA。等号・順序は厳密。浮動小数点は使わない。


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


eq_count = 0
samples = [QQ(1), QQ(2), QQ(3), QQ(1) / 2, QQ(7) / 3, QQ(10**6), QQ(1) / 10**6]
for x in samples:
    assert x > 0 and x >= 0                                   # 前置き: x > 0 なので x ≥ 0
    # y ≥ 0 かつ y^2 = x を満たす y は AA の中にただ一つ（y^2 - x の非負の根）
    R = PolynomialRing(AA, 'Y')
    Y = R.gen()
    nonneg_roots = [r for r in (Y**2 - AA(x)).roots(AA, multiplicities=False) if r >= 0]
    assert len(nonneg_roots) == 1; eq_count += 1
    y = nonneg_roots[0]
    assert y >= 0 and rpow(y, 2) == AA(x); eq_count += 1      # definition_of_sqrt_r_positive の y ≥ 0 かつ y^2 = x
    assert y == AA(x).sqrt(); eq_count += 1                    # Sage の sqrt は比べる側にだけ使う
    # 背理法の鎖を y を 0 に置いて辿ると x ≠ 0 に反する: x = y^2 の右辺に 0 を入れた値 0^2 = 0·0 = 0
    zero = AA(0)
    assert rpow(zero, 2) == zero * zero; eq_count += 1         # 3 行目
    assert zero * zero == zero; eq_count += 1                  # 4 行目
    assert AA(x) != rpow(zero, 2)                              # 1・2 行目の右辺と x が一致しない（矛盾）
    # 結論: y ≠ 0 と y ≥ 0 から y > 0
    assert y != 0 and y > 0

# 否定コントロール:
broken = 0
# x = 0（x > 0 を外す）では非負の平方根が 0 になり、y > 0 が崩れる。
R = PolynomialRing(AA, 'Y'); Y = R.gen()
r0 = [r for r in (Y**2).roots(AA, multiplicities=False) if r >= 0]
if not (r0[0] > 0):
    broken += 1
# y ≥ 0 を外すと y = -√x も y^2 = x を満たし、y > 0 が崩れる。
for x in [QQ(2), QQ(1) / 2]:
    yneg = -AA(x).sqrt()
    if rpow(yneg, 2) == AA(x) and not (yneg > 0):
        broken += 1
# 4 行目の 0·x = 0 を x·x に取り違える（x → 1）と 0 にならない。
if QQ(1) * QQ(1) != 0:
    broken += 1
assert broken == 4
print(f"等号 {eq_count} 個を確かめた（x ∈ QQ_{{>0}} の 7 通り。y ≥ 0 ∧ y^2 = x の y がただ一つ、0^2 = 0·0、0·0 = 0、y > 0）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
