# 対象ラベル: trace_power_upper_bound
# 証明の四つの準備、偶数の場合の鎖、奇数の場合の W^{2a+1} = W^a(WW^a) の鎖と成分の鎖、最後のトレースの鎖を、
# 実対称で半正定値な P（本文では P = W）・その上限 c = c(M_col) について一行ずつ確かめる。
# 等号は QQ と AA の厳密な等号、不等号は AA の厳密な比較である。

load("../../_shared/inclusion_zz_to_rr_by_definition.sage")

n_eq = 0
n_le = 0


def eq(a, b, what):
    global n_eq
    assert a == b, what
    n_eq += 1


def le(a, b, what):
    global n_le
    assert a <= b, what
    n_le += 1


def check_proof_lines(P, c, nmax, what):
    """P は QQ の実対称で半正定値、c は rayleigh_sup_exact(P)、nmax は主張を確かめる最大の n。"""
    d = P.nrows()
    R = P.base_ring()
    I = body_identity(R, d)
    E = [vector(QQ, [1 if i == k else 0 for i in range(d)]) for k in range(d)]   # e_k ∈ ℝ^d
    le(0, c, f"{what}: c ≥ 0")
    # 【e_k のノルム】: ‖e_k‖ = √(Σ_i |(e_k)_i|^2) = √(|(e_k)_k|^2) = √(|1|^2) = √(1^2) = √1 = 1
    for k in range(d):
        l1 = norm_exact(E[k])
        l2 = AA(sum(abs(E[k][i])**2 for i in range(d))).sqrt()
        l2b = AA(abs(E[k][k])**2).sqrt()
        l2c = AA(abs(QQ(1))**2).sqrt()
        l2d = AA(QQ(1)**2).sqrt()
        l3 = AA(1).sqrt()
        eq(l1, l2, f"{what}: 【e_k のノルム】の 1 行目 k={k}")
        eq(sum(abs(E[k][i])**2 for i in range(d)), 1, f"{what}: 【e_k のノルム】の 根号の中が 1 k={k}")
        eq(l2, l2b, f"{what}: 【e_k のノルム】の 2 行目（i ≠ k の項を落とす）k={k}")
        eq(l2b, l2c, f"{what}: 【e_k のノルム】の 3 行目（(e_k)_k = 1）k={k}")
        eq(QQ(1) if QQ(1) >= 0 else -QQ(1), 1, f"{what}: 【e_k のノルム】の 4 行目の根拠 |1| = 1（def_real_absolute_value の 1 ≥ 0 の場合）")
        eq(l2c, l2d, f"{what}: 【e_k のノルム】の 4 行目（|1| = 1）k={k}")
        eq(QQ(1)**2, 1, f"{what}: 【e_k のノルム】の 5 行目の根拠 1^2 = 1")
        eq(l2d, l3, f"{what}: 【e_k のノルム】の 5 行目（1^2 = 1）k={k}")
        eq(l3, 1, f"{what}: 【e_k のノルム】の 6 行目 k={k}")
    # 【冪の実対称性】: W^p は実対称（成分は QQ、(W^p)_kl = (W^p)_lk）
    pw = [power_by_def_exp(P, p) for p in range(nmax + 1)]
    for p in range(nmax + 1):
        eq(pw[p], P**p, f"{what}: def_exp (1) の冪と Sage の冪 p={p}")
        assert pw[p].base_ring() == QQ
        eq(body_transpose(pw[p]), pw[p], f"{what}: 【冪の実対称性】の (W^p)^⊤ = W^p p={p}")
        for k in range(d):
            for l in range(d):
                eq(pw[p][k, l], body_transpose(pw[p])[k, l], f"{what}: 【冪の実対称性】の鎖 1 行目")
                eq(body_transpose(pw[p])[k, l], pw[p][l, k], f"{what}: 【冪の実対称性】の鎖 2 行目")
    # 【対角成分の表示】: e_k^⊤W^pe_k = ΣΣ (e_k)_i (W^p)_ij (e_k)_j = Σ_j (e_k)_k (W^p)_kj (e_k)_j = Σ_j (W^p)_kj (e_k)_j = (W^p)_kk
    for p in range(nmax + 1):
        Q = pw[p]
        for k in range(d):
            e = E[k]
            L = [bil(e, Q, e),
                 sum(sum(e[i] * Q[i, j] * e[j] for j in range(d)) for i in range(d)),
                 sum(e[k] * Q[k, j] * e[j] for j in range(d)),
                 sum(Q[k, j] * e[j] for j in range(d)),
                 Q[k, k] * e[k],
                 Q[k, k]]
            for a, b in zip(L, L[1:]):
                eq(a, b, f"{what}: 【対角成分の表示】 p={p}, k={k}")
            eq(L[0], (e.row() * Q * e.column())[0, 0], f"{what}: 【対角成分の表示】 と組み込みの行列積 p={p}, k={k}")
            for i in range(d):
                if i != k:
                    eq(e[i], 0, f"{what}: 【対角成分の表示】の i ≠ k の項は 0")
    # 【W^ae_k の成分とノルム】: u := W^ae_k、u_l = Σ_m (W^a)_lm (e_k)_m = (W^a)_lk、‖u‖ ≤ c^a‖e_k‖ = c^a、‖u‖^2 ≤ c^{2a}
    U = {}
    for a in range(nmax // 2 + 1):
        for k in range(d):
            u = matvec(pw[a], E[k])
            eq(u, pw[a] * E[k], f"{what}: u の成分の式と組み込みの積 a={a}, k={k}")
            for l in range(d):
                eq(u[l], sum(pw[a][l, m] * E[k][m] for m in range(d)), f"{what}: 【W^ae_k の成分とノルム】の 1 行目")
                eq(sum(pw[a][l, m] * E[k][m] for m in range(d)), pw[a][l, k] * E[k][k], f"{what}: 【W^ae_k の成分とノルム】の 2 行目")
                eq(pw[a][l, k] * E[k][k], pw[a][l, k], f"{what}: 【W^ae_k の成分とノルム】の 3 行目")
                eq(u[l], pw[a][l, k], f"{what}: u_l = (W^a)_lk")
            nu = norm_exact(u)
            le(nu, c**a * norm_exact(E[k]), f"{what}: 【W^ae_k の成分とノルム】の ‖u‖ ≤ c^a‖e_k‖ a={a}, k={k}")
            eq(c**a * norm_exact(E[k]), c**a, f"{what}: 【W^ae_k の成分とノルム】の c^a‖e_k‖ = c^a")
            le(0, nu, f"{what}: 【W^ae_k の成分とノルム】の 0 ≤ ‖u‖")
            eq((c**a)**2, c**(2 * a), f"{what}: 【W^ae_k の成分とノルム】の (c^a)^2 = c^{{2a}}")
            le(nu**2, (c**a)**2, f"{what}: 【W^ae_k の成分とノルム】の ‖u‖^2 ≤ c^{{2a}} a={a}, k={k}")
            U[(a, k)] = u
    # 偶数の場合 n = 2a（a ≥ 1）
    for n in range(2, nmax + 1, 2):
        a = n // 2
        WaWa = body_product(pw[a], pw[a])
        eq(pw[2 * a], WaWa, f"{what}: matrix_power_exponent_law (p, q → a)")
        for k in range(d):
            u = U[(a, k)]
            L = [bil(E[k], pw[2 * a], E[k]),
                 pw[2 * a][k, k],
                 pw[a + a][k, k],
                 WaWa[k, k],
                 sum(pw[a][k, l] * pw[a][l, k] for l in range(d)),
                 sum(pw[a][l, k] * pw[a][l, k] for l in range(d)),
                 sum(u[l] * u[l] for l in range(d)),
                 sum(abs(u[l])**2 for l in range(d)),
                 norm_exact(u)**2]
            for x, y in zip(L, L[1:]):
                eq(x, y, f"{what}: 偶数の鎖 n={n}, k={k}")
            le(L[-1], c**(2 * a), f"{what}: 偶数の鎖の不等号 n={n}, k={k}")
            eq(c**(2 * a), c**n, f"{what}: 偶数の鎖の最後 n={n}")
    # 奇数の場合 n = 2a+1（a ≥ 0）
    for n in range(1, nmax + 1, 2):
        a = (n - 1) // 2
        # W^{2a+1} = W^{a+(1+a)} = W^aW^{1+a} = W^a(W^1W^a) = W^a((W^0W)W^a) = W^a((IW)W^a) = W^a(WW^a)
        M = [pw[2 * a + 1],
             pw[a + (1 + a)],
             body_product(pw[a], pw[1 + a]),
             body_product(pw[a], body_product(pw[1], pw[a])),
             body_product(pw[a], body_product(pw[0 + 1], pw[a])),
             body_product(pw[a], body_product(body_product(pw[0], P), pw[a])),
             body_product(pw[a], body_product(body_product(I, P), pw[a])),
             body_product(pw[a], body_product(P, pw[a]))]
        for x, y in zip(M, M[1:]):
            eq(x, y, f"{what}: W^{{2a+1}} の鎖 n={n}")
        WWa = body_product(P, pw[a])
        for k in range(d):
            u = U[(a, k)]
            L = [bil(E[k], pw[2 * a + 1], E[k]),
                 pw[2 * a + 1][k, k],
                 M[-1][k, k],
                 sum(pw[a][k, l] * WWa[l, k] for l in range(d)),
                 sum(pw[a][k, l] * sum(P[l, m] * pw[a][m, k] for m in range(d)) for l in range(d)),
                 sum(sum(pw[a][k, l] * P[l, m] * pw[a][m, k] for m in range(d)) for l in range(d)),
                 sum(sum(pw[a][l, k] * P[l, m] * pw[a][m, k] for m in range(d)) for l in range(d)),
                 sum(sum(u[l] * P[l, m] * u[m] for m in range(d)) for l in range(d)),
                 bil(u, P, u)]
            for x, y in zip(L, L[1:]):
                eq(x, y, f"{what}: 奇数の鎖の等号 n={n}, k={k}")
            nu2 = norm_exact(u)**2
            le(L[-1], c * nu2, f"{what}: 奇数の鎖 u^⊤Wu ≤ c‖u‖^2 n={n}, k={k}")
            le(c * nu2, c * c**(2 * a), f"{what}: 奇数の鎖 c‖u‖^2 ≤ c·c^{{2a}} n={n}, k={k}")
            eq(c * c**(2 * a), c**(2 * a + 1), f"{what}: 奇数の鎖 c·c^{{2a}} = c^{{2a+1}}")
            eq(c**(2 * a + 1), c**n, f"{what}: 奇数の鎖の最後 n={n}")
    # 最後のトレースの鎖
    for n in range(1, nmax + 1):
        Q = pw[n]
        L = [Q.trace(),                                     # Sage の trace（別の経路）
             sum(Q[k, k] for k in range(d)),                # def_trace
             sum(bil(E[k], Q, E[k]) for k in range(d))]     # 【対角成分の表示】
        for x, y in zip(L, L[1:]):
            eq(x, y, f"{what}: トレースの鎖の等号 n={n}")
        for k in range(d):
            le(bil(E[k], Q, E[k]), c**n, f"{what}: 各 k の e_k^⊤W^ne_k ≤ c^n n={n}, k={k}")
        le(L[-1], sum(c**n for k in range(d)), f"{what}: トレースの鎖の不等号 n={n}")
        # Σ_{k=1}^{d} c^n = ι_{ℤ→ℝ}(d) c^n（finite_sum_of_constant_real_number。和と ι は定義の再帰）
        eq(finite_sum_by_definition([c**n] * d), iota_zz_to_rr(d) * c**n, f"{what}: Σ c^n = ι(d) c^n")
        eq(sum(c**n for k in range(d)), d * c**n, f"{what}: Σ c^n = d c^n（組み込みの整数倍）")
        le((P**n).trace(), d * c**n, f"{what}: 主張 tr(W^n) ≤ d c^n n={n}")


def check_power_of_two_lines(d, M, c, nmax, what):
    """最後の鎖の後の 2 行: ι(d) c^n = ι(2^{M_col}) c^n = 2_ℝ^{M_col} c^n（d := 2^{M_col} ∈ ℤ_{≥1}、inclusion_zz_to_rr_of_power_of_two）。"""
    t = power_of_integer_by_definition(ZZ(1) + ZZ(1), M)   # 2_ℤ^{M_col}（def_power_of_integer の再帰）
    assert d == t and t >= 1                               # d := 2_ℤ^{M_col} ∈ ℤ_{≥1}
    two = QQ(1) + QQ(1)                                    # 2_ℝ := 1_ℝ + 1_ℝ
    for n in range(1, nmax + 1):
        eq(iota_zz_to_rr(d) * c**n, iota_zz_to_rr(t) * c**n, f"{what}: ι(d) c^n = ι(2^M) c^n n={n}")
        eq(iota_zz_to_rr(t) * c**n, power_of_real_by_definition(two, M) * c**n, f"{what}: ι(2^M) c^n = 2_ℝ^M c^n n={n}")


# 2026-11-06: 証明を W_ℝ := ϱ(W)（def_W_real）の冪で書き直した。上の check_proof_lines は P を W_ℝ（QQ の実数の行列）として
# 実数の側の行を確かめる。ここでは複素行列 W（QQbar）と W_ℝ = ϱ(W)（AA）を別々に作り、ϱ で運ぶ行を確かめる:
# 【冪の実数の行列】(W^p)_ℝ = (W_ℝ)^p、【冪の対称性】の 6 行の鎖、
# (W_ℝ)^{2a} = (W^{2a})_ℝ = (W^{a+a})_ℝ = (W^aW^a)_ℝ = (W^a)_ℝ(W^a)_ℝ = (W_ℝ)^a(W_ℝ)^a、
# (WW^a)_ℝ = W_ℝ(W^a)_ℝ と (W_ℝ)^{2a+1} = (W^{2a+1})_ℝ = (W^a(WW^a))_ℝ = (W^a)_ℝ(WW^a)_ℝ = (W^a)_ℝ(W_ℝ(W^a)_ℝ) = (W_ℝ)^a(W_ℝ(W_ℝ)^a)。
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


def check_varrho_lines(P, nmax, what):
    d = P.nrows()
    Wc = P.change_ring(QQbar)                                        # W ∈ Mat(d, ℂ)
    WR = varrho_rc(Wc)                                               # W_ℝ := ϱ(W)
    pc = [power_rec(Wc, p, QQbar) for p in range(nmax + 1)]          # W^p（K = ℂ）
    pr = [power_rec(WR, p, AA) for p in range(nmax + 1)]             # (W_ℝ)^p（K = ℝ）
    for p in range(nmax + 1):
        eq(varrho_rc(pc[p]), pr[p], f"{what}: 【冪の実数の行列】 p={p}")
        T = body_transpose(pc[p])
        eq(T, pc[p], f"{what}: (W^p)^⊤ = W^p p={p}")
        for k in range(d):
            for l in range(d):
                L = [iota_rc(pr[p][k, l]), iota_rc(varrho_rc(pc[p])[k, l]), pc[p][k, l], T[k, l], pc[p][l, k],
                     iota_rc(varrho_rc(pc[p])[l, k]), iota_rc(pr[p][l, k])]
                for x, y in zip(L, L[1:]):
                    eq(x, y, f"{what}: 【冪の対称性】の鎖 p={p}")
                eq(pr[p][k, l], pr[p][l, k], f"{what}: 【冪の対称性】の単射性の結論 p={p}")
    for n in range(2, nmax + 1, 2):
        a = n // 2
        M = [pr[2 * a], varrho_rc(pc[2 * a]), varrho_rc(pc[a + a]), varrho_rc(body_product(pc[a], pc[a])),
             body_product(varrho_rc(pc[a]), varrho_rc(pc[a])), body_product(pr[a], pr[a])]
        for x, y in zip(M, M[1:]):
            eq(x, y, f"{what}: 偶数の ϱ の鎖 n={n}")
    for n in range(1, nmax + 1, 2):
        a = (n - 1) // 2
        WWa = body_product(Wc, pc[a])
        eq(varrho_rc(WWa), body_product(WR, varrho_rc(pc[a])), f"{what}: (WW^a)_ℝ = W_ℝ(W^a)_ℝ n={n}")
        M = [pr[2 * a + 1], varrho_rc(pc[2 * a + 1]), varrho_rc(body_product(pc[a], WWa)),
             body_product(varrho_rc(pc[a]), varrho_rc(WWa)),
             body_product(varrho_rc(pc[a]), body_product(WR, varrho_rc(pc[a]))),
             body_product(pr[a], body_product(WR, pr[a]))]
        for x, y in zip(M, M[1:]):
            eq(x, y, f"{what}: 奇数の ϱ の鎖 n={n}")
    # 主張の注記: tr(W^n) = (Σ_k ((W_ℝ)^n)_kk)_ℂ（trace_of_W_power_via_W_real）
    for n in range(1, nmax + 1):
        eq(sum(pc[n][k, k] for k in range(d)), iota_rc(sum(pr[n][k, k] for k in range(d))), f"{what}: tr(W^n) = (Σ((W_ℝ)^n)_kk)_ℂ n={n}")
