# 対象ラベル: sqrt_of_real_one_is_one
# √1 = 1 の証明の各行を確かめる。
#   1 行目: 1^2 = 1（power_of_real_one_is_one（m → 2）。冪は def_power_of_real_number のとおり a^0 := 1、a^{m+1} := a^m a で組む）
#   結論: definition_of_sqrt_r_positive（x → 1）の y → 1 が y ≥ 0 ∧ y^2 = 1 を満たし、そのような y はただ一つ
# 帰属: 1 ∈ QQ と 1 ∈ AA。等号・順序は厳密。浮動小数点は使わない。


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


eq_count = 0
for one in [QQ(1), AA(1)]:
    # 1 行目: 1^2 = 1
    assert rpow(one, 2) == one; eq_count += 1
    # y → 1 が y ≥ 0 ∧ y^2 = 1 を満たす
    assert one >= 0 and rpow(one, 2) == one
    # 一意性: y ≥ 0 ∧ y^2 = 1 を満たす y は 1 だけ（y^2 - 1 = (y - 1)(y + 1) の AA の根のうち非負のもの）
    R = PolynomialRing(one.parent(), 'y')
    y = R.gen()
    nonneg_roots = [r for r in (y**2 - 1).roots(AA, multiplicities=False) if r >= 0]
    assert nonneg_roots == [AA(1)]; eq_count += 1
    # 結論: √1 = 1（Sage の sqrt は比べる側にだけ使う）
    assert AA(one).sqrt() == 1; eq_count += 1

# 否定コントロール: 1 を 1 以外の非負の数に取り違えると y^2 = 1 を満たさない。
broken = 0
for c in [QQ(0), QQ(2), QQ(1) / 2, AA(2).sqrt()]:
    if rpow(c, 2) != 1:
        broken += 1
# 非負の条件を落とすと y = -1 も y^2 = 1 を満たし、一意でなくなる。
if rpow(QQ(-1), 2) == 1:
    broken += 1
assert broken == 5
print(f"等号 {eq_count} 個を確かめた（1 ∈ QQ と 1 ∈ AA。1^2 = 1、y^2 = 1 の非負の根は 1 だけ、√1 = 1）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
