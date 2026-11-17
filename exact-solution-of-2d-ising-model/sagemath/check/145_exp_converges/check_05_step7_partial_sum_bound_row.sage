# <exp_converges>: Step 7 の鎖の最後の不等号
#   ‖Y‖ Σ_{m=0}^{N} c_Φ^m/m! ≤ ‖Y‖ E(c_Φ)   (∵ real_exp_series_converges (2) を a = c_Φ に適用し、‖Y‖ ≥ 0)
# を確かめる。E_N(a) は QQ で厳密に、E(a) は ℝ の極限なので RealIntervalField の区間で囲んで比べる
# （ℝ への脱出: E(a) は部分和の極限として ℝ にしか住まない）。‖Y‖ は AA の非負の元（平方根を含む）で動かす。
load("../../_shared/operators.sage")
rep = CheckReport("exp_converges: Step 7 の部分和の上界の行")
RIF = RealIntervalField(256)

def E_N(a, N):
    return sum(QQ(a) ** m / factorial(m) for m in range(N + 1))

def E(a):
    return RIF(a).exp()

rows = 0
# a = 0 の場合: 0^0 := 1 なので E_N(0) = 1 がすべての N で成り立ち、極限 E(0) も 1。行は等号で成り立つ（QQ と AA で厳密）
for N in range(0, 13):
    rep.truth(E_N(QQ(0), N) == 1 and E(QQ(0)).endpoints() == (1, 1), f"a=0, N={N}: E_N(0) = 1、E(0) の区間は [1, 1]")
    for y in [AA(0), AA(1), AA(2).sqrt(), AA(QQ(3)/7)]:
        # 右辺の E(0) も区間で計算する（exp(0) は区間 [1, 1] になる）
        rep.truth((RIF(y) * RIF(E_N(QQ(0), N))).upper() <= (RIF(y) * E(QQ(0))).lower()
                  or (RIF(y) * RIF(E_N(QQ(0), N))).endpoints() == (RIF(y) * E(QQ(0))).endpoints(),
                  f"行 a=0, N={N}, ‖Y‖={y}（両辺の区間が一致するか、左辺の上端 ≤ 右辺の下端）")
        rows += 1
# a > 0 の場合: E_N(a) < E(a) を区間で（上端 < 下端）確かめ、‖Y‖ ≥ 0 を掛けた行を確かめる
for a in [QQ(1)/3, QQ(1), QQ(5)/2, QQ(7)]:
    for N in range(0, 13):
        rep.truth(RIF(E_N(a, N)).upper() < E(a).lower(), f"(2) a={a}, N={N}: E_N(a) ≤ E(a)")
        for y in [AA(0), AA(1), AA(2).sqrt(), AA(QQ(3)/7)]:
            if y == 0:
                rep.truth(y * AA(E_N(a, N)) == 0 and (RIF(y) * E(a)) == 0, f"行 a={a}, N={N}, ‖Y‖=0: 両辺 0")
            else:
                rep.truth((RIF(y) * RIF(E_N(a, N))).upper() < (RIF(y) * E(a)).lower(), f"行 a={a}, N={N}, ‖Y‖={y}")
            rows += 1
# 否定の対照: ‖Y‖ ≥ 0 を外す（負の係数）と不等号の向きが逆になる
rep.truth((RIF(-1) * RIF(E_N(QQ(1), 3))).lower() > (RIF(-1) * E(QQ(1))).upper(), "否定の対照: 負の係数では向きが逆")
print("  確かめた行: %d" % rows)
rep.finish()
