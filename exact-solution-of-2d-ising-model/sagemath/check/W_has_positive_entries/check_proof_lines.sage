# 対象ラベル: W_has_positive_entries
# 証明の準備・Step 1・Step 2・Step 3 の各行と主張を厳密計算で確かめる。
#
# 二つの計算の帰属で同じ行を確かめる。
#  (A) 一般の結合定数: Y := exp((1/2)K_1)、X2 := exp(K_2) を Laurent 多項式環 R := QQ[Y^{±1}, X2^{±1}] の不定元に置く。
#      d(μ)・e(μ,μ') は整数なので b(μ) = exp((1/2)K_1 d(μ)) = Y^{d(μ)}、v(μ,μ') = exp(K_2 e(μ,μ')) = X2^{e(μ,μ')} は R の単項式である
#      （実数の exp の指数法則 exp(nt) = exp(t)^n を、肩が整数倍のときにだけ使う）。K_1・K_2 の値に依らない形で行の等号を確かめる。
#  (B) 具体の結合定数: K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3, 3/2}）で Y = y、X2 = x とし、全て QQ で確かめる。
#      B = exp(X) は本文の対角成分の公式（exp_of_diagonal_matrix）を使わず、D の固有値の射影から作る（独立な経路）。
# ℝ への脱出は K_1・K_2 の実数の exp の値を不定元（または有理数）に置く一点だけで、以後の等号・不等号は全て R・QQ の厳密計算である。
# 浮動小数点は使わない。
load("../../_shared/row_configurations.sage")

n_eq = 0
n_ineq = 0
n_neg = 0


def eq(a, b, what):
    global n_eq
    assert a == b, what
    n_eq += 1


def pos(a, what):
    global n_ineq
    assert a > 0, what
    n_ineq += 1


def neq(a, b, what):
    global n_neg
    assert a != b, what
    n_neg += 1


def m_plus(m, M):
    """証明の準備の m^+（m ≤ M−1 なら m+1、m = M なら 1）。"""
    return m + 1 if m <= M - 1 else 1


def sigma_z_periodic(M, k):
    """def_site_pauli_periodic_extension: σ_{M+1}^z := σ_1^z。k ∈ {1..M+1}。"""
    return site_pauli('z', 1 if k == M + 1 else k, M)


def mu_periodic(mu, k):
    """def_transfer_matrix の周期規約 μ(M+1) := μ(1)。k ∈ {1..M+1}。"""
    M = len(mu)
    return mu[0] if k == M + 1 else mu[k - 1]


def d_of(mu):
    """d(μ) := Σ_m μ(m)μ(m+1)（周期規約で μ(M+1) := μ(1)）。"""
    M = len(mu)
    return sum(mu_periodic(mu, m) * mu_periodic(mu, m + 1) for m in range(1, M + 1))


def e_of(mu, mup):
    """e(μ,μ') := Σ_m μ(m)μ'(m)。"""
    return sum(mu[m] * mup[m] for m in range(len(mu)))


def single_nonzero_sum(terms, n0, what):
    """finite_sum_with_single_nonzero_term: j ≠ n0 の項が 0 であることを確かめてから Σ_j z_j = z_{n0} を返す。"""
    for j, z in enumerate(terms):
        if j != n0:
            eq(z, 0, what + f": j={j + 1} の項は 0")
    s = sum(terms)
    eq(s, terms[n0], what + ": 和 = 唯一の非零項")
    return s


RL = LaurentPolynomialRing(QQ, ['Y', 'X2'])   # Y = exp((1/2)K_1)、X2 = exp(K_2)（行列 X = ((1/2)K_1)_ℂ D と区別する）
Yg, Xg = RL.gens()
PK = PolynomialRing(QQ, 'K1')          # X = ((1/2)K_1)_ℂ D の成分を K_1 の多項式で
K1 = PK.gen()

for M in range(2, 6):
    n = 2**M
    confs = row_configurations(M)
    # 主張の言い換え: μ ↦ ν(ι(μ)) = ord(μ) は 𝔐 → {1..n} の全単射（どの k, l も ν(ι(μ)) の形）
    eq(sorted(nu_number(iota(mu)) for mu in confs), list(range(1, n + 1)), f"M={M}: ν∘ι は全単射")
    for mu in confs:
        eq(nu_number(iota(mu)), ord_number(mu), f"M={M}: ν(ι(μ)) = ord(μ)")
    # ---- 準備: m^+ と周期的な延長 ----
    for m in range(1, M + 1):
        eq(sigma_z_periodic(M, m + 1), site_pauli('z', m_plus(m, M), M), f"M={M}, m={m}: σ_{{m+1}}^z = σ_{{m^+}}^z")
        for mu in confs:
            eq(mu_periodic(mu, m + 1), mu[m_plus(m, M) - 1], f"M={M}, m={m}: μ(m+1) = μ(m^+)")
    # ---- Step 1: D の成分の二つの鎖 ----
    prods = [sigma_z_periodic(M, m) * sigma_z_periodic(M, m + 1) for m in range(1, M + 1)]   # σ_m^zσ_{m+1}^z（mat_mult）
    prods_plus = [site_pauli('z', m, M) * site_pauli('z', m_plus(m, M), M) for m in range(1, M + 1)]
    D = sum(prods, matrix(ZZ, n, n, 0))            # def_finite_sum_of_matrices
    for p in range(n):
        for q in range(n):
            line1 = sum(P[p, q] for P in prods)                                  # finite_sum_of_matrices_entrywise
            eq(D[p, q], line1, f"M={M}: D_pq の鎖の 1 行目")
            line2 = sum(P[p, q] for P in prods_plus)
            eq(line1, line2, f"M={M}: D_pq の鎖の 2 行目")
            if p != q:
                for P in prods_plus:
                    eq(P[p, q], 0, f"M={M}: site_sigma_z_product_is_diagonal")   # 3 行目の各項
                eq(line2, sum([0] * M), f"M={M}: D_pq の鎖の 3 行目")
                eq(sum([0] * M), 0, "finite_sum_of_complex_zeros")
    for mu in confs:
        k = nu_number(iota(mu)) - 1
        line1 = sum(P[k, k] for P in prods)
        line2 = sum(P[k, k] for P in prods_plus)
        terms3 = [mu[m - 1] * mu[m_plus(m, M) - 1] for m in range(1, M + 1)]   # μ(m)_ℂ μ(m^+)_ℂ（整数の積）
        for m in range(1, M + 1):
            eq(prods_plus[m - 1][k, k], mu[m - 1] * mu[m_plus(m, M) - 1], f"M={M}: site_sigma_z_product_diagonal_entry")
        line5 = sum(mu[m - 1] * mu[m_plus(m, M) - 1] for m in range(1, M + 1))
        line6 = sum(mu_periodic(mu, m) * mu_periodic(mu, m + 1) for m in range(1, M + 1))
        eq(D[k, k], line1, f"M={M}: D_kk の鎖の 1 行目")
        eq(line1, line2, f"M={M}: D_kk の鎖の 2 行目")
        eq(line2, sum(terms3), f"M={M}: D_kk の鎖の 3〜4 行目")
        eq(sum(terms3), line5, f"M={M}: D_kk の鎖の 5 行目")
        eq(line5, line6, f"M={M}: D_kk の鎖の 6 行目")
        eq(line6, d_of(mu), f"M={M}: D_kk の鎖の 7 行目")
    # ---- Step 1: X := ((1/2)K_1)_ℂ D は対角 ----
    Xm = (K1 / 2) * D.change_ring(PK)
    for p in range(n):
        for q in range(n):
            eq(Xm[p, q], (K1 / 2) * D[p, q], f"M={M}: X_pq の鎖の 1 行目")
            if p != q:
                eq((K1 / 2) * D[p, q], (K1 / 2) * 0, f"M={M}: X_pq の鎖の 2 行目")
                eq(Xm[p, q], 0, f"M={M}: X_pq の鎖の 3 行目")
    # ---- (A) 一般の結合定数 と (B) 具体の結合定数 ----
    cases = [("A", Yg, Xg, RL)]
    if M <= 4:
        cases += [("B", QQ(y), QQ(x), QQ) for (x, y) in [(2, 3), (3, 2), (QQ(3) / 2, 2), (3, 3)]]
    else:
        cases += [("B", QQ(3), QQ(2), QQ)]
    for (tag, Y, Xv, R) in cases:
        # B = exp(X)。(A) では対角成分の公式 b(μ) = Y^{d(μ)} で作る（行の等号は R で一般に確かめる）。
        # (B) では D の固有値 λ の射影 P_λ から B = Σ_λ y^λ P_λ（(1/2)K_1λ = λ log y）として作り、公式を経由しない。
        if tag == "A":
            B = matrix(R, n, n, 0)
            for mu in confs:
                k = nu_number(iota(mu)) - 1
                B[k, k] = Y**d_of(mu)
        else:
            B = exp_by_spectral_projectors(D, lambda lam: Y**lam, QQ)
            V1 = V1_by_components(M, lambda m: Y**(2 * m), QQ)
            eq(B * B, V1, f"M={M}, {tag}: BB = V_1（def_transfer_matrix_square_root の平方根）")
        V2 = V2_by_components(M, lambda m: Xv**m, R)         # def_transfer_matrix の成分（ord_inverse で行・列から μ を復元）
        BV2 = B * V2
        W = BV2 * B                                    # def_symmetrized_transfer_matrix: W := (V_1^{1/2}V_2)V_1^{1/2}
        b = {mu: Y**d_of(mu) for mu in confs}
        v = {(mu, mup): Xv**e_of(mu, mup) for mu in confs for mup in confs}
        # 準備: b(μ) > 0, v(μ,μ') > 0。(A) では係数が正の単項式（Y, X > 0 で正）であることを見る
        for mu in confs:
            if tag == "A":
                eq((b[mu].number_of_terms(), b[mu].coefficients()), (1, [1]), f"M={M}: b(μ) は係数 1 の単項式（Y > 0 で正）")
            else:
                pos(b[mu], f"M={M}: b(μ) > 0")
        # Step 1 の B の成分
        for p in range(n):
            for q in range(n):
                if p != q:
                    eq(B[p, q], 0, f"M={M}, {tag}: B_pq = 0（p ≠ q）")
        for mu in confs:
            k = nu_number(iota(mu)) - 1
            eq(B[k, k], b[mu], f"M={M}, {tag}: B_kk = b(μ)_ℂ")
            if tag == "B":
                # B_kk の鎖の 2〜6 行目。K_1 = 2 log y なので、肩 t = cK_1（c ∈ QQ）の実数の exp の値は y^{2c}。
                # exp_of_t は肩を QQ[K_1] の元で受け取り、K_1 の一次の項だけからなることを確かめて値を返す。
                def exp_of_t(t):
                    t = PK(t)
                    assert t.constant_coefficient() == 0 and t.degree() <= 1
                    return Y**(2 * t[1])
                r2 = exp_of_t(Xm[k, k])                         # exp(X_kk)
                r3 = exp_of_t((K1 / 2) * D[k, k])               # exp(((1/2)K_1)_ℂ D_kk)
                r4 = exp_of_t((K1 / 2) * d_of(mu))              # exp(((1/2)K_1)_ℂ d(μ)_ℂ)
                r5 = exp_of_t((K1 / 2) * d_of(mu))              # exp(((1/2)K_1 d(μ))_ℂ)（包含は計算環で恒等）
                r6 = Y**d_of(mu)                                # (exp((1/2)K_1 d(μ)))_ℂ = y^{d(μ)}
                eq(B[k, k], r2, f"M={M}: B_kk の鎖の 2 行目")
                eq(r2, r3, f"M={M}: B_kk の鎖の 3 行目")
                eq(r3, r4, f"M={M}: B_kk の鎖の 4 行目")
                eq(r4, r5, f"M={M}: B_kk の鎖の 5 行目")
                eq(r5, r6, f"M={M}: B_kk の鎖の 6 行目")
                eq(r6, b[mu], f"M={M}: B_kk の鎖の 7 行目")
        for mu in confs:
            for mup in confs:
                k = nu_number(iota(mu)) - 1
                l = nu_number(iota(mup)) - 1
                # Step 2
                eq(V2[k, l], V2[ord_number(mu) - 1, ord_number(mup) - 1], f"M={M}, {tag}: Step 2 の 1 行目")
                eq(V2[ord_number(mu) - 1, ord_number(mup) - 1], Xv**sum(mu[m] * mup[m] for m in range(M)), f"M={M}, {tag}: Step 2 の 2 行目")
                eq(Xv**sum(mu[m] * mup[m] for m in range(M)), v[(mu, mup)], f"M={M}, {tag}: Step 2 の 3 行目")
                if tag == "A":
                    eq((v[(mu, mup)].number_of_terms(), v[(mu, mup)].coefficients()), (1, [1]), f"M={M}: v(μ,μ') は係数 1 の単項式")
                if tag == "B":
                    pos(v[(mu, mup)], f"M={M}: v(μ,μ') > 0")
                    neq(V2[k, l], Xv**(-e_of(mu, mup)), f"M={M}: 否定コントロール（K_2 の符号）") if e_of(mu, mup) != 0 else None
                # Step 3 の鎖
                for q in range(n):
                    if q != l:
                        eq(BV2[k, q] * B[q, l], BV2[k, q] * 0, f"M={M}, {tag}: (BV_2)_kq B_ql の鎖の 1 行目")
                        eq(BV2[k, q] * 0, 0, f"M={M}, {tag}: (BV_2)_kq B_ql の鎖の 2 行目")
                for p in range(n):
                    if p != k:
                        eq(B[k, p] * V2[p, l], 0 * V2[p, l], f"M={M}, {tag}: B_kp (V_2)_pl の鎖の 1 行目")
                        eq(0 * V2[p, l], 0, f"M={M}, {tag}: B_kp (V_2)_pl の鎖の 2 行目")
                l1 = W[k, l]
                l2 = sum(BV2[k, q] * B[q, l] for q in range(n))
                eq(l1, l2, f"M={M}, {tag}: Step 3 の 1→2 行目")
                l3 = single_nonzero_sum([BV2[k, q] * B[q, l] for q in range(n)], l, f"M={M}, {tag}: Step 3 の 3 行目")
                eq(l3, BV2[k, l] * B[l, l], f"M={M}, {tag}: Step 3 の 3 行目の値")
                l4 = sum(B[k, p] * V2[p, l] for p in range(n)) * B[l, l]
                eq(BV2[k, l] * B[l, l], l4, f"M={M}, {tag}: Step 3 の 4 行目")
                single_nonzero_sum([B[k, p] * V2[p, l] for p in range(n)], k, f"M={M}, {tag}: Step 3 の 5 行目")
                l5 = (B[k, k] * V2[k, l]) * B[l, l]
                eq(l4, l5, f"M={M}, {tag}: Step 3 の 5 行目の値")
                l6 = (b[mu] * V2[k, l]) * b[mup]
                eq(l5, l6, f"M={M}, {tag}: Step 3 の 6 行目")
                l7 = (b[mu] * v[(mu, mup)]) * b[mup]
                eq(l6, l7, f"M={M}, {tag}: Step 3 の 7 行目（8〜9 行目は包含が恒等なので同じ値）")
                # 主張: W_kl = w_ℂ, w = (b v) b' > 0
                w = (b[mu] * v[(mu, mup)]) * b[mup]
                r = [b[mu], v[(mu, mup)], b[mup]]
                eq(w, (r[0] * r[1]) * r[2], f"M={M}, {tag}: w = Π_{{j=1}}^3 r_j（左から掛ける）")
                eq(l1, w, f"M={M}, {tag}: W_kl = w")
                if tag == "B":
                    pos(w, f"M={M}: w > 0")
                else:
                    eq((w.number_of_terms(), w.coefficients()), (1, [1]), f"M={M}: w は係数 1 の単項式（Y, X2 > 0 で正）")
        if tag == "B":
            # 否定コントロール: 平方根でない V_1 を挟むと W の成分が w と外れる
            V1 = V1_by_components(M, lambda m: Y**(2 * m), QQ)
            Wbad = (V1 * V2) * V1
            mu0 = confs[0]
            k0 = nu_number(iota(mu0)) - 1
            neq(Wbad[k0, k0], (b[mu0] * v[(mu0, mu0)]) * b[mu0], f"M={M}: 否定コントロール（V_1 を挟む）")
            # 否定コントロール: 対角でない行列（V_2 自身）では単独の非零項の行が落ちる
            try:
                single_nonzero_sum([V2[0, p] * V2[p, 0] for p in range(n)], 0, "neg")
                raise RuntimeError("否定コントロールが落ちなかった")
            except AssertionError:
                n_neg += 1
    print(f"M_col = {M}: 準備・Step 1・Step 2・Step 3・主張の行が、一般の結合定数（Laurent 多項式環）と具体の結合定数 {len(cases) - 1} 組で成り立つ")

print(f"等号 {n_eq} 件、不等号 {n_ineq} 件、否定コントロール {n_neg} 件")
print("RESULT: PASS")
