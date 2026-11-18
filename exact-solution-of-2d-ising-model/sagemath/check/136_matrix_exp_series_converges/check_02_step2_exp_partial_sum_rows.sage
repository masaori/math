# <matrix_exp_series_converges>: Step 2 の鎖の後ろの 3 段
#   ‖I‖ + Σ_{m=1}^{N} ‖A‖^m/m!
#     = ‖I‖ + (E_N(‖A‖) − 1)   (∵ E_N の定義（a → ‖A‖）で m = 0 の項は ‖A‖^0/0! = 1)
#     ≤ ‖I‖ + E_N(‖A‖)         (∵ 1 ≥ 0)
#     ≤ ‖I‖ + E(‖A‖)           (∵ real_exp_series_converges (2))
# を確かめる。‖A‖ と ‖I‖ は def_matrix_norm の値（ℝ_{≥0}）で、ここでは ‖A‖ を QQ の非負の値で走らせ、
# 部分和を QQ で厳密に計算する。E は ℝ の極限なので exp を RealIntervalField(256) の区間で囲み、
# 区間の上端 ≤ 下端で比べる（ℝ への脱出: E(a) は部分和の極限として ℝ にしか住まない）。
# ‖I‖ は def_matrix_norm で ‖I_n‖ = √n なので、n ∈ {1, 2, 3, 5} の √n を AA で持つ。
load("../../_shared/operators.sage")
rep = CheckReport("matrix_exp_series_converges: Step 2 の E_N を経る 3 段")
RIF = RealIntervalField(256)

def partial(a, p, q):
    # Σ_{m=p}^{q} a^m/m!（p > q なら空の和 0。a^0 := 1, 0! := 1）
    return sum(QQ(a) ** m / factorial(m) for m in range(p, q + 1))

def E_N(a, N):
    return partial(a, 0, N)

def le(x, y):
    # 区間 x の全点が区間 y の全点以下（x の上端 ≤ y の下端）
    return x.upper() <= y.lower()

rows = 0
for a in [QQ(0), QQ(1)/3, QQ(1), QQ(5)/2, QQ(7)]:
    for N in range(0, 16):
        # 1 段目の前提: m = 0 の項は a^0/0! = 1（a = 0 でも a^0 := 1）
        rep.truth(QQ(a) ** 0 / factorial(0) == 1, f"m=0 の項 a={a}")
        # 2 段目の前提 1 ≥ 0、3 段目の前提 (2) E_N(a) ≤ E(a)
        rep.truth(QQ(1) >= 0, "2 段目の前提 1 ≥ 0")
        rep.truth(le(RIF(E_N(a, N)), RIF(a).exp()), f"(2) a={a}, N={N}")
        for n in [1, 2, 3, 5]:
            normI = AA(n).sqrt()
            lhs = normI + partial(a, 1, N)
            row1 = normI + (E_N(a, N) - 1)
            row2 = normI + E_N(a, N)
            rep.truth(lhs == row1, f"1 段目 a={a}, N={N}, n={n}")
            rep.truth(row1 <= row2, f"2 段目 a={a}, N={N}, n={n}")
            row3 = RIF(normI) + RIF(a).exp()
            # 3 段目: 両辺 ‖I‖ + E_N(a) と ‖I‖ + E(a) を区間で比べると、a = 0 では両辺が等しく、
            # 両辺の √n を囲む区間の幅で le が落ちる。両辺の差は ‖I‖ が消えて E(a) − E_N(a) = R_N(a) に
            # なるので、この差の区間の下端 ≥ 0 で比べる（n によらない比較なので n ごとに同じ判定になる）。
            rep.truth((RIF(a).exp() - RIF(E_N(a, N))).lower() >= 0, f"3 段目 a={a}, N={N}, n={n}")
            # 鎖の両端
            rep.truth((row3 - RIF(lhs)).lower() >= 0, f"両端 a={a}, N={N}, n={n}")
            rows += 1
# 否定の対照: m = 0 の項 1 を抜かずに E_N をそのまま置くと 1 段目の等号は成り立たない
a, N = QQ(1), 4
rep.truth(partial(a, 1, N) != E_N(a, N), "否定の対照: Σ_{m=1}^{N} は E_N(a) と等しくない")
print("  確かめた行: %d" % rows)
rep.finish()
