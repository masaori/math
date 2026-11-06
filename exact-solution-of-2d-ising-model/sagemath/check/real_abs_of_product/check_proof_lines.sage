# 対象ラベル: real_abs_of_product
# |ab| = |a||b| の 4 つの場合（a, b の符号）の鎖の各行を、点の組の全てで確かめる。
# 帰属: QQ と AA の点。浮動小数点は使わない。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

cnt = [0, 0, 0, 0]
for a in PTS:
    for b in PTS:
        if a >= 0 and b >= 0:
            assert a*b >= 0
            assert rabs(a*b) == a*b and a*b == rabs(a)*b and rabs(a)*b == rabs(a)*rabs(b); cnt[0] += 1
        elif a >= 0 and b < 0:
            assert a*(-b) >= 0 and a*b == -(a*(-b)) and a*b <= 0
            assert rabs(a*b) == -(a*b) and -(a*b) == a*(-b) and a*(-b) == rabs(a)*(-b) and rabs(a)*(-b) == rabs(a)*rabs(b); cnt[1] += 1
        elif a < 0 and b >= 0:
            assert (-a)*b >= 0 and a*b == -((-a)*b) and a*b <= 0
            assert rabs(a*b) == -(a*b) and -(a*b) == (-a)*b and (-a)*b == rabs(a)*b and rabs(a)*b == rabs(a)*rabs(b); cnt[2] += 1
        else:
            assert a*b == (-a)*(-b) and a*b >= 0
            assert rabs(a*b) == a*b and a*b == (-a)*(-b) and (-a)*(-b) == rabs(a)*(-b) and rabs(a)*(-b) == rabs(a)*rabs(b); cnt[3] += 1
        assert rabs(a*b) == rabs(a)*rabs(b)                           # 主張
assert all(c > 0 for c in cnt)
print(f"4 つの場合をそれぞれ {cnt} 組で確かめた")
print("RESULT: PASS")
