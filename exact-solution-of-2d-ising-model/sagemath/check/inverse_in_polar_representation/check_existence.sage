# 対象ラベル: inverse_in_polar_representation
# 存在の二つの鎖
#   [(r,θ)]·[(1/r,-θ)] = [(r·(1/r), θ+(-θ))] = [(1, θ+(-θ))] = [(1,0)] = e
#   [(1/r,-θ)]·[(r,θ)] = [((1/r)·r, (-θ)+θ)] = [(1, (-θ)+θ)] = [(1,0)] = e
# (一般の点) 有理関数体で r·(1/r) = 1、多項式環で θ+(-θ) = 0。
# (具体の点) r ≠ 0 の各元で r > 0 と 1/r ∈ R_{>0} を確かめ、各行の代表元を成分から別々に組み立てて隣どうしを比べる。
#   積の定義の行（最初の行）は、本文の行が定義どおりに写されているかの確認に留まる。
load("../../_shared/polar_representation.sage")

R_ = Fr(r)
assert R_ * (1 / R_) == 1 and (1 / R_) * R_ == 1
assert th + (-th) == 0 and (-th) + th == 0

for p in NONZERO:
    a, t = p
    assert a >= 0 and a != 0 and a > 0
    c = (1 / a, -t)
    assert c[0] > 0 and is_pair(c)
    for (x, y, rows) in [
        (p, c, [(a * (1 / a), t + (-t)), (AA(1), t + (-t)), (AA(1), Ang(0))]),
        (c, p, [((1 / a) * a, (-t) + t), (AA(1), (-t) + t), (AA(1), Ang(0))]),
    ]:
        assert mul_rep(x, y) == rows[0]                                  # 積の定義
        assert rows[0][0] == rows[1][0] and rows[0][1] == rows[1][1]     # r·(1/r) = 1
        assert rows[1][0] == rows[2][0] and rows[1][1] == rows[2][1]     # 加法の逆元
        assert rows[2] == E                                              # e の定め方
# 対照: 角度の符号を反転しないと e にならない
p = NONZERO[3]
assert p[1] != 0 and not polar_equiv(mul_rep(p, (1 / p[0], p[1])), E)
print(f"existence chains in Frac(QQ[...]) and row by row on {len(NONZERO)} elements with r != 0")
print("RESULT: PASS")
