# 対象ラベル: moment_log_convexity
# 証明の準備（【冪の実対称性】【W^ax の成分】【冪の分け方】【二つの冪で挟んだ値】【I と W の正値性】【W^ax は零でない】）、
# 【正値性】の二つの鎖、【P = W の不等式】【P = I の不等式】の鎖、奇数・偶数の場合分けの鎖と添字の確認、主張そのものを、
# 実対称で正定値な P（本文では P = W）と ‖x‖ = 1 の x ∈ QQ^d について一行ずつ確かめる。等号・不等号はすべて QQ の厳密な比較である。

n_eq = 0
n_le = 0


def eq(a, b, what):
    global n_eq
    assert a == b, what
    n_eq += 1


def le(a, b, what, strict=False):
    global n_le
    assert (a < b) if strict else (a <= b), what
    n_le += 1


def check_proof_lines(P, x, kmax, what):
    """P は QQ の実対称で正定値、x ∈ QQ^d は ‖x‖ = 1、kmax は主張 m_k^2 ≤ m_{k−1}m_{k+1} を確かめる最大の k。"""
    d = P.nrows()
    R = QQ
    I = body_identity(R, d)
    K = kmax + 1                                      # 現れる冪の最大の指数
    pw = [power_by_def_exp(P, p) for p in range(K + 1)]
    m = [bil(x, pw[k], x) for k in range(K + 1)]      # m_k := x^⊤W^kx
    eq(norm_exact(x), 1, f"{what}: ‖x‖ = 1")
    for k in range(K + 1):
        eq(pw[k], P**k, f"{what}: def_exp (1) の冪と Sage の冪 k={k}")
        eq(m[k], (x.row() * P**k * x.column())[0, 0], f"{what}: m_k と組み込みの行列積 k={k}")
    # 【冪の実対称性】: (W^p)_kl = ((W^p)^⊤)_kl = (W^p)_lk
    for p in range(K + 1):
        assert pw[p].base_ring() == QQ
        T = body_transpose(pw[p])
        eq(T, pw[p], f"{what}: (W^p)^⊤ = W^p p={p}")
        for k in range(d):
            for l in range(d):
                eq(pw[p][k, l], T[k, l], f"{what}: 【冪の実対称性】 1 行目")
                eq(T[k, l], pw[p][l, k], f"{what}: 【冪の実対称性】 2 行目")
    # I の成分は δ_kl（実数）で、I_kl = I_lk
    for k in range(d):
        for l in range(d):
            eq(I[k, l], 1 if k == l else 0, f"{what}: I_kl = δ_kl")
            eq(I[k, l], I[l, k], f"{what}: I_kl = I_lk")
    # 【W^ax の成分】: u^(a)_l = Σ_m (W^a)_lm x_m
    U = []
    for a in range(K + 1):
        u = matvec(pw[a], x)
        eq(u, P**a * x, f"{what}: 【W^ax の成分】と組み込みの積 a={a}")
        for l in range(d):
            eq(u[l], sum(pw[a][l, mm] * x[mm] for mm in range(d)), f"{what}: 【W^ax の成分】 a={a}, l={l}")
        U.append(u)
    # 【冪の分け方】の一つ目と二つ目
    for a in range(K + 1):
        for b in range(K + 1):
            if a + b <= K:
                L = [pw[a + b], pw[b + a], body_product(pw[b], pw[a]), body_product(pw[b], body_product(I, pw[a]))]
                for s, t in zip(L, L[1:]):
                    eq(s, t, f"{what}: 【冪の分け方】の一つ目 a={a}, b={b}")
            if a + b + 1 <= K:
                L = [pw[a + b + 1],
                     pw[b + (1 + a)],
                     body_product(pw[b], pw[1 + a]),
                     body_product(pw[b], body_product(pw[1], pw[a])),
                     body_product(pw[b], body_product(pw[0 + 1], pw[a])),
                     body_product(pw[b], body_product(body_product(pw[0], P), pw[a])),
                     body_product(pw[b], body_product(body_product(I, P), pw[a])),
                     body_product(pw[b], body_product(P, pw[a]))]
                for s, t in zip(L, L[1:]):
                    eq(s, t, f"{what}: 【冪の分け方】の二つ目 a={a}, b={b}")
    # 【二つの冪で挟んだ値】: x^⊤(W^b(BW^a))x = (u^(b))^⊤ B u^(a)（B = I, W）
    rng = range(d)
    for B, Bname in [(I, "I"), (P, "W")]:
        for a in range(K + 1):
            for b in range(K + 1):
                if a + b + (1 if Bname == "W" else 0) > K:
                    continue
                BWa = body_product(B, pw[a])
                M = body_product(pw[b], BWa)
                assert BWa.base_ring() == QQ and M.base_ring() == QQ   # product_of_real_entry_matrices_has_real_entries の二回の適用
                Wa, Wb = pw[a], pw[b]
                L = [bil(x, M, x),
                     sum(sum(x[i] * M[i, j] * x[j] for j in rng) for i in rng),
                     sum(sum(x[i] * sum(Wb[i, l] * BWa[l, j] for l in rng) * x[j] for j in rng) for i in rng),
                     sum(sum(x[i] * sum(Wb[i, l] * sum(B[l, mm] * Wa[mm, j] for mm in rng) for l in rng) * x[j] for j in rng) for i in rng),
                     sum(x[i] * Wb[i, l] * B[l, mm] * Wa[mm, j] * x[j] for i in rng for j in rng for l in rng for mm in rng),
                     sum(x[i] * Wb[i, l] * B[l, mm] * Wa[mm, j] * x[j] for l in rng for mm in rng for i in rng for j in rng),
                     sum(sum(x[i] * Wb[i, l] for i in rng) * B[l, mm] * sum(Wa[mm, j] * x[j] for j in rng) for l in rng for mm in rng),
                     sum(sum(x[i] * Wb[l, i] for i in rng) * B[l, mm] * sum(Wa[mm, j] * x[j] for j in rng) for l in rng for mm in rng),
                     sum(sum(Wb[l, i] * x[i] for i in rng) * B[l, mm] * sum(Wa[mm, j] * x[j] for j in rng) for l in rng for mm in rng),
                     sum(U[b][l] * B[l, mm] * U[a][mm] for l in rng for mm in rng),
                     bil(U[b], B, U[a])]
                for s, t in zip(L, L[1:]):
                    eq(s, t, f"{what}: 【二つの冪で挟んだ値】 B={Bname}, a={a}, b={b}")
                # 別の経路: 組み込みの積で (P^bx)^⊤B(P^ax) と x^⊤P^{a+b(+1)}x
                eq(L[-1], ((P**b * x).row() * B * (P**a * x).column())[0, 0], f"{what}: 【二つの冪で挟んだ値】と組み込みの積 B={Bname}")
                e = a + b + (1 if Bname == "W" else 0)
                eq(L[0], m[e], f"{what}: 【二つの冪で挟んだ値】の左辺は m_{{a+b(+1)}} B={Bname}, a={a}, b={b}")
    # 【I と W の正値性】: y^⊤Iy = ΣΣ y_k δ_kl y_l = Σ y_k δ_kk y_k = Σ y_k y_k ≥ 0（y ≠ 0 なら > 0）。y^⊤Wy > 0（y ≠ 0）
    ys = list(U) + [vector(QQ, [QQ.random_element(num_bound=5, den_bound=4) for _ in rng]) for _ in range(4)] + [zero_vector(QQ, d)]
    for y in ys:
        L = [bil(y, I, y),
             sum(sum(y[k] * (1 if k == l else 0) * y[l] for l in rng) for k in rng),
             sum(y[k] * 1 * y[k] for k in rng),
             sum(y[k] * y[k] for k in rng)]
        for s, t in zip(L, L[1:]):
            eq(s, t, f"{what}: 【I と W の正値性】の I の鎖")
        le(0, L[-1], f"{what}: y^⊤Iy ≥ 0")
        le(0, bil(y, P, y), f"{what}: y^⊤Wy ≥ 0")
        if y != 0:
            le(0, L[-1], f"{what}: y ≠ 0 なら y^⊤Iy > 0", strict=True)
            le(0, bil(y, P, y), f"{what}: y ≠ 0 なら y^⊤Wy > 0", strict=True)
    # 【I と W の正値性】の後半: I_kl = δ_kl = δ_lk = I_lk、W_kl = (W^⊤)_kl = W_lk（def_real_symmetric_matrix の意味の対称）
    assert is_real_symmetric(I) and is_real_symmetric(P)
    for k in rng:
        for l in rng:
            eq(I[k, l], 1 if k == l else 0, "I_kl = δ_kl"); eq(1 if k == l else 0, 1 if l == k else 0, "δ_kl = δ_lk"); eq(1 if l == k else 0, I[l, k], "δ_lk = I_lk")
            eq(P[k, l], body_transpose(P)[k, l], "W_kl = (W^⊤)_kl"); eq(body_transpose(P)[k, l], P[l, k], "(W^⊤)_kl = W_lk")
    # 【W^ax は零でない】
    assert x != 0
    eq(norm_exact(zero_vector(QQ, d)), 0, f"{what}: ‖0‖ = 0")
    L = [U[0], pw[0] * x, matvec(I, x), x]
    for s, t in zip(L, L[1:]):
        eq(s, t, f"{what}: u^(0) = W^0x = Ix = x")
    for a in range(K):
        L = [U[a + 1],
             matvec(pw[a + 1], x),
             matvec(pw[1 + a], x),
             matvec(body_product(pw[1], pw[a]), x),
             matvec(body_product(pw[0 + 1], pw[a]), x),
             matvec(body_product(body_product(pw[0], P), pw[a]), x),
             matvec(body_product(body_product(I, P), pw[a]), x),
             matvec(body_product(P, pw[a]), x),
             matvec(P, matvec(pw[a], x)),
             matvec(P, U[a])]
        for s, t in zip(L, L[1:]):
            eq(s, t, f"{what}: u^(a+1) = Wu^(a) の鎖 a={a}")
    for a in range(K + 1):
        u = U[a]
        Wu = matvec(P, u)
        L = [bil(u, P, u),
             sum(sum(u[k] * P[k, l] * u[l] for l in rng) for k in rng),
             sum(u[k] * sum(P[k, l] * u[l] for l in rng) for k in rng),
             sum(u[k] * Wu[k] for k in rng)]
        for s, t in zip(L, L[1:]):
            eq(s, t, f"{what}: 背理法の鎖の 1〜3 行目 a={a}")
        assert u != 0 and Wu != 0, f"{what}: W^ax ≠ 0 a={a}"
    # 【正値性】: m_{2a} = x^⊤W^{a+a}x = x^⊤(W^a(IW^a))x = (u^(a))^⊤Iu^(a) > 0、m_{2a+1} も同様に W で
    for a in range(K // 2 + 1):
        if 2 * a <= K:
            L = [m[2 * a], bil(x, pw[a + a], x), bil(x, body_product(pw[a], body_product(I, pw[a])), x), bil(U[a], I, U[a])]
            for s, t in zip(L, L[1:]):
                eq(s, t, f"{what}: 【正値性】の偶数の鎖 a={a}")
            le(0, L[-1], f"{what}: m_{{2a}} > 0", strict=True)
        if 2 * a + 1 <= K:
            L = [m[2 * a + 1], bil(x, pw[a + a + 1], x), bil(x, body_product(pw[a], body_product(P, pw[a])), x), bil(U[a], P, U[a])]
            for s, t in zip(L, L[1:]):
                eq(s, t, f"{what}: 【正値性】の奇数の鎖 a={a}")
            le(0, L[-1], f"{what}: m_{{2a+1}} > 0", strict=True)
    # 【P = W の不等式】と【P = I の不等式】
    for a in range(K + 1):
        for b in range(K + 1):
            if 2 * max(a, b) + 1 <= K:
                L1 = [m[a + b + 1]**2,
                      bil(x, pw[a + b + 1], x)**2,
                      bil(x, body_product(pw[b], body_product(P, pw[a])), x)**2,
                      bil(U[b], P, U[a])**2]
                for s, t in zip(L1, L1[1:]):
                    eq(s, t, f"{what}: 【P = W の不等式】の前半 a={a}, b={b}")
                rhs = [bil(U[a], P, U[a]) * bil(U[b], P, U[b]),
                       bil(x, body_product(pw[a], body_product(P, pw[a])), x) * bil(x, body_product(pw[b], body_product(P, pw[b])), x),
                       bil(x, pw[a + a + 1], x) * bil(x, pw[b + b + 1], x),
                       bil(x, pw[2 * a + 1], x) * bil(x, pw[2 * b + 1], x),
                       m[2 * a + 1] * m[2 * b + 1]]
                le(L1[-1], rhs[0], f"{what}: 【P = W の不等式】の Cauchy–Schwarz a={a}, b={b}")
                for s, t in zip(rhs, rhs[1:]):
                    eq(s, t, f"{what}: 【P = W の不等式】の後半 a={a}, b={b}")
            if 2 * max(a, b) <= K:
                L1 = [m[a + b]**2,
                      bil(x, pw[a + b], x)**2,
                      bil(x, body_product(pw[b], body_product(I, pw[a])), x)**2,
                      bil(U[b], I, U[a])**2]
                for s, t in zip(L1, L1[1:]):
                    eq(s, t, f"{what}: 【P = I の不等式】の前半 a={a}, b={b}")
                rhs = [bil(U[a], I, U[a]) * bil(U[b], I, U[b]),
                       bil(x, body_product(pw[a], body_product(I, pw[a])), x) * bil(x, body_product(pw[b], body_product(I, pw[b])), x),
                       bil(x, pw[a + a], x) * bil(x, pw[b + b], x),
                       bil(x, pw[2 * a], x) * bil(x, pw[2 * b], x),
                       m[2 * a] * m[2 * b]]
                le(L1[-1], rhs[0], f"{what}: 【P = I の不等式】の Cauchy–Schwarz a={a}, b={b}")
                for s, t in zip(rhs, rhs[1:]):
                    eq(s, t, f"{what}: 【P = I の不等式】の後半 a={a}, b={b}")
    # 場合分け: a := ⌊(k−1)/2⌋、b := a+1、p = a
    for k in range(1, kmax + 1):
        a = (k - 1) // 2
        b = a + 1
        if k % 2 == 1:
            p = (k - 1) // 2
            eq(p, a, f"{what}: 奇数で p = ⌊(k−1)/2⌋")
            eq(a + b, p + (p + 1), "添字"); eq(p + (p + 1), 2 * p + 1, "添字"); eq(2 * p + 1, k, "添字")
            eq(2 * a, 2 * p, "添字"); eq(2 * p, k - 1, "添字")
            eq(2 * b, 2 * (p + 1), "添字"); eq(2 * (p + 1), 2 * p + 2, "添字"); eq(2 * p + 2, k + 1, "添字")
            eq(m[k]**2, m[a + b]**2, f"{what}: 奇数の鎖 1 行目 k={k}")
            le(m[a + b]**2, m[2 * a] * m[2 * b], f"{what}: 奇数の鎖 2 行目 k={k}")
            eq(m[2 * a] * m[2 * b], m[2 * p] * m[2 * p + 2], f"{what}: 奇数の鎖 3 行目")
            eq(m[2 * p] * m[2 * p + 2], m[k - 1] * m[k + 1], f"{what}: 奇数の鎖 4 行目")
        else:
            p = (k - 2) // 2
            eq(p, a, f"{what}: 偶数で p = ⌊(k−1)/2⌋")
            eq(a + b + 1, p + (p + 1) + 1, "添字"); eq(p + (p + 1) + 1, 2 * p + 2, "添字"); eq(2 * p + 2, k, "添字")
            eq(2 * a + 1, 2 * p + 1, "添字"); eq(2 * p + 1, k - 1, "添字")
            eq(2 * b + 1, 2 * (p + 1) + 1, "添字"); eq(2 * (p + 1) + 1, 2 * p + 3, "添字"); eq(2 * p + 3, k + 1, "添字")
            eq(m[k]**2, m[a + b + 1]**2, f"{what}: 偶数の鎖 1 行目 k={k}")
            le(m[a + b + 1]**2, m[2 * a + 1] * m[2 * b + 1], f"{what}: 偶数の鎖 2 行目 k={k}")
            eq(m[2 * a + 1] * m[2 * b + 1], m[2 * p + 1] * m[2 * p + 3], f"{what}: 偶数の鎖 3 行目")
            eq(m[2 * p + 1] * m[2 * p + 3], m[k - 1] * m[k + 1], f"{what}: 偶数の鎖 4 行目")
        assert p >= 0
    # 主張: m_k > 0（k ≤ K）、m_k^2 ≤ m_{k−1}m_{k+1}（1 ≤ k ≤ kmax）
    for k in range(K + 1):
        le(0, m[k], f"{what}: 主張 m_k > 0 k={k}", strict=True)
    for k in range(1, kmax + 1):
        le(m[k]**2, m[k - 1] * m[k + 1], f"{what}: 主張 m_k^2 ≤ m_{{k−1}}m_{{k+1}} k={k}")
