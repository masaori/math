# 対象ラベル: log_one_plus_at_most_argument
# 準備の鎖 log(1+0) = log 1 = log(exp 0) = 0、H' = 1 - 1/(1+v)、被積分関数の鎖 1 - 1/(1+v) = ((1+v)-1)/(1+v) = v/(1+v) ≥ 0、
# 積分の鎖の五行、最後の鎖 log(1+x) = x - (x - log(1+x)) ≤ x を確かめる。
# 帰属:
# - exp 0 = 1 は本文の部分和 S_N([0]) の成分が QQ で厳密に 1 であることから。log(exp 0) = 0 はそれと log の定義。
# - 被積分関数の鎖は QQ(v) の有理式の等号として、符号は [0, x] の有理数の点で QQ の大小として。
# - H' と積分の値の行（(R4) の当てはめ）は SR の記号微分・記号積分で（x > 0 を仮定）。微分の公式は本文が外部から持ち込む事実で、
#   SR の log の微分はそれと同じ公式である。
# - 主張は具体の x ∈ QQ_{>0} で log を Arb のボールで囲んで確かめる（log の値が QQ に入らないので RealBallField(512) へ脱出）。
load("../../_shared/log_integral_by_balls.sage")
assert entry11(matrix_partial_sum(one_by_one(QQ, QQ(0)), 30)) == 1     # exp 0 = 1（部分和は N によらず 1）
assert log_ball(1 + 0).is_exact() and log_ball(1 + 0) == 0              # log 1 = 0
print("準備の鎖: exp 0 = 1 が部分和で厳密に、log 1 = 0 が成り立つ")
Fv = QQ['v'].fraction_field(); v = Fv.gen()
assert 1 - 1/(1 + v) == ((1 + v) - 1)/(1 + v) == v/(1 + v)
XS = [QQ(1)/1000, QQ(1)/10, QQ(1)/2, QQ(1), QQ(2), QQ(10), QQ(1000)]
for x0 in XS:
    for k in range(11):
        v0 = x0 * k / 10
        assert v0 / (1 + v0) >= 0
print("被積分関数の鎖が QQ(v) で成り立ち、[0, x] の 11 点で v/(1+v) ≥ 0")
vs, xs = SR.var('vs xs')
assume(xs > 0)
H = vs - log(1 + vs)
Hp = diff(H, vs)
assert bool(Hp == 1 - diff(log(vs), vs).subs(vs=1 + vs) * (0 + 1)) and bool(Hp == 1 - 1/(1 + vs) * 1) and bool(Hp == 1 - 1/(1 + vs))   # H' の鎖の三行
assert bool(integrate(1 - 1/(1 + vs), vs, 0, xs) == H.subs(vs=xs) - H.subs(vs=0))   # 2 行目
assert bool(integrate(0, vs, 0, xs) == 0 - 0)                                        # 4 行目
print("H' = 1 - 1/(1+v) と積分の値の二つの行が SR で成り立つ")
for x0 in XS:
    gap = x0 - log_ball(1 + x0)
    assert gap.lower() > 0                                   # 積分の鎖の両端 x - log(1+x) ≥ 0（x > 0 では狭義）
    assert surely_le(log_ball(1 + x0), x0)                   # 主張
Rxl.<xx, ll> = QQ[]
assert ll == xx - (xx - ll) and xx - 0 == xx                  # 最後の鎖の等号（ll は log(1+x) の不定元）
print(f"{len(XS)} 点の x > 0 で x - log(1+x) > 0 と log(1+x) ≤ x がボールで確定する。x = 0 では等号")
assert surely_lt(QQ(1)/2, log_ball(2))
print("対照: x = 1 で log(1+x) ≤ x/2 は成り立たない")
print("RESULT: PASS")
