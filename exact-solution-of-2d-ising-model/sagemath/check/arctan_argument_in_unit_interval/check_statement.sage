# 対象ラベル: arctan_argument_in_unit_interval
# 最後の二つの鎖と主張そのもの
#   x/s <= |x/s| <= 1,   -(x/s) <= |x/s| <= 1,   -1 <= -(-(x/s)) = x/s
# 絶対値の定義 |q| = max(q,-q) を具体の値で確かめ、具体の点で二つの鎖と主張を厳密に確かめる。
# 主張の前半「1+x^2 ∈ R_{>=0} であって平方根が定まる」は s_of の中で確かめる。
load("_prelude.sage")

QS = [QQ(0), QQ(1), QQ(-1), QQ(1)/2, QQ(-3)/4, QQ(2), QQ(-3)/2]
for q in QS:
    assert abs(q) == max(q, -q)
for px in SAMPLE_X:
    ps = s_of(px)
    q = px / ps
    assert abs(q) == max(q, -q)
    assert q <= abs(q) and abs(q) <= 1               # 一つ目の鎖
    assert -q <= abs(q) and abs(q) <= 1              # 二つ目の鎖
    assert -1 <= -(-q) and -(-q) == q                # 両辺に -1 を掛ける・逆元の逆元
    assert -1 <= q <= 1                              # 主張
print(f"|q| = max(q,-q) for {len(QS)} rationals; both chains and -1 <= x/sqrt(1+x^2) <= 1 for {len(SAMPLE_X)} points")
print("RESULT: PASS")
