# 対象ラベル: riemann_sum_to_integral
# Step 6（収束）と主張を確かめる。極限そのものは有限の計算では確かめられないので、次を確かめる。
#  (a) ε ごとに η_0 を取り、標本の組 (s, t)（|s - t| ≤ η_0）で |g(s) - g(t)| ≤ ε を直接確かめ（一様連続性の η_0 の性質）、（t^2・|t - π| は 1, 1/10, 1/100、cos t は 1, 1/2。cos t は値が次数の高い代数的数になり、
#      M が大きいと AA の計算が終わらないので小さく取る）、η_0 = q_0π について、
#      0 < h ≤ η_0 の標本の h で 0 ≤ ω(h) ≤ ε、N := ⌊2π/η_0⌋ + 1 について M ≥ N の鎖（M > 2π/η_0、2π/M = (η_0/M)(2π/η_0) < η_0）、
#      M = N,…,N+2 で主張の左辺 ≤ ω(2π/M) ≤ ε。
#  (b) δ = 0 と δ = 1/2 の誤差 |平均 - (1/2π)∫| を M = 1,…,40（cos t は 1,…,16）で計算し、ω(2π/M) 以下であること、
#      ω(2π/M) が M について減少することを確かめる。
#  (c) 主張の末尾の注記: δ = 0 の t_M = 2π は I_M の右端、δ = 1 の t_1 = 0 は I_1 の左端。
load("riemann_sum_by_definition.sage")

def lhs(g, dl, M):
    S = sum(g.value(2 * (mu - dl) / M) for mu in range(1, M + 1))
    return rabs(RF(1) / M * S - RF(1) / pt(2) * integral(g, 0, 2))

for g in TEST_FUNCTIONS:
    eps_list = [QQ(1), QQ(1) / 2] if g.name == "g(t) = cos t" else [QQ(1), QQ(1) / 10, QQ(1) / 100]
    for eps in eps_list:
        q0 = QQ(1)
        while not leq(g.omega(q0), eps):
            q0 /= 2
        d0 = pt(q0)
        grid = [QQ(k) / 60 for k in range(0, 121)]                 # [0,2π] の点 kπ/60
        for qs in grid:
            for qt in [qs + q0 * QQ(k) / 4 for k in range(-4, 5)]:
                if 0 <= qt <= 2:
                    assert leq(rabs(g.value(qs) - g.value(qt)), eps)      # |s - t| ≤ η_0 なら |g(s) - g(t)| ≤ ε
        for qh in [q0 * QQ(k) / 7 for k in range(1, 8)]:
            assert leq(0, g.omega(qh)) and leq(g.omega(qh), eps)
        N = floor(QQ(2) / q0) + 1                              # ⌊2π/η_0⌋ = ⌊2/q_0⌋
        assert floor(to_ball(RF(pt(2)) / d0).upper()) == floor(to_ball(RF(pt(2)) / d0).lower()) == N - 1
        for M in range(N, N + 3):
            assert M >= N and lt(RF(pt(2)) / d0, M)            # M ≥ ⌊2π/η_0⌋ + 1 > 2π/η_0
            c = [RF(pt(QQ(2) / M)), (d0 / M) * (RF(pt(2)) / d0), (d0 / M) * M, RF(d0)]
            assert c[0] == c[1] and lt(c[1], c[2]) and c[2] == c[3]
            for dl in [QQ(0), QQ(1) / 2, QQ(1)]:
                L = lhs(g, dl, M)
                assert leq(L, g.omega(QQ(2) / M)) and leq(g.omega(QQ(2) / M), eps)
    print(f"{g.name}: Step 6 を ε = {eps_list} で確かめた")

for g in TEST_FUNCTIONS:
    prev = None
    worst = {}
    Mmax = 16 if g.name == "g(t) = cos t" else 40
    for M in range(1, Mmax + 1):
        w = g.omega(QQ(2) / M)
        if prev is not None:
            assert leq(w, prev)
        prev = w
        for dl in [QQ(0), QQ(1) / 2]:
            L = lhs(g, dl, M)
            assert leq(L, w)
            worst[dl] = to_ball(L)
    print(f"{g.name}: M = {Mmax} での誤差 δ=0: {worst[QQ(0)].mid().n(digits=6)}, δ=1/2: {worst[QQ(1)/2].mid().n(digits=6)}, ω(2π/{Mmax}) = {to_ball(prev).mid().n(digits=6)}")

for M in range(1, 13):
    xs = [pt(QQ(2 * nu) / M) for nu in range(M + 1)]
    I_M, I_1 = (xs[M - 1], xs[M]), (xs[0], xs[1])
    assert pt(2 * (M - QQ(0)) / M) == I_M[1] == pt(2)           # δ = 0: t_M は I_M の右端で 2π
    assert pt(2 * (1 - QQ(1)) / M) == I_1[0] == 0               # δ = 1: t_1 は I_1 の左端で 0
print("(c) δ = 0, 1 の端の代表点を確かめた")
print("RESULT: PASS")
