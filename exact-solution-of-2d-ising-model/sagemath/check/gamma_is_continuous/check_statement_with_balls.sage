# 対象ラベル: gamma_is_continuous
# 主張そのもの（γ : ℝ → ℝ_{≥0} は連続）と、Step 1・Step 2 の連続性の結論を具体の点で確かめる。
# 帰属: 結合定数は Y := exp(2K_1)、X := exp(2K_2^*) ∈ QQ_{>1}（c_1, s_1, c_2^*, s_2^* ∈ QQ）、y ∈ QQ の点、θ ∈ QQ の点。
# log・cos の値は QQ・AA に収まらないので RealBallField(512) へ脱出する。
# - log は有理数の端点を本文の exp のボールで確かめて挟んだ区間（positive_coupling_and_real_log.sage の real_log_enclosure。
#   exp は本文の部分和に尾の評価を半径として足したボールで、Arb の exp は使わない）。
# - √ は Arb の sqrt（非負の根を含む区間）。
# - cos は Arb の cos を使う。本文の def_cos は [-π/2, π/2] でしか cos を定めておらず、全実数上の cos は本文に無い
#   （主張に前提として書いてある）。Arb の cos は、入力のボールに入るどの実数 θ についても標準の cos θ を含む区間を返す。
# 許容誤差は置かず、ボールの包含・大小で判定する。振れ幅は区間の端点を QQ にして QQ で比べる（√δ との比較は両辺を 2 乗する）。
# 連続性は有限個の計算では決められない。ここで確かめるのは、θ_0 の周りの幅 2δ の区間に入るどの θ についても γ(θ) を含む区間を
# 作り、その幅が δ = 2^{-10}, 2^{-20}, 2^{-30}, 2^{-40} で 0 へ縮むこと（幅 ≤ 1000δ）である。Step 1 の γ_1 と Step 2 の arccosh に
# ついても同じことを確かめる（arccosh は y_0 < 5/4 で幅 ≤ 10√δ）。これは区間の上での振れ幅 sup|γ(θ)-γ(θ_0)| の上界であり、
# 選んだ点での連続性と矛盾しないことを示すだけで、連続性の証明ではない。区間は連続な部品（Arb の cos、単調な arccosh）から
# 組むので、幅が縮むことは作り方からほぼ決まっており、この検査は主に写し間違い（定義域の端の扱い、式の取り違え）を捕まえる。
import sys
load("../../_shared/positive_coupling_and_real_log.sage")

n_pass = 0


def ok(cond, label):
    global n_pass
    if not cond:
        print("FAIL", label)
        print("RESULT: FAIL")
        sys.exit(1)
    n_pass += 1
    print("PASS", label)


def ball_of_aa(z):
    return RBF512(z)


def arccosh_of_ball(yb):
    """def_arccosh の arccosh(y) = log(y + √(y^2-1)) を、y が区間 yb ∩ [1, ∞) に入るどの実数でも含む区間。
    y ↦ y + √(y^2-1) は [1,∞) 上で単調増加（y と √(y^2-1) がともに単調増加）、log も単調増加（real_log_strictly_increasing）
    なので、端点 l := max(下端, 1)・h := 上端（有理数）での値で挟める。下端を 1 で切ってよい根拠は二通りある。
    γ_1 の値の区間を渡すときは γ_1(θ) ≥ 1（gamma1_lower_bound_all_theta）、arccosh の連続性を y_0 の周りで見るときは
    定義域 [1,∞) に制限していること（Step 2 は [1,∞) の上の連続性を述べる）。"""
    l = max(QQ(yb.lower().exact_rational()), QQ(1))
    h = QQ(yb.upper().exact_rational())
    assert h >= 1
    a_lo = RBF512(l) + (RBF512(l) ^ 2 - 1).sqrt() if l > 1 else RBF512(1)
    a_hi = RBF512(h) + (RBF512(h) ^ 2 - 1).sqrt() if h > 1 else RBF512(1)
    return real_log_enclosure(max(QQ(a_lo.lower().exact_rational()), QQ(1)), QQ(a_hi.upper().exact_rational()))


# ---------------- 主張: 非負・連続 ----------------
COUPLINGS = [(QQ(4), QQ(3)), (QQ(9), QQ(7) / 3), (QQ(2), QQ(5)), (QQ(3), QQ(3)), (QQ(11) / 10, QQ(100))]
THETA_POINTS = [QQ(0), QQ(1) / 7, QQ(1), QQ(3) / 2, QQ(3), QQ(-5) / 2, QQ(10)]


def hyperbolic(Yv, Xv):
    return (Yv + 1 / Yv) / 2, (Yv - 1 / Yv) / 2, (Xv + 1 / Xv) / 2, (Xv - 1 / Xv) / 2


def gamma1_of_ball(Yv, Xv, theta_ball):
    """γ_1(θ) = c_1c_2^* - s_1s_2^* cos θ を、θ がボールに入るどの実数でも含む区間。下端が 1 未満に出ることがあり、
    そのときは arccosh_of_ball が gamma1_lower_bound_all_theta（γ_1(θ) ≥ 1）により下端を 1 で切る。"""
    a1, b1, a2, b2 = hyperbolic(Yv, Xv)
    return RBF512(a1 * a2) - RBF512(b1 * b2) * theta_ball.cos()


def gamma_of_ball(Yv, Xv, theta_ball):
    return arccosh_of_ball(gamma1_of_ball(Yv, Xv, theta_ball))


print("主張: γ(θ) ≥ 0（γ の終域 ℝ_{≥0}）")
for Yv, Xv in COUPLINGS:
    for t0 in THETA_POINTS:
        g = gamma_of_ball(Yv, Xv, RBF512(t0))
        if Yv == Xv and t0 == 0:
            # γ_1(0) = 1 は check_lines_exact.sage が AA で、arccosh(1) = 0 は arccosh_properties (4) が持つ。囲みは 0 を含むことだけを見る
            # （log 1 の囲みは負の値も含むので ≥ 0 の判定には使わない）。
            ok(g.contains_exact(0), f"  (Y,X)=({Yv},{Xv}) θ={t0}: γ = arccosh(1) = 0 の囲みが 0 を含む")
        else:
            ok(g > 0, f"  (Y,X)=({Yv},{Xv}) θ={t0}: γ(θ) > 0")
            ok(g.rad() < RR(2) ^ (-100) * max(1, abs(g.mid())), f"  (Y,X)=({Yv},{Xv}) θ={t0}: 囲みの相対幅は 2^(-100) 未満")

print("Step 1 の結論: γ_1 は連続（θ_0 の周りの区間での振れ幅が δ とともに 0 へ縮む）")
DELTAS = [QQ(2) ^ (-k) for k in (10, 20, 30, 40)]
for Yv, Xv in COUPLINGS:
    for t0 in THETA_POINTS:
        g0 = gamma1_of_ball(Yv, Xv, RBF512(t0))
        widths = []
        for dl in DELTAS:
            gb = gamma1_of_ball(Yv, Xv, RBF512(t0).add_error(dl))
            ok(gb.lower() <= g0.lower() and g0.upper() <= gb.upper(), f"  (Y,X)=({Yv},{Xv}) θ0={t0} δ={dl}: 区間での γ_1 の囲みが γ_1(θ_0) の囲みを含む")
            widths.append(QQ(gb.upper().exact_rational()) - QQ(gb.lower().exact_rational()))
        ok(all(w <= 1000 * dl for w, dl in zip(widths, DELTAS)), f"  (Y,X)=({Yv},{Xv}) θ0={t0}: γ_1 の振れ幅 ≤ 1000δ")
        ok(all(widths[k + 1] < widths[k] for k in range(len(widths) - 1)), f"  (Y,X)=({Yv},{Xv}) θ0={t0}: γ_1 の振れ幅は δ とともに狭義に減る")

print("主張（Step 3 の結論）: γ は連続（θ_0 の周りの区間での振れ幅が δ とともに 0 へ縮む）")
for Yv, Xv in COUPLINGS:
    for t0 in THETA_POINTS:
        g0 = gamma_of_ball(Yv, Xv, RBF512(t0))
        widths = []
        for dl in DELTAS:
            box = RBF512(t0).add_error(dl)                       # [θ_0 - δ, θ_0 + δ] を含むボール
            gb = gamma_of_ball(Yv, Xv, box)
            ok(gb.lower() <= g0.lower() and g0.upper() <= gb.upper(), f"  (Y,X)=({Yv},{Xv}) θ0={t0} δ={dl}: 区間 [θ_0-δ, θ_0+δ] での囲みが γ(θ_0) の囲みを含む")
            widths.append(QQ(gb.upper().exact_rational()) - QQ(gb.lower().exact_rational()))
        ok(all(w <= 1000 * dl for w, dl in zip(widths, DELTAS)),
           f"  (Y,X)=({Yv},{Xv}) θ0={t0}: 振れ幅 {[f'{RR(w):.2e}' for w in widths]} ≤ 1000δ")
        ok(all(widths[k + 1] < widths[k] for k in range(len(widths) - 1)), f"  (Y,X)=({Yv},{Xv}) θ0={t0}: 振れ幅は δ とともに狭義に減る")

print("Step 2 の結論: arccosh は [1,∞) 上で連続（y_0 の周りの [1,∞) の区間での振れ幅が δ とともに 0 へ縮む）")
for y0 in [QQ(1), QQ(1) + QQ(1) / 10 ^ 6, QQ(5) / 4, QQ(2), QQ(17) / 8, QQ(10) ^ 6]:
    a0 = arccosh_of_ball(RBF512(y0))
    widths = []
    for dl in DELTAS:
        gb = arccosh_of_ball(RBF512(y0).add_error(dl))      # [y_0-δ, y_0+δ] ∩ [1,∞)
        ok(gb.lower() <= a0.lower() and a0.upper() <= gb.upper(), f"  y0={y0} δ={dl}: 区間での囲みが arccosh(y_0) の囲みを含む")
        widths.append(QQ(gb.upper().exact_rational()) - QQ(gb.lower().exact_rational()))
    near_end = y0 < QQ(5) / 4                                # 端 y = 1 の近く（傾き 1/√(y^2-1) が大きい）
    within = (lambda w, dl: w ^ 2 <= 100 * dl) if near_end else (lambda w, dl: w <= 1000 * dl)   # w ≤ 10√δ ⇔ w^2 ≤ 100δ
    ok(all(within(w, dl) for w, dl in zip(widths, DELTAS)),
       f"  y0={y0}: 振れ幅 {[f'{RR(w):.2e}' for w in widths]} ≤ {'10√δ' if near_end else '1000δ'}")
    ok(all(widths[k + 1] < widths[k] for k in range(len(widths) - 1)), f"  y0={y0}: 振れ幅は δ とともに狭義に減る")
# 対照: y_0 = 1 では arccosh の振れ幅は δ の 1 次では縮まない（√δ の速さ）。連続だが Lipschitz ではない端点がある。
dl = QQ(2) ^ (-40)
w = arccosh_of_ball(RBF512(1).add_error(dl))
ok(QQ(w.upper().exact_rational()) - QQ(w.lower().exact_rational()) > 1000 * dl, "対照: y_0 = 1 の arccosh の振れ幅は 1000δ を超える（√δ の速さ）")

print(f"-- check_statement_with_balls: {n_pass} PASS")
print("RESULT: PASS")
