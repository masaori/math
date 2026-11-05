# 対象ラベル: trace_power_sandwich
# 証明の各段（【W^n の成分の対称性】【W^n の半正定値性】【W^n の成分の評価】【単位ベクトルでの評価】【正の実数の冪の比較】
# 【上限への移行】）を一行ずつ確かめる関数。P は QQ の実対称正定値行列（本文では P = W）、x は ‖x‖ = 1 の QQ^d の元。
# 等号・不等号は QQ と AA の厳密な比較である。

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


def chain_eq(L, what):
    for i, (s, t) in enumerate(zip(L, L[1:])):
        eq(s, t, f"{what} {i + 1}→{i + 2} 行目")


def check_symmetry(Pn, what):
    """【W^n の成分の対称性】(W^n)_lk = ((W^n)^⊤)_kl = (W^n)_kl。成分は QQ。"""
    assert Pn.base_ring() == QQ
    T = body_transpose(Pn)
    d = Pn.nrows()
    for k in range(d):
        for l in range(d):
            chain_eq([Pn[l, k], T[k, l], Pn[k, l]], f"{what}: 【W^n の成分の対称性】 k={k}, l={l}")


def check_psd(P, Pn, n, z, what):
    """【W^n の半正定値性】を z ∈ QQ^d で確かめる。z ≠ 0 の段は ‖z‖ = √s（AA）を使う。"""
    d = Pn.nrows()
    rng = range(d)
    if z == 0:
        eq(bil(z, Pn, z), 0, f"{what}: z = 0 なら z^⊤W^nz = 0")
        for i in rng:
            for j in rng:
                eq(z[i] * Pn[i, j] * z[j], 0, f"{what}: z = 0 の各項")
        return
    j0 = next(j for j in rng if z[j] != 0)
    nz = norm_exact(z)
    L = [nz**2, sum(abs(AA(z[j]))**2 for j in rng)]
    chain_eq(L, f"{what}: ‖z‖^2 = Σ|z_j|^2")
    le(abs(AA(z[j0]))**2, L[-1], f"{what}: Σ|z_j|^2 ≥ |z_j0|^2")
    le(0, abs(AA(z[j0]))**2, f"{what}: |z_j0|^2 > 0", strict=True)
    le(0, nz, f"{what}: ‖z‖ > 0", strict=True)
    w = vector(AA, [nz**-1 * z[i] for i in rng])
    for i in rng:
        chain_eq([AA(z[i]), nz * (nz**-1 * z[i]), nz * w[i]], f"{what}: z_i = ‖z‖w_i")
    s1 = sum(abs(w[i])**2 for i in rng)
    s2 = sum((nz**-1 * z[i])**2 for i in rng)
    s3 = sum((nz**-1)**2 * AA(z[i])**2 for i in rng)
    s4 = (nz**-1)**2 * sum(AA(z[i])**2 for i in rng)
    s5 = (nz**-1)**2 * sum(abs(AA(z[i]))**2 for i in rng)
    s6 = (nz**-1)**2 * nz**2
    s7 = (nz**-1 * nz)**2
    L = [norm_exact(w), s1.sqrt(), s2.sqrt(), s3.sqrt(), s4.sqrt(), s5.sqrt(), s6.sqrt(), s7.sqrt(), AA(1).sqrt(), AA(1)]
    chain_eq(L, f"{what}: ‖w‖ の鎖")
    PnA = Pn.change_ring(AA)
    L = [bil(z, Pn, z),
         sum(sum(z[i] * Pn[i, j] * z[j] for j in rng) for i in rng),
         sum(sum((nz * w[i]) * PnA[i, j] * (nz * w[j]) for j in rng) for i in rng),
         nz**2 * sum(sum(w[i] * PnA[i, j] * w[j] for j in rng) for i in rng),
         nz**2 * bil(w, PnA, w)]
    chain_eq(L, f"{what}: z^⊤W^nz の鎖")
    # moment_log_convexity の正値性（x → w、k → n）。w は AA の単位ベクトルなので、その主張の値を直接比べる
    le(0, bil(w, PnA, w), f"{what}: w^⊤W^nw > 0", strict=True)
    le(0, L[-1], f"{what}: z^⊤W^nz > 0", strict=True)


def check_entry_bound(Pn, x, k, l, what):
    """【W^n の成分の評価】v_i := x_l(e_k)_i − x_k(e_l)_i の 7 行と、移項した不等式。"""
    d = Pn.nrows()
    rng = range(d)
    def e(p):
        """(e_p)_i := 1（i = p）、0（i ≠ p）の実数の組。"""
        return vector(QQ, [1 if i == p else 0 for i in rng])
    ek, el = e(k), e(l)
    v = vector(x.base_ring(), [x[l] * ek[i] - x[k] * el[i] for i in rng])
    L = [bil(v, Pn, v),
         sum(sum(v[i] * Pn[i, j] * v[j] for j in rng) for i in rng),
         sum(sum((x[l] * ek[i] - x[k] * el[i]) * Pn[i, j] * (x[l] * ek[j] - x[k] * el[j]) for j in rng) for i in rng),
         x[l]**2 * sum(sum(ek[i] * Pn[i, j] * ek[j] for j in rng) for i in rng)
         - x[l] * x[k] * sum(sum(ek[i] * Pn[i, j] * el[j] for j in rng) for i in rng)
         - x[k] * x[l] * sum(sum(el[i] * Pn[i, j] * ek[j] for j in rng) for i in rng)
         + x[k]**2 * sum(sum(el[i] * Pn[i, j] * el[j] for j in rng) for i in rng),
         x[l]**2 * Pn[k, k] - x[l] * x[k] * Pn[k, l] - x[k] * x[l] * Pn[l, k] + x[k]**2 * Pn[l, l],
         x[l]**2 * Pn[k, k] - x[l] * x[k] * Pn[k, l] - x[k] * x[l] * Pn[k, l] + x[k]**2 * Pn[l, l],
         x[l]**2 * Pn[k, k] - 2 * x[k] * Pn[k, l] * x[l] + x[k]**2 * Pn[l, l]]
    le(0, L[0], f"{what}: 0 ≤ v^⊤W^nv k={k}, l={l}")
    chain_eq(L, f"{what}: 【W^n の成分の評価】 k={k}, l={l}")
    le(2 * x[k] * Pn[k, l] * x[l], x[l]**2 * Pn[k, k] + x[k]**2 * Pn[l, l], f"{what}: 移項した不等式 k={k}, l={l}")


def check_unit_vector_bound(P, x, nmax, what):
    """【単位ベクトルでの評価】の全ての鎖を n = 1..nmax で。x ∈ QQ^d、‖x‖ = 1。"""
    d = P.nrows()
    rng = range(d)
    I = body_identity(QQ, d)
    pw = [power_by_def_exp(P, p) for p in range(nmax + 2)]
    m = [bil(x, pw[k], x) for k in range(nmax + 2)]
    eq(norm_exact(x), 1, f"{what}: ‖x‖ = 1")
    for k in range(nmax + 2):
        eq(pw[k], P**k, f"{what}: def_exp (1) の冪 k={k}")
        le(0, m[k], f"{what}: moment_log_convexity の m_k > 0 k={k}", strict=True)
        if k >= 1 and k + 1 <= nmax + 1:
            le(m[k]**2, m[k - 1] * m[k + 1], f"{what}: moment_log_convexity の対数凸性 k={k}")
    # Σ x_kx_k = Σ|x_k|^2 = ‖x‖^2 = 1
    chain_eq([sum(x[k]**2 for k in rng), sum(abs(AA(x[k]))**2 for k in rng), norm_exact(x)**2, AA(1)], f"{what}: Σx_k^2 の鎖")
    # m_0 の鎖
    chain_eq([m[0], bil(x, pw[0], x), bil(x, I, x),
              sum(sum(x[k] * kd(k, l) * x[l] for l in rng) for k in rng),
              sum(x[k] * kd(k, k) * x[k] for k in rng),
              sum(x[k] * x[k] for k in rng), sum(x[k]**2 for k in rng), 1], f"{what}: m_0 の鎖")
    # m_1 の鎖
    chain_eq([m[1], bil(x, pw[1], x), bil(x, pw[0 + 1], x), bil(x, body_product(pw[0], P), x),
              bil(x, body_product(I, P), x), bil(x, P, x)], f"{what}: m_1 の鎖")
    # m_k ≥ m_1m_{k−1}（k = 1 と帰納の段 k → k+1）
    chain_eq([m[1], m[1] * 1, m[1] * m[0]], f"{what}: k = 1 の段")
    for k in range(1, nmax):
        le(m[1] * m[k - 1], m[k], f"{what}: 帰納法の仮定 k={k}")
        le(m[1] * m[k - 1] / m[k - 1], m[k] / m[k - 1], f"{what}: 商の鎖 1 行目 k={k}")
        eq(m[1] * m[k - 1] / m[k - 1], m[1], f"{what}: 商の鎖 2 行目 k={k}")
        L = [m[k + 1], m[k - 1] * m[k + 1] / m[k - 1], m[k]**2 / m[k - 1], m[k] * (m[k] / m[k - 1]), m[k] * m[1], m[1] * m[(k + 1) - 1]]
        eq(L[0], L[1], f"{what}: 比の鎖 1→2 k={k}")
        le(L[2], L[1], f"{what}: 比の鎖 2→3 k={k}")
        eq(L[2], L[3], f"{what}: 比の鎖 3→4 k={k}")
        le(L[4], L[3], f"{what}: 比の鎖 4→5 k={k}")
        eq(L[4], L[5], f"{what}: 比の鎖 5→6 k={k}")
    # m_p ≥ m_1^p
    chain_eq([m[0], 1, m[1]**0], f"{what}: p = 0 の段")
    for p in range(0, nmax):
        L = [m[p + 1], m[1] * m[(p + 1) - 1], m[1] * m[p], m[1] * m[1]**p, m[1]**(p + 1)]
        le(L[1], L[0], f"{what}: 冪の鎖 1→2 p={p}")
        eq(L[1], L[2], f"{what}: 冪の鎖 2→3 p={p}")
        le(L[3], L[2], f"{what}: 冪の鎖 3→4 p={p}")
        eq(L[3], L[4], f"{what}: 冪の鎖 4→5 p={p}")
    # m_n ≤ tr(W^n) の鎖と、(x^⊤Wx)^n ≤ m_n ≤ tr(W^n)
    for n in range(1, nmax + 1):
        A = pw[n]
        L = [m[n],
             sum(sum(x[k] * A[k, l] * x[l] for l in rng) for k in rng),
             QQ(1) / 2 * sum(sum(2 * x[k] * A[k, l] * x[l] for l in rng) for k in rng),
             QQ(1) / 2 * sum(sum(x[l]**2 * A[k, k] + x[k]**2 * A[l, l] for l in rng) for k in rng),
             QQ(1) / 2 * (sum(sum(x[l]**2 * A[k, k] for l in rng) for k in rng) + sum(sum(x[k]**2 * A[l, l] for l in rng) for k in rng)),
             QQ(1) / 2 * (sum(A[k, k] * sum(x[l]**2 for l in rng) for k in rng) + sum(x[k]**2 * sum(A[l, l] for l in rng) for k in rng)),
             QQ(1) / 2 * (sum(A[k, k] for k in rng) * sum(x[l]**2 for l in rng) + sum(x[k]**2 for k in rng) * sum(A[l, l] for l in rng)),
             QQ(1) / 2 * (A.trace() * 1 + 1 * A.trace()),
             A.trace()]
        eq(L[0], L[1], f"{what}: m_n の鎖 1→2 n={n}")
        eq(L[1], L[2], f"{what}: m_n の鎖 2→3 n={n}")
        le(L[2], L[3], f"{what}: m_n の鎖 3→4 n={n}")
        for i in range(3, len(L) - 1):
            eq(L[i], L[i + 1], f"{what}: m_n の鎖 {i + 1}→{i + 2} n={n}")
        eq(sum(A[k, k] for k in rng), A.trace(), f"{what}: def_trace n={n}")
        L2 = [bil(x, P, x)**n, m[1]**n, m[n], A.trace()]
        eq(L2[0], L2[1], f"{what}: 合わせた鎖 1→2 n={n}")
        le(L2[1], L2[2], f"{what}: 合わせた鎖 2→3 n={n}")
        le(L2[2], L2[3], f"{what}: 合わせた鎖 3→4 n={n}")


def check_power_comparison(r, s, pmax, what):
    """【正の実数の冪の比較】(a)(b) の p = 1 と帰納の段の各行を、0 < r < s の r, s で確かめる。"""
    assert 0 < r < s
    eq(r**1, r**0 * r, f"{what}: r^1 = r^0r"); eq(r**0 * r, r, f"{what}: r^0r = r"); eq(s**1, s, f"{what}: s^1 = s")
    eq(s - r, 1 * s**0 * (s - r), f"{what}: (b) の p = 1")
    for p in range(1, pmax + 1):
        le(0, r**p, f"{what}: (a) 0 < r^p p={p}", strict=True)
        le(r**p, s**p, f"{what}: (a) r^p < s^p p={p}", strict=True)
        le(s**p - r**p, p * s**(p - 1) * (s - r), f"{what}: (b) p={p}")
        L = [r**(p + 1), r**p * r, s**p * r, s**p * s, s**(p + 1)]
        eq(L[0], L[1], f"{what}: (a) の鎖 1→2 p={p}")
        le(L[1], L[2], f"{what}: (a) の鎖 2→3 p={p}", strict=True)
        le(L[2], L[3], f"{what}: (a) の鎖 3→4 p={p}", strict=True)
        eq(L[3], L[4], f"{what}: (a) の鎖 4→5 p={p}")
        le(0, r**p * r, f"{what}: r^{{p+1}} > 0 p={p}", strict=True)
        L = [s**(p + 1) - r**(p + 1),
             s * (s**p - r**p) + r**p * (s - r),
             s * (p * s**(p - 1) * (s - r)) + r**p * (s - r),
             s * (p * s**(p - 1) * (s - r)) + s**p * (s - r),
             p * s**p * (s - r) + s**p * (s - r),
             (p + 1) * s**((p + 1) - 1) * (s - r)]
        eq(L[0], L[1], f"{what}: (b) の鎖 1→2 p={p}")
        le(L[1], L[2], f"{what}: (b) の鎖 2→3 p={p}")
        le(L[2], L[3], f"{what}: (b) の鎖 3→4 p={p}")
        eq(L[3], L[4], f"{what}: (b) の鎖 4→5 p={p}")
        eq(L[4], L[5], f"{what}: (b) の鎖 5→6 p={p}")
        eq(s * s**(p - 1), s**(p - 1) * s, f"{what}: ss^{{p−1}} = s^{{p−1}}s"); eq(s**(p - 1) * s, s**p, f"{what}: s^{{p−1}}s = s^p")


def check_sup_step(c, T, n, t, what):
    """【上限への移行】の背理法の鎖を、仮定 c^n > T > 0 を満たす (c, T) と、r < t ≤ c の t（R の元の代わり）で確かめる。
    T ≥ t^n の行は仮定の下での行なので、ここでは「r^n ≥ T かつ t^n > r^n」すなわち t^n > T を示し、T ≥ t^n と両立しないことを確かめる。"""
    assert c > 0 and T > 0 and c**n > T and n >= 1
    delta = (c**n - T) * (n * c**(n - 1))**-1
    r = c - delta
    le(0, delta, f"{what}: δ > 0", strict=True)
    le(r, c, f"{what}: r < c", strict=True)
    cn1 = c**(n - 1)
    le(0, cn1, f"{what}: c^{{n−1}} > 0", strict=True)
    if n >= 2:
        le(c**(n - 1), (c + 1)**(n - 1), f"{what}: (a) を r → c, s → c+1 に当てた c^{{n−1}} < (c+1)^{{n−1}}", strict=True)
    L = [delta, (c**n - T) * (n * cn1)**-1, c**n * (n * cn1)**-1, cn1 * c * (n * cn1)**-1,
         cn1 * c * (QQ(n)**-1 * cn1**-1), c * QQ(n)**-1 * (cn1 * cn1**-1), c * QQ(n)**-1, c]
    eq(L[0], L[1], f"{what}: δ の鎖 1→2")
    le(L[1], L[2], f"{what}: δ の鎖 2→3", strict=True)
    for i in range(2, 6):
        eq(L[i], L[i + 1], f"{what}: δ の鎖 {i + 1}→{i + 2}")
    le(L[6], L[7], f"{what}: δ の鎖 7→8")
    le(0, r, f"{what}: r > 0", strict=True)
    assert r < t <= c
    L = [t**n, r**n, c**n - n * c**(n - 1) * (c - r), c**n - n * c**(n - 1) * delta, c**n - (c**n - T), T]
    le(L[1], L[0], f"{what}: t^n > r^n", strict=True)
    le(L[2], L[1], f"{what}: r^n ≥ c^n − nc^{{n−1}}(c − r)")
    for i in range(2, 5):
        eq(L[i], L[i + 1], f"{what}: 背理法の鎖 {i + 1}→{i + 2}")
    le(T, t**n, f"{what}: t^n > T（仮定の下の T ≥ t^n と両立しない）", strict=True)
