# 対象ラベル: square_of_real_number_is_product
# r^2 = r^1 r = (r^0 r) r = (1 r) r = r r の 4 行の鎖を、点の全てで確かめる。
# 冪は def_power_of_real_number のとおり a^0 := 1、a^{m+1} := a^m a で組む（Sage の ** は比べる側にだけ使う）。
# 帰属: QQ と AA の点。浮動小数点は使わない。


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt(), 1 / AA(2).sqrt()]

eq_count = 0
for r in PTS:
    one = r.parent()(1)
    lines = [rpow(r, 2), rpow(r, 1) * r, (rpow(r, 0) * r) * r, (one * r) * r, r * r]
    for u, w in zip(lines, lines[1:]):
        assert u == w, (r, u, w); eq_count += 1
    assert r ** 2 == r * r                                       # 比べる側: Sage の冪

# 否定コントロール: 冪の定義の a^0 を 1 以外（0）に取り違えると、r ≠ 0 で 3 行目が崩れる。
broken = 0
for r in PTS:
    if r != 0 and (0 * r) * r != (r * r):
        broken += 1
assert broken == len([r for r in PTS if r != 0])
print(f"{len(PTS)} 点で、鎖の等号 {eq_count} 個を確かめた")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
