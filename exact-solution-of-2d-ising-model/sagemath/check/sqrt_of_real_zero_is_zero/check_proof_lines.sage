# 対象ラベル: sqrt_of_real_zero_is_zero
# √0 = 0 の証明の各行を確かめる。
#   1 行目: 0^2 = 0·0（square_of_real_number_is_product（r → 0）。冪は def_power_of_real_number のとおり a^0 := 1、a^{m+1} := a^m a で組む）
#   2 行目: 0·0 = 0（ℝ で 0·x = 0 の x → 0）
#   結論: definition_of_sqrt_r_positive（x → 0）の y → 0 が y ≥ 0 ∧ y^2 = 0 を満たし、そのような y はただ一つ
# 帰属: 0 ∈ QQ と 0 ∈ AA。等号・順序は厳密。浮動小数点は使わない。


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


eq_count = 0
for zero in [QQ(0), AA(0)]:
    # 1 行目: 0^2 = 0·0
    assert rpow(zero, 2) == zero * zero; eq_count += 1
    # 2 行目: 0·0 = 0
    assert zero * zero == zero; eq_count += 1
    # y → 0 が y ≥ 0 ∧ y^2 = 0 を満たす
    assert zero >= 0 and rpow(zero, 2) == zero
    # 一意性: y ≥ 0 ∧ y^2 = 0 を満たす y は 0 だけ（y^2 の AA の根は 0 だけ）
    R = PolynomialRing(zero.parent(), 'y')
    y = R.gen()
    nonneg_roots = [r for r in (y**2 - zero).roots(AA, multiplicities=False) if r >= 0]
    assert nonneg_roots == [AA(0)]; eq_count += 1
    # 結論: √0 = 0（Sage の sqrt は比べる側にだけ使う）
    assert AA(zero).sqrt() == 0; eq_count += 1

# 否定コントロール: 0 を 0 以外の非負の数に取り違えると y^2 = 0 を満たさない。
broken = 0
for c in [QQ(1), QQ(2), QQ(1) / 2, AA(2).sqrt()]:
    if rpow(c, 2) != 0:
        broken += 1
# 2 行目の 0·x = 0 を x·x に取り違える（x → 1）と 0 にならない。
if QQ(1) * QQ(1) != 0:
    broken += 1
assert broken == 5
print(f"等号 {eq_count} 個を確かめた（0 ∈ QQ と 0 ∈ AA。0^2 = 0·0、0·0 = 0、y^2 = 0 の非負の根は 0 だけ、√0 = 0）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
