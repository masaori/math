# 対象ラベル: riemann_sum_to_integral
# Step 1（連続度 ω(h) が実数として定まること）を確かめる。三つの試験関数それぞれで、
#  (a) ε = 1 の一様連続性を満たす η_1 = q_1π を取り（ω(η_1) ≤ 1 を厳密に確かめる）、K η_1 ≥ 2π となる最小の K ∈ Z_{≥1} を取る。
#  (b) s, t ∈ [0,2π] の標本の組で、|t - s| ≤ 2π の二つの場合の鎖、u_j := (1 - j/K)s + (j/K)t の準備の不等式と
#      u_j ∈ [0,2π] の二本の鎖、|u_{j+1} - u_j| の四行の鎖、|g(t) - g(s)| の四行の鎖を一行ずつ確かめる。
#      第三行の根拠「|g(u_{j+1}) - g(u_j)| ≤ 1」も各 j で直接確かめる。
#  (c) ω(h) の定義の集合の元（標本の組）が K 以下で、s = t = 0 の元が 0、0 ≤ ω(h) ≤ K。
load("riemann_sum_by_definition.sage")

choices = {"g(t) = t^2": QQ(1) / 40, "g(t) = cos t": QQ(1) / 3, "g(t) = |t - π|": QQ(1) / 4}
grid = [QQ(k) / 6 for k in range(0, 13)]          # [0,2π] の点 kπ/6
for g in TEST_FUNCTIONS:
    q1 = choices[g.name]
    d1 = pt(q1)
    assert lt(0, d1) and leq(g.omega(q1), 1)                  # (a) η_1 > 0 かつ ω(η_1) ≤ 1
    K = ceil(QQ(2) / q1)
    assert K >= 1 and leq(pt(2), K * d1) and not leq(pt(2), (K - 1) * d1)
    for qs in grid:
        for qt in grid:
            s, t = pt(qs), pt(qt)
            if leq(s, t):
                c = [rabs(t - s), t - s, pt(2) - s, pt(2) - 0, pt(2)]
            else:
                assert lt(t, s)
                c = [rabs(t - s), s - t, pt(2) - t, pt(2) - 0, pt(2)]
            assert c[0] == c[1] and leq(c[1], c[2]) and leq(c[2], c[3]) and c[3] == c[4]   # |t - s| ≤ 2π
            u = [(1 - QQ(j) / K) * s + (QQ(j) / K) * t for j in range(K + 1)]
            assert u[0] == s and u[K] == t
            for j in range(K + 1):
                w0, w1 = 1 - QQ(j) / K, QQ(j) / K
                assert 0 <= w0 <= 1 and 0 <= w1 <= 1
                # 準備: (1-j/K)0 ≤ (1-j/K)s ≤ (1-j/K)2π、(j/K)0 ≤ (j/K)t ≤ (j/K)2π
                assert leq(w0 * 0, w0 * s) and leq(w0 * s, w0 * pt(2)) and leq(w1 * 0, w1 * t) and leq(w1 * t, w1 * pt(2))
                c = [R(0), w0 * 0 + w1 * 0, w0 * s + w1 * 0, w0 * s + w1 * t, u[j]]
                assert c[0] == c[1] and leq(c[1], c[2]) and leq(c[2], c[3]) and c[3] == c[4]
                c = [u[j], w0 * s + w1 * t, w0 * pt(2) + w1 * t, w0 * pt(2) + w1 * pt(2), pt(2)]
                assert c[0] == c[1] and leq(c[1], c[2]) and leq(c[2], c[3]) and c[3] == c[4]
            for j in range(K):
                c = [rabs(u[j + 1] - u[j]), rabs((t - s) / K), rabs(t - s) / K, pt(2) / K, d1]
                assert c[0] == c[1] == c[2] and leq(c[2], c[3]) and leq(c[3], c[4])
            # u_j は π の有理数倍なので、値は有理数 (1 - j/K)qs + (j/K)qt で引く
            qu = [(1 - QQ(j) / K) * qs + (QQ(j) / K) * qt for j in range(K + 1)]
            assert all(u[j] == pt(qu[j]) for j in range(K + 1))
            diffs = [g.value(qu[j + 1]) - g.value(qu[j]) for j in range(K)]
            assert all(leq(rabs(dd), 1) for dd in diffs)
            c = [rabs(g.value(qt) - g.value(qs)), rabs(sum(diffs)), sum(rabs(dd) for dd in diffs), RF(K)]
            assert c[0] == c[1] and leq(c[1], c[2]) and leq(c[2], c[3])
    assert rabs(g.value(0) - g.value(0)) == 0                          # s = t = 0 の元は 0
    for qh in [QQ(1) / 12, QQ(1) / 2, QQ(1), QQ(2), QQ(3)]:
        assert leq(0, g.omega(qh)) and leq(g.omega(qh), K)
    print(f"{g.name}: η_1 = {q1}π, K = {K} で Step 1 の鎖を {len(grid)**2} 組の (s, t) で確かめた")
print("RESULT: PASS")
