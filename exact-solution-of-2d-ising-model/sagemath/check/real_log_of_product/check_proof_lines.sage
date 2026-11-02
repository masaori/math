# 対象ラベル: real_log_of_product
# 準備の鎖 exp(log a + log b) = exp(log a)exp(log b) = ab と、主張の鎖 log(ab) = log(exp(log a + log b)) = log a + log b を確かめる。
# 帰属:
# - 1 行目（scalar_exp_product）は、exp の引数を QQ[u,v] の不定元に置き、本文の exp の部分和を形式冪級数として
#   全次数 14 以下で比べる（hyperbolic_by_definition.sage の exp_series）。
# - log の値は QQ に入らないので、具体の点 a, b ∈ QQ_{>0} で RealBallField(512) へ脱出する。log は Arb の log で、
#   exp は本文の部分和に尾の評価を足したボール（exp_ball_of_ball）で囲む。両辺は別々に計算する
#   （左辺は積 ab の log、右辺は log a と log b の和）。
load("../../_shared/log_integral_by_balls.sage")
R.<u, v> = PolynomialRing(QQ)
lhs = exp_series(R, u + v)
rhs = truncate_total_degree(exp_series(R, u) * exp_series(R, v), D_SERIES)
assert lhs == rhs                                                    # 準備の 1 行目
assert lhs != truncate_total_degree(exp_series(R, u) + exp_series(R, v), D_SERIES)   # 対照: 和にはならない
print("準備の 1 行目 exp(u+v) = exp(u)exp(v) が全次数 14 以下の形式冪級数で成り立つ")
POINTS = [(QQ(1), QQ(1)), (QQ(1)/3, QQ(7)/2), (QQ(10)^-6, QQ(10)^6 + 1), (QQ(5)/7, QQ(5)/7), (QQ(123), QQ(1)/1000)]
for a, b in POINTS:
    la, lb = log_ball(a), log_ball(b)
    assert exp_ball_of_ball(la).contains_exact(a) and exp_ball_of_ball(lb).contains_exact(b)   # exp(log y) = y
    assert exp_ball_of_ball(la + lb).contains_exact(a * b)                                    # 準備の 2 行目
    assert surely_equal(log_ball(a * b), la + lb)                                              # 主張の鎖の両端
print(f"{len(POINTS)} 組の (a, b) で exp(log a + log b) が ab を含み、log(ab) と log a + log b が一致する")
assert surely_lt(log_ball(1) + log_ball(1), log_ball(2))
print("対照: log(1+1) は log 1 + log 1 と異なる（積の法則は和では成り立たない）")
print("RESULT: PASS")
