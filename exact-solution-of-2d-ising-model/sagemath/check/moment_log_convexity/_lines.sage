# 対象ラベル: moment_log_convexity
# 証明の準備（【冪の実数の行列】【冪の対称性】【(W_ℝ)^ax の成分】【冪の分け方】【二つの冪で挟んだ値】【I_ℝ と W_ℝ の正値性】【(W_ℝ)^ax は零でない】）、
# 【正値性】の二つの鎖、【P = W_ℝ の不等式】【P = I_ℝ の不等式】の鎖、奇数・偶数の場合分けの鎖と添字の確認、主張そのものを、
# 実対称で正定値な P（本文では P = W_ℝ := ϱ(W)）と ‖x‖ = 1 の x ∈ QQ^d について一行ずつ確かめる。check_proof_lines の等号・不等号はすべて QQ の厳密な比較である。
# check_proof_lines は実数の側（P = W_ℝ、I = I_ℝ）の行を、check_varrho_lines は W（QQbar）から ϱ で W_ℝ（AA）へ運ぶ行を、QQbar と AA で厳密に確かめる。

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
    # 【冪の対称性】: (W^p)_kl = ((W^p)^⊤)_kl = (W^p)_lk
    for p in range(K + 1):
        assert pw[p].base_ring() == QQ
        T = body_transpose(pw[p])
        eq(T, pw[p], f"{what}: (W^p)^⊤ = W^p p={p}")
        for k in range(d):
            for l in range(d):
                eq(pw[p][k, l], T[k, l], f"{what}: 【冪の対称性】 1 行目")
                eq(T[k, l], pw[p][l, k], f"{what}: 【冪の対称性】 2 行目")
    # I の成分は δ_kl（実数）で、I_kl = I_lk
    for k in range(d):
        for l in range(d):
            eq(I[k, l], 1 if k == l else 0, f"{what}: I_kl = δ_kl")
            eq(I[k, l], I[l, k], f"{what}: I_kl = I_lk")
    # 【(W_ℝ)^ax の成分】: u^(a)_l = Σ_m (W^a)_lm x_m
    U = []
    for a in range(K + 1):
        u = matvec(pw[a], x)
        eq(u, P**a * x, f"{what}: 【(W_ℝ)^ax の成分】と組み込みの積 a={a}")
        for l in range(d):
            eq(u[l], sum(pw[a][l, mm] * x[mm] for mm in range(d)), f"{what}: 【(W_ℝ)^ax の成分】 a={a}, l={l}")
        U.append(u)
    # 【冪の分け方】の実数の側の結論: (W_ℝ)^{a+b} = (W_ℝ)^b(I_ℝ(W_ℝ)^a)、(W_ℝ)^{a+b+1} = (W_ℝ)^b(W_ℝ(W_ℝ)^a)
    # （Mat(d,ℂ) の二つの鎖と ϱ で運ぶ 5 行の鎖は check_varrho_lines が確かめる）
    for a in range(K + 1):
        for b in range(K + 1):
            if a + b <= K:
                eq(pw[a + b], body_product(pw[b], body_product(I, pw[a])), f"{what}: 【冪の分け方】の一つ目 a={a}, b={b}")
            if a + b + 1 <= K:
                eq(pw[a + b + 1], body_product(pw[b], body_product(P, pw[a])), f"{what}: 【冪の分け方】の二つ目 a={a}, b={b}")
    # 【二つの冪で挟んだ値】: x^⊤((W_ℝ)^b(B(W_ℝ)^a))x = (u^(b))^⊤ B u^(a)（B = I_ℝ, W_ℝ。証明の C_ℝ）
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
    # 【I_ℝ と W_ℝ の正値性】: y^⊤Iy = ΣΣ y_k δ_kl y_l = Σ y_k δ_kk y_k = Σ y_k y_k ≥ 0（y ≠ 0 なら > 0）。y^⊤Wy > 0（y ≠ 0）
    ys = list(U) + [vector(QQ, [QQ.random_element(num_bound=5, den_bound=4) for _ in rng]) for _ in range(4)] + [zero_vector(QQ, d)]
    for y in ys:
        L = [bil(y, I, y),
             sum(sum(y[k] * (1 if k == l else 0) * y[l] for l in rng) for k in rng),
             sum(y[k] * 1 * y[k] for k in rng),
             sum(y[k] * y[k] for k in rng)]
        for s, t in zip(L, L[1:]):
            eq(s, t, f"{what}: 【I_ℝ と W_ℝ の正値性】の I の鎖")
        le(0, L[-1], f"{what}: y^⊤Iy ≥ 0")
        le(0, bil(y, P, y), f"{what}: y^⊤Wy ≥ 0")
        if y != 0:
            le(0, L[-1], f"{what}: y ≠ 0 なら y^⊤Iy > 0", strict=True)
            le(0, bil(y, P, y), f"{what}: y ≠ 0 なら y^⊤Wy > 0", strict=True)
    # 【I_ℝ と W_ℝ の正値性】の後半: I_kl = δ_kl = δ_lk = I_lk、W_kl = (W^⊤)_kl = W_lk（def_real_symmetric_matrix の意味の対称）
    assert is_real_symmetric(I) and is_real_symmetric(P)
    for k in rng:
        for l in rng:
            eq(I[k, l], 1 if k == l else 0, "I_kl = δ_kl"); eq(1 if k == l else 0, 1 if l == k else 0, "δ_kl = δ_lk"); eq(1 if l == k else 0, I[l, k], "δ_lk = I_lk")
            eq(P[k, l], body_transpose(P)[k, l], "W_kl = (W^⊤)_kl"); eq(body_transpose(P)[k, l], P[l, k], "(W^⊤)_kl = W_lk")
    # 【(W_ℝ)^ax は零でない】
    assert x != 0
    eq(norm_exact(zero_vector(QQ, d)), 0, f"{what}: ‖0‖ = 0")
    # u^(0)_l = Σ_m ((W_ℝ)^0)_lm x_m = Σ_m (I_ℝ)_lm x_m = (I_ℝ)_ll x_l = x_l
    for l in rng:
        L = [U[0][l], sum(pw[0][l, mm] * x[mm] for mm in rng), sum(I[l, mm] * x[mm] for mm in rng), I[l, l] * x[l], x[l]]
        for s, t in zip(L, L[1:]):
            eq(s, t, f"{what}: u^(0)_l = x_l の鎖 l={l}")
    # (W_ℝ)^{a+1} = W_ℝ(W_ℝ)^a（ϱ で運ぶ 7 行の鎖は check_varrho_lines）と、u^(a+1)_l = (W_ℝu^(a))_l の 8 行の鎖
    for a in range(K):
        eq(pw[a + 1], body_product(P, pw[a]), f"{what}: (W_ℝ)^(a+1) = W_ℝ(W_ℝ)^a a={a}")
        WPa = body_product(P, pw[a])
        for l in rng:
            L = [U[a + 1][l],
                 sum(pw[a + 1][l, mm] * x[mm] for mm in rng),
                 sum(WPa[l, mm] * x[mm] for mm in rng),
                 sum(sum(P[l, nn] * pw[a][nn, mm] for nn in rng) * x[mm] for mm in rng),
                 sum(P[l, nn] * pw[a][nn, mm] * x[mm] for mm in rng for nn in rng),
                 sum(P[l, nn] * pw[a][nn, mm] * x[mm] for nn in rng for mm in rng),
                 sum(P[l, nn] * sum(pw[a][nn, mm] * x[mm] for mm in rng) for nn in rng),
                 sum(P[l, nn] * U[a][nn] for nn in rng),
                 matvec(P, U[a])[l]]
            for s, t in zip(L, L[1:]):
                eq(s, t, f"{what}: u^(a+1)_l = (W_ℝu^(a))_l の鎖 a={a}, l={l}")
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
    # 【正値性】: m_{2a} = x^⊤(W_ℝ)^{a+a}x = x^⊤(W^a(IW^a))x = (u^(a))^⊤Iu^(a) > 0、m_{2a+1} も同様に W で
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
    # 【P = W_ℝ の不等式】と【P = I_ℝ の不等式】
    for a in range(K + 1):
        for b in range(K + 1):
            if 2 * max(a, b) + 1 <= K:
                L1 = [m[a + b + 1]**2,
                      bil(x, pw[a + b + 1], x)**2,
                      bil(x, body_product(pw[b], body_product(P, pw[a])), x)**2,
                      bil(U[b], P, U[a])**2]
                for s, t in zip(L1, L1[1:]):
                    eq(s, t, f"{what}: 【P = W_ℝ の不等式】の前半 a={a}, b={b}")
                rhs = [bil(U[a], P, U[a]) * bil(U[b], P, U[b]),
                       bil(x, body_product(pw[a], body_product(P, pw[a])), x) * bil(x, body_product(pw[b], body_product(P, pw[b])), x),
                       bil(x, pw[a + a + 1], x) * bil(x, pw[b + b + 1], x),
                       bil(x, pw[2 * a + 1], x) * bil(x, pw[2 * b + 1], x),
                       m[2 * a + 1] * m[2 * b + 1]]
                le(L1[-1], rhs[0], f"{what}: 【P = W_ℝ の不等式】の Cauchy–Schwarz a={a}, b={b}")
                for s, t in zip(rhs, rhs[1:]):
                    eq(s, t, f"{what}: 【P = W_ℝ の不等式】の後半 a={a}, b={b}")
            if 2 * max(a, b) <= K:
                L1 = [m[a + b]**2,
                      bil(x, pw[a + b], x)**2,
                      bil(x, body_product(pw[b], body_product(I, pw[a])), x)**2,
                      bil(U[b], I, U[a])**2]
                for s, t in zip(L1, L1[1:]):
                    eq(s, t, f"{what}: 【P = I_ℝ の不等式】の前半 a={a}, b={b}")
                rhs = [bil(U[a], I, U[a]) * bil(U[b], I, U[b]),
                       bil(x, body_product(pw[a], body_product(I, pw[a])), x) * bil(x, body_product(pw[b], body_product(I, pw[b])), x),
                       bil(x, pw[a + a], x) * bil(x, pw[b + b], x),
                       bil(x, pw[2 * a], x) * bil(x, pw[2 * b], x),
                       m[2 * a] * m[2 * b]]
                le(L1[-1], rhs[0], f"{what}: 【P = I_ℝ の不等式】の Cauchy–Schwarz a={a}, b={b}")
                for s, t in zip(rhs, rhs[1:]):
                    eq(s, t, f"{what}: 【P = I_ℝ の不等式】の後半 a={a}, b={b}")
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


# 2026-11-06: 証明を W_ℝ := ϱ(W)（def_W_real）の冪で書き直した。ここでは複素行列 W（QQbar）と W_ℝ = ϱ(W)（AA）を別々に作り、
# ϱ で運ぶ行を確かめる: 【冪の実数の行列】(W^p)_ℝ = (W_ℝ)^p と I_ℝ = (W_ℝ)^0 = (W^0)_ℝ = ϱ(I)、【冪の対称性】の 6 行の鎖、
# 【冪の分け方】の Mat(d,ℂ) の二つの鎖（3 段・7 段）と ϱ で運ぶ 5 行の鎖（C = I, W）、
# (W_ℝ)^{a+1} = (W^{a+1})_ℝ = (W^{a+0+1})_ℝ = (W^0(WW^a))_ℝ = (I(WW^a))_ℝ = (WW^a)_ℝ = W_ℝ(W^a)_ℝ = W_ℝ(W_ℝ)^a。
# 冪はどちらの側も def_exp (1) の漸化式（X^0 := I、X^{m+1} := X^mX）で組み、積は成分の式で組む。

def iota_rc(r):
    return QQbar(r)


def varrho_rc(B):
    assert all(z.imag() == 0 for z in B.list())                    # def_matrix_with_real_entries
    return matrix(AA, B.nrows(), B.ncols(), lambda p, q: AA(B[p, q].real()))


def power_rec(X, q, ring):
    Y = identity_matrix(ring, X.nrows())
    for _ in range(q):
        Y = body_product(Y, X)
    return Y


def check_varrho_lines(P, K, what):
    d = P.nrows()
    Wc = P.change_ring(QQbar)                                        # W ∈ Mat(d, ℂ)
    WR = varrho_rc(Wc)                                               # W_ℝ := ϱ(W)
    Ic = identity_matrix(QQbar, d)                                   # I = I_{Mat(d,ℂ)}
    IR = identity_matrix(AA, d)                                      # I_ℝ = I_{Mat(d,ℝ)}
    pc = [power_rec(Wc, p, QQbar) for p in range(K + 1)]             # W^p（K = ℂ）
    pr = [power_rec(WR, p, AA) for p in range(K + 1)]                # (W_ℝ)^p（K = ℝ）
    for p in range(K + 1):
        eq(varrho_rc(pc[p]), pr[p], f"{what}: 【冪の実数の行列】 p={p}")
    L = [IR, pr[0], varrho_rc(pc[0]), varrho_rc(Ic)]
    for s, t in zip(L, L[1:]):
        eq(s, t, f"{what}: I_ℝ = (W_ℝ)^0 = (W^0)_ℝ = ϱ(I)")
    for p in range(K + 1):
        T = body_transpose(pc[p])
        eq(T, pc[p], f"{what}: (W^p)^⊤ = W^p p={p}")
        for k in range(d):
            for l in range(d):
                L = [iota_rc(pr[p][k, l]), iota_rc(varrho_rc(pc[p])[k, l]), pc[p][k, l], T[k, l], pc[p][l, k],
                     iota_rc(varrho_rc(pc[p])[l, k]), iota_rc(pr[p][l, k])]
                for s, t in zip(L, L[1:]):
                    eq(s, t, f"{what}: 【冪の対称性】の鎖 p={p}")
                eq(pr[p][k, l], pr[p][l, k], f"{what}: 【冪の対称性】の単射性の結論 p={p}")
    for a in range(K + 1):
        for b in range(K + 1):
            for C, CR, extra, name in [(Ic, IR, 0, "I"), (Wc, WR, 1, "W")]:
                s_ = a + b + extra
                if s_ > K:
                    continue
                if name == "I":
                    L = [pc[a + b], pc[b + a], body_product(pc[b], pc[a]), body_product(pc[b], body_product(Ic, pc[a]))]
                else:
                    L = [pc[a + b + 1],
                         pc[b + (1 + a)],
                         body_product(pc[b], pc[1 + a]),
                         body_product(pc[b], body_product(pc[1], pc[a])),
                         body_product(pc[b], body_product(pc[0 + 1], pc[a])),
                         body_product(pc[b], body_product(body_product(pc[0], Wc), pc[a])),
                         body_product(pc[b], body_product(body_product(Ic, Wc), pc[a])),
                         body_product(pc[b], body_product(Wc, pc[a]))]
                for s, t in zip(L, L[1:]):
                    eq(s, t, f"{what}: 【冪の分け方】の Mat(d,ℂ) の鎖 C={name}, a={a}, b={b}")
                CWa = body_product(C, pc[a])
                eq(varrho_rc(CWa), body_product(CR, varrho_rc(pc[a])), f"{what}: (CW^a)_ℝ = C_ℝ(W^a)_ℝ C={name}")
                M = [pr[s_], varrho_rc(pc[s_]), varrho_rc(body_product(pc[b], CWa)),
                     body_product(varrho_rc(pc[b]), varrho_rc(CWa)),
                     body_product(varrho_rc(pc[b]), body_product(CR, varrho_rc(pc[a]))),
                     body_product(pr[b], body_product(CR, pr[a]))]
                for s, t in zip(M, M[1:]):
                    eq(s, t, f"{what}: 【冪の分け方】の ϱ で運ぶ鎖 C={name}, a={a}, b={b}")
    for a in range(K):
        WWa = body_product(Wc, pc[a])
        M = [pr[a + 1], varrho_rc(pc[a + 1]), varrho_rc(pc[a + 0 + 1]), varrho_rc(body_product(pc[0], WWa)),
             varrho_rc(body_product(Ic, WWa)), varrho_rc(WWa), body_product(WR, varrho_rc(pc[a])), body_product(WR, pr[a])]
        for s, t in zip(M, M[1:]):
            eq(s, t, f"{what}: (W_ℝ)^(a+1) = W_ℝ(W_ℝ)^a の ϱ の鎖 a={a}")
