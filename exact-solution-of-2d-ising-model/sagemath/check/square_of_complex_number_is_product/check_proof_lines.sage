# 対象ラベル: square_of_complex_number_is_product
# z^2 = z^1 z = (z^0 z) z = (1_C z) z = z z の 4 行の鎖を、点の全てで確かめる。
# 冪は def_power_of_complex_number のとおり z^0 := 1_C、z^{m+1} := z^m z で組む（Sage の ** は比べる側にだけ使う）。
# 帰属: QQbar（ガウス有理数と代数的数）の点。浮動小数点は使わない。


def cpow(z, m):
    """def_power_of_complex_number: z^0 := 1_C、z^{m+1} := z^m z。"""
    p = QQbar(1)
    for _ in range(m):
        p = p * z
    return p


I_ = QQbar(I)
PTS = [QQbar(a) + QQbar(b) * I_ for (a, b) in [(0, 0), (1, 0), (-2, 0), (0, 1), (0, -1), (1, 1), (QQ(-1)/3, QQ(5)/2), (QQ(7)/4, -3)]] \
    + [QQbar(2).sqrt() + I_ * QQbar(3).sqrt(), QQbar(-1) ** (QQ(1)/3), QQbar(5).sqrt() * I_]

eq_count = 0
for z in PTS:
    one = QQbar(1)
    lines = [cpow(z, 2), cpow(z, 1) * z, (cpow(z, 0) * z) * z, (one * z) * z, z * z]
    for u, w in zip(lines, lines[1:]):
        assert u == w, (z, u, w); eq_count += 1
    assert z ** 2 == z * z                                       # 比べる側: Sage の冪

# 否定コントロール: 冪の定義の z^0 を 1_C 以外（0）に取り違えると、z ≠ 0 で 3 行目が崩れる。
broken = 0
for z in PTS:
    if z != 0 and (0 * z) * z != (z * z):
        broken += 1
assert broken == len([z for z in PTS if z != 0])
print(f"{len(PTS)} 点で、鎖の等号 {eq_count} 個を確かめた")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
