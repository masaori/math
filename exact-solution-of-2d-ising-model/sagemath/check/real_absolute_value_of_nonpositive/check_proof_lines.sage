# 対象ラベル: real_absolute_value_of_nonpositive
# q ≤ 0 なら |q| = -q。q < 0 は定義そのもの、q = 0 は 4 行の鎖 |q| = q = 0 = -0 = -q。
# 帰属: QQ と AA の点。浮動小数点は使わない。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

n = 0
for q in PTS:
    if q > 0:
        continue
    if q < 0:
        assert rabs(q) == -q; n += 1
    else:
        assert rabs(q) == q and q == 0 and 0 == -QQ(0) and -QQ(0) == -q; n += 4
    assert rabs(q) == -q                                              # 主張
assert rabs(QQ(1)) != -QQ(1)                                          # 対照: q > 0 では成り立たない
print(f"q ≤ 0 の点で主張と証明の {n} 行を確かめた")
print("RESULT: PASS")
