# 対象ラベル: real_number_is_at_most_its_absolute_value
# q ≤ |q| の証明の各行を、q ≥ 0（1 行）と q < 0（3 行）に分けて確かめる。
# 帰属: QQ と AA（実代数的数）の点。浮動小数点は使わない。|·| は def_real_absolute_value の場合分けで計算する。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

n = 0
for q in PTS:
    if q >= 0:
        assert q == rabs(q); n += 1                                   # q = |q|（定義、q ≥ 0）
    else:
        assert q < 0 and 0 < -q and -q == rabs(q); n += 3             # q < 0 < -q = |q|
    assert q <= rabs(q)                                               # 主張
    assert rabs(q) == abs(q)                                          # 比べる側: Sage の abs
print(f"{len(PTS)} 点で主張と証明の {n} 行を確かめた")
print("RESULT: PASS")
