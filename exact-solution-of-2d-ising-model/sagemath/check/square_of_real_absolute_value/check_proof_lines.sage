# 対象ラベル: square_of_real_absolute_value
# |q|^2 = q^2 の 2 つの場合（q ≥ 0 の 1 行、q < 0 の 2 行）の鎖の各行を、点の全てで確かめる。
# 帰属: QQ と AA の点。浮動小数点は使わない。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

cnt = [0, 0]
for q in PTS:
    if q >= 0:
        assert rabs(q) ** 2 == q ** 2, (q, "q ≥ 0 の 1 行目")
        cnt[0] += 1
    else:
        assert rabs(q) ** 2 == (-q) ** 2, (q, "q < 0 の 1 行目")
        assert (-q) ** 2 == q ** 2, (q, "q < 0 の 2 行目")
        cnt[1] += 2
    assert rabs(q) ** 2 == q ** 2                                 # 主張
assert all(c > 0 for c in cnt)
print(f"{len(PTS)} 点で、q ≥ 0 の行 {cnt[0]} 段と q < 0 の行 {cnt[1]} 段と主張が成り立った")
print("RESULT: PASS")
