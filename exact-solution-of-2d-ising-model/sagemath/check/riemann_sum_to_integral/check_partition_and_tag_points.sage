# 対象ラベル: riemann_sum_to_integral
# Step 0（端点 x_ν、区間の長さ、区間加法性、I_μ ⊂ [0,2π]）と Step 2（代表点が I_μ に入ること、t ∈ I_μ との距離）を確かめる。
#  (A) 等号の行を、π・δ・μ・M を不定元とする QQ 上の有理関数として確かめる。
#  (B) 不等号の行を、δ ∈ {0, 1/4, 1/2, 3/4, 1}、M = 1,…,12、μ = 1,…,M の具体の値で厳密に確かめる。
#  (C) 区間加法性の三行を、三つの試験関数で確かめる。原始関数 G で作る値どうしの等号は望遠鏡和なので、
#      それが確かめるのは区間の端がつながっていること（x_0 = 0、x_M = 2π、I_μ の右端 = I_{μ+1} の左端）である。
#      各区間と全区間の積分の値そのものは、Sage の記号積分をボールで評価した独立な値と照合する。
#  (D) δ ∉ [0,1] では代表点が I_μ から出ることを確かめる（仮定が効いている行の確認）。
load("riemann_sum_by_definition.sage")

F = FractionField(PolynomialRing(QQ, ["P", "d", "m", "N"]))
P, d, m, N = F.gens()       # P = π, d = δ, m = μ, N = M
x = lambda nu: 2 * P * nu / N        # x_ν の定義
# Step 0 の端点と長さの鎖
assert x(0) == 2 * P * 0 / N == 0
assert x(N) == 2 * P * N / N == 2 * P
assert x(m) - x(m - 1) == 2 * P * m / N - 2 * P * (m - 1) / N == 2 * P / N
# Step 0 の I_μ ⊂ [0,2π] の二つの鎖の等号
assert F(0) == (2 * P / N) * 0
assert (2 * P / N) * (m - 1) == x(m - 1)
assert x(m) == (2 * P / N) * m
assert (2 * P / N) * N == 2 * P
# Step 2 の二本の鎖の等号
lo, tm_ = x(m - 1), 2 * P * (m - d) / N
assert lo == lo + 0
assert lo + (2 * P / N) * (1 - d) == 2 * P * (m - 1) / N + (2 * P / N) * (1 - d) == 2 * P * (m - d) / N == tm_
assert tm_ == 2 * P * (m - 1) / N + (2 * P / N) * (1 - d) == lo + (2 * P / N) * (1 - d)
assert lo + 2 * P / N == x(m)
# 距離の鎖の最後の等号
assert x(m) - x(m - 1) == 2 * P / N
print("(A) 等号の行を有理関数として確かめた")

deltas = [QQ(0), QQ(1) / 4, QQ(1) / 2, QQ(3) / 4, QQ(1)]
count = 0
for dl in deltas:
    for M in range(1, 13):
        h = pt(QQ(2) / M)                              # 2π/M
        assert lt(0, h)
        # Step 2 の準備
        assert leq(0, h * (1 - dl)) and leq(h * (1 - dl), h)
        for mu in range(1, M + 1):
            a, b = pt(QQ(2 * (mu - 1)) / M), pt(QQ(2 * mu) / M)       # x_{μ-1}, x_μ
            # Step 0 の鎖: 0 = (2π/M)·0 ≤ (2π/M)(μ-1) = x_{μ-1}、x_μ = (2π/M)μ ≤ (2π/M)M = 2π
            assert b - a == h and lt(a, b)                                 # |I_μ| = 2π/M > 0
            if mu < M:
                assert b == pt(QQ(2 * ((mu + 1) - 1)) / M)                 # I_μ の右端 = I_{μ+1} の左端（I_{μ+1} の定義で作る）
            c0 = [R(0), h * 0, h * (mu - 1), a]
            assert c0[0] == c0[1] and leq(c0[1], c0[2]) and c0[2] == c0[3]
            c1 = [b, h * mu, h * M, pt(2)]
            assert c1[0] == c1[1] and leq(c1[1], c1[2]) and c1[2] == c1[3]
            # Step 2 の二本の鎖
            tm = pt(2 * (mu - dl) / M)
            c2 = [a, a + 0, a + h * (1 - dl), pt(QQ(2 * (mu - 1)) / M) + h * (1 - dl), pt(2 * (mu - dl) / M), tm]
            assert c2[0] == c2[1] and leq(c2[1], c2[2]) and c2[2] == c2[3] == c2[4] == c2[5]
            c3 = [tm, pt(2 * (mu - dl) / M), pt(QQ(2 * (mu - 1)) / M) + h * (1 - dl), a + h * (1 - dl), a + h, b]
            assert c3[0] == c3[1] == c3[2] == c3[3] and leq(c3[3], c3[4]) and c3[4] == c3[5]
            assert leq(0, tm) and leq(tm, pt(2))                           # t_μ ∈ I_μ ⊂ [0,2π]
            # t ∈ I_μ との距離（二つの場合）。t は I_μ の 9 等分点
            for k in range(9):
                t = a + (b - a) * QQ(k) / 8
                if leq(tm, t):
                    ch = [rabs(t - tm), t - tm, b - tm, b - a, h]
                    assert ch[0] == ch[1] and leq(ch[1], ch[2]) and leq(ch[2], ch[3]) and ch[3] == ch[4]
                else:
                    assert lt(t, tm)
                    ch = [rabs(t - tm), tm - t, b - t, b - a, h]
                    assert ch[0] == ch[1] and leq(ch[1], ch[2]) and leq(ch[2], ch[3]) and ch[3] == ch[4]
                count += 1
print(f"(B) 不等号の行を {count} 組の (δ, M, μ, t) で厳密に確かめた")

for g in TEST_FUNCTIONS:
    whole = integral(g, 0, 2)
    assert matches_ball(whole, sym_integral_ball(g, 0, 2))
    for M in range(1, 13):
        xs = [QQ(2 * nu) / M for nu in range(M + 1)]
        assert xs[0] == 0 and xs[M] == 2
        assert integral(g, xs[0], xs[M]) == whole                                  # ∫_0^2π = ∫_{x_0}^{x_M}
        parts = [integral(g, xs[mu - 1], xs[mu]) for mu in range(1, M + 1)]         # ∫_{x_{μ-1}}^{x_μ} = ∫_{I_μ}
        assert sum(parts) == whole, (g.name, M)
        for mu in range(1, M + 1):
            assert matches_ball(parts[mu - 1], sym_integral_ball(g, xs[mu - 1], xs[mu]))
    print(f"(C) {g.name}: 区間加法性の三行を M = 1,…,12 で確かめ、各区間の積分を記号積分と照合した（∫_0^2π g = {whole}）")

for dl in [QQ(-1) / 2, QQ(3) / 2]:
    M, mu = 4, 2
    a, b = pt(QQ(2 * (mu - 1)) / M), pt(QQ(2 * mu) / M)
    tm = pt(2 * (mu - dl) / M)
    assert not (leq(a, tm) and leq(tm, b))
print("(D) δ = -1/2, 3/2 では代表点が I_μ から出ることを確かめた")
print("RESULT: PASS")
