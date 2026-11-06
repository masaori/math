# 対象ラベル: real_abs_triangle_inequality
# |a + b| ≤ |a| + |b| の前置き（a ≤ |a|、b ≤ |b|、-a ≤ -(-|a|) = |a|、-b ≤ -(-|b|) = |b|）と、
# a + b ≥ 0 の 3 行、a + b < 0 の 4 行を、点の組の全てで確かめる。
# 帰属: QQ と AA の点。浮動小数点は使わない。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

n = 0
for a in PTS:
    for b in PTS:
        assert a <= rabs(a) and b <= rabs(b)
        assert -a <= -(-rabs(a)) and -(-rabs(a)) == rabs(a)
        assert -b <= -(-rabs(b)) and -(-rabs(b)) == rabs(b)
        if a + b >= 0:
            assert rabs(a + b) == a + b and a + b <= rabs(a) + b and rabs(a) + b <= rabs(a) + rabs(b)
        else:
            assert rabs(a + b) == -(a + b) and -(a + b) == (-a) + (-b)
            assert (-a) + (-b) <= rabs(a) + (-b) and rabs(a) + (-b) <= rabs(a) + rabs(b)
        assert rabs(a + b) <= rabs(a) + rabs(b)                       # 主張
        n += 1
print(f"{n} 組で主張と証明の各行を確かめた")
print("RESULT: PASS")
