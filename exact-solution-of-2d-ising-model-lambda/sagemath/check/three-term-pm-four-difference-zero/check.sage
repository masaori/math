"""
三つの等差項 a+b, a+2b, a+3b が {4,-4} に収まるなら公差 b は零であることを、
証明の各行に対応させて ZZ 上で検査する。浮動小数点は使わない。
"""

TARGET = {ZZ(4), ZZ(-4)}

# 証明の行: 隣接二項の差の全列挙 {4-4, 4-(-4), (-4)-4, (-4)-(-4)} = {0, 8, -8}
difference_set = {x - y for x in TARGET for y in TARGET}
assert difference_set == {ZZ(0), ZZ(8), ZZ(-8)}, difference_set

# 証明の行: b = 8 の二場合がともに仮定へ反すること
assert ZZ(4) + ZZ(8) == ZZ(12) and ZZ(12) not in TARGET        # a+b=4 → a+2b=12
assert ZZ(-4) + ZZ(16) == ZZ(12) and ZZ(12) not in TARGET      # a+b=-4 → a+3b=12

# 証明の行: b = -8 の二場合がともに仮定へ反すること
assert ZZ(4) + ZZ(-16) == ZZ(-12) and ZZ(-12) not in TARGET    # a+b=4 → a+3b=-12
assert ZZ(-4) + ZZ(-8) == ZZ(-12) and ZZ(-12) not in TARGET    # a+b=-4 → a+2b=-12

# 主張の全数検査: 窓 |a| <= 40, |b| <= 12 のすべての整数対について、
# 三項がすべて {4,-4} に属するなら b = 0 であること。
# （|b| > 12 では |(a+2b)-(a+b)| = |b| > 8 なので隣接二項が TARGET に収まらず、窓の外は自明。）
pairs_checked = 0
witnesses = 0
for a in range(-40, 41):
    for b in range(-12, 13):
        a_z, b_z = ZZ(a), ZZ(b)
        pairs_checked += 1
        if all(a_z + c * b_z in TARGET for c in (ZZ(1), ZZ(2), ZZ(3))):
            assert b_z == ZZ(0), (a_z, b_z)
            witnesses += 1

# 仮定が空でないこと（b=0, a+b=4 と a+b=-4 の二系列が窓の中に実在する）
assert witnesses == 2, witnesses
assert all(ZZ(4) + c * ZZ(0) in TARGET for c in (1, 2, 3))
assert all(ZZ(-4) + c * ZZ(0) in TARGET for c in (1, 2, 3))

print("PASS: pairs_checked =", pairs_checked, "witnesses =", witnesses)
