# 対象ラベル: square_of_real_sum_is_at_most_twice_sum_of_squares
# 証明の準備 0 ≤ (a - b)^2 と 6 行の鎖
#   (a + b)^2 = (a + b)^2 + 0 ≤ (a + b)^2 + (a - b)^2 = (a + b)(a + b) + (a - b)(a - b)
#   = (aa + ab + ba + bb) + (aa - ab - ba + bb) = (a^2 + ab + ba + b^2) + (a^2 - ab - ba + b^2) = 2a^2 + 2b^2
# を、点の組の全てで厳密に確かめ、さらに等号の 5 行を記号の多項式として確かめる。
# 二乗は def_power_of_real_number の冪 a^0 := 1、a^{m+1} := a^m a で組む（鎖の 7 つの式は rpow で組む。準備の (a - b)^2 ≥ 0 と主張の行・等号の場合の確認は Sage の ** で書く）。
# 3〜6 行目は乗法の可換性を使わないので、非可換な多項式環 QQ<a, b> でも確かめる。
# 帰属: QQ と AA の点、QQ 係数の多項式。浮動小数点は使わない。
PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


def lines(a, b):
    sq = lambda r: rpow(r, 2)
    return [sq(a + b),
            sq(a + b) + 0,
            sq(a + b) + sq(a - b),
            (a + b)*(a + b) + (a - b)*(a - b),
            (a*a + a*b + b*a + b*b) + (a*a - a*b - b*a + b*b),
            (sq(a) + a*b + b*a + sq(b)) + (sq(a) - a*b - b*a + sq(b)),
            2*sq(a) + 2*sq(b)]

R.<A, B> = QQ[]
l = lines(A, B)
assert l[0] == l[1] and all(l[k] == l[k + 1] for k in range(2, 6)), "等号の 5 行（可換な多項式として）"
F.<X, Y> = FreeAlgebra(QQ, 2)
l = lines(X, Y)
assert all(l[k] == l[k + 1] for k in range(2, 6)), "3〜6 行目（非可換な多項式として）"

n = 0
for a in PTS:
    for b in PTS:
        l = lines(a, b)
        assert l[0] == l[1], (a, b, "1 行目")
        assert (a - b)**2 >= 0, (a, b, "準備")
        assert l[1] <= l[2], (a, b, "2 行目")
        for k in range(2, 6):
            assert l[k] == l[k + 1], (a, b, f"{k + 1} 行目")
        assert (a + b)**2 <= 2*a**2 + 2*b**2, (a, b, "主張")
        n += 1
# 等号は a = b のときだけ（評価の 2 が下げられないことの確認）
assert all(((a + b)**2 == 2*a**2 + 2*b**2) == (a == b) for a in PTS for b in PTS)
print(f"多項式としての等号 5 行（3〜6 行目は非可換でも）と、{n} 組の点で鎖の 6 段と主張が成り立った")
print("RESULT: PASS")
