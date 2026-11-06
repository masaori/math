# 対象ラベル: negative_absolute_value_is_at_most_real_number
# -|q| ≤ q の証明の各行を、q ≥ 0（3 行）と q < 0（2 行）に分けて確かめる。
# 帰属: QQ と AA の点。浮動小数点は使わない。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

n = 0
for q in PTS:
    if q >= 0:
        assert -rabs(q) == -q and -q <= 0 and 0 <= q; n += 3          # -|q| = -q ≤ 0 ≤ q
    else:
        assert -rabs(q) == -(-q) and -(-q) == q; n += 2               # -|q| = -(-q) = q
    assert -rabs(q) <= q                                              # 主張
print(f"{len(PTS)} 点で主張と証明の {n} 行を確かめた")
print("RESULT: PASS")
