# 対象ラベル: arccosh_properties
# 主張 (1)〜(4) と、log・exp の値を含む行（log 1 = 0、(1) の不等号、t = log(exp t)）を具体の点で確かめる。
# 帰属: y ∈ AA（実代数的数）、t ∈ QQ の点。log・exp の値は QQ・AA に収まらないので RealBallField(512) へ脱出する。
# exp は本文の部分和に尾の評価を半径として足したボール（Arb の exp は使わない）、log は有理数の端点 lo < hi を
# 本文の exp のボールで exp(lo) < z < exp(hi) と確かめて挟んだ区間（positive_coupling_and_real_log.sage の
# real_log_enclosure。根拠は real_exp_strictly_increasing と exp(log z) = z）。平方根の値 √(y^2-1) は、y ∈ AA なら
# AA の非負の根（厳密）、y がボールなら Arb の sqrt（非負の根を含む区間）を使う。
# 許容誤差は置かず、ボールの包含・重なり・大小（区間全体での比較）で判定する。
load("../../_shared/positive_coupling_and_real_log.sage")


def ball_of_aa(z):
    return RBF512(z)


def arccosh_enclosure_aa(y0):
    """本文 def_arccosh の arccosh(y0) = log(y0 + √(y0^2-1))（y0 ∈ AA、y0 ≥ 1）を含む区間。"""
    r0 = (y0^2 - 1).sqrt()
    return real_log_enclosure_of_ball(ball_of_aa(y0 + r0))


def arccosh_enclosure_ball(yb):
    """y がボール yb（下端 ≥ 1）に入るどの実数でも arccosh(y) を含む区間。"""
    assert yb >= 1
    return real_log_enclosure_of_ball(yb + (yb^2 - 1).sqrt())


# log 1 = 0（準備）: 厳密な根拠は、exp(0) = 1（部分和で厳密。check_lines_exact.sage）と log(exp x) = x である。
# ここでは exp(0) のボールが半径 0 で 1 そのものであることと、log 1 の囲みが 0 を含むことを確かめるだけ
# （囲みは [-2^{-130}, 2^{-130}] 程度で負の値も含むので、≥ 0 の判定には使わない）。
assert exp_ball(0) == 1 and exp_ball(0).rad() == 0
assert real_log_enclosure(QQ(1)).contains_exact(0)
print("PASS 準備 log 1 = log(exp(0)) = 0（exp(0) のボールは半径 0 で 1、log 1 の囲みは 0 を含む）")

Y_POINTS = [AA(1), AA(1) + AA(1) / 10^6, AA(5) / 4, AA(2), AA(2).sqrt() + 1, AA(17) / 8, AA(10)^6]
for y0 in Y_POINTS:
    a = arccosh_enclosure_aa(y0)
    r0 = (y0^2 - 1).sqrt()
    # (1): y + r > 1 なら log(y+r) > log 1 = 0（real_log_strictly_increasing）。y + r = 1（y = 1）なら log 1 = 0。
    if y0 + r0 > 1:
        assert a > 0, y0
    else:
        # y = 1 では y + r = 1 で、arccosh(1) = log 1 = 0 は厳密な log 1 = 0 に依る（囲みは 0 を含むことだけを見る）。
        assert y0 == 1 and y0 + r0 == 1 and a.contains_exact(0)
    # (2): cosh(arccosh y) = y。u がボール a に入るので exp(u)・exp(-u) を exp_ball_of_ball で囲む。
    eu = exp_ball_of_ball(a); emu = exp_ball_of_ball(-a)
    c = cosh_by_definition(eu, emu)
    assert c.contains_exact(QQ(y0)) if y0 in QQ else c.overlaps(ball_of_aa(y0)), y0
    # (2) の途中の行: exp(u) = y + r、exp(-u) = y - r（ボールの重なりで）
    assert eu.overlaps(ball_of_aa(y0 + r0)) and emu.overlaps(ball_of_aa(y0 - r0))
    assert c.rad() < RR(2)^(-100) * max(1, abs(c.mid()))
print(f"PASS (1)・(2) {len(Y_POINTS)} 点の y ∈ AA で arccosh(y) ≥ 0（y > 1 で > 0）、exp(u) = y + r、exp(-u) = y - r、cosh(arccosh y) = y")

# (3): t ≥ 0 かつ cosh t = y なら t = arccosh(y)。t ∈ QQ_{≥0} で y := cosh t（ボール）とし、arccosh(y) の囲みが t を含む。
T_POINTS = [QQ(0), QQ(1) / 1000, QQ(1) / 3, QQ(1), QQ(5) / 2, QQ(7), QQ(30)]
for t0 in T_POINTS:
    if t0 == 0:
        yb = cosh_ball(0)                        # exp(0) = 1 が厳密なので y = 1 そのもの
        assert yb == 1 and yb.rad() == 0
        assert sinh_ball(0) == 0                 # sinh 0 = 0
        assert arccosh_enclosure_aa(AA(1)).contains_exact(0)
        continue
    yb = cosh_ball(t0)
    sb = sinh_ball(t0)
    assert sb > 0                                # t > 0 なら sinh t > 0（cosh_sinh_basic_properties (3)）
    rb = (yb^2 - 1).sqrt()
    assert sb.overlaps(rb)                       # sinh t = √(y^2-1) = r
    lt = real_log_enclosure_of_ball(exp_ball(t0))
    assert lt.contains_exact(t0)                 # t = log(exp(t))
    a = arccosh_enclosure_ball(yb)
    assert a.contains_exact(t0), t0              # t = arccosh(y)
# 対照: t < 0 では cosh t = cosh(-t) なので arccosh(cosh t) = -t ≠ t（仮定 t ≥ 0 が要ること）。
for t0 in [QQ(-1) / 3, QQ(-2)]:
    a = arccosh_enclosure_ball(cosh_ball(t0))
    assert not a.contains_exact(t0) and a.contains_exact(-t0)
print(f"PASS (3) {len(T_POINTS)} 点の t ≥ 0 で sinh t ≥ 0、sinh t = r、t = log(exp t) = arccosh(cosh t)（対照: t < 0 の 2 点では arccosh(cosh t) = -t ≠ t）")

# (4): arccosh(1) = 0
assert arccosh_enclosure_aa(AA(1)).contains_exact(0)
assert not arccosh_enclosure_aa(AA(1) + AA(1) / 10^6).contains_exact(0)   # 対照: y > 1 では 0 でない
print("PASS (4) arccosh(1) の囲みは 0 を含む（対照: y = 1 + 10^-6 では含まない）")
print("RESULT: PASS")
