# 対象ラベル: action_of_T_check_Vprime_on_check_psi
# 証明の準備 1〜4、準備 6（cI の成分）、準備 7（exp(cI) = exp(c)I）、準備 8（(X̌ + cI)(-X̌) = (-X̌)(X̌ + cI)、(X̌ + cI) + (-X̌) = cI）、
# Step 6 の T(W) の鎖のうち exp の値に依らない行（第 5・9・10 行）、結論の -g_μ = (-γ)_C の鎖を確かめる。
# 準備 1〜4・6・8 と Step 6 の値に依らない行は、行列の形にだけ依る（X̌ や ψ̌ の中身に依らない）ので、成分を QQ 上の多項式環の不定元にした
# n×n 行列（n = 2, 3, 4）で、各行を本文の式どおりに別々に組んで隣と比べる（全ての複素行列について一度に確かめる）。
# 準備 3 は成分の鎖（def_matrix_difference と、ℂ の差・結合律・符号反転・0 の 1 行ずつ）を、準備 4 は成分の鎖と行列の鎖の両方を確かめる。
# 準備 7 の exp(cI) = exp(c)I は ℝ への脱出（exp の極限）を含むので、cI が対角行列で対角成分が c であること（準備 6）を
# 多項式環で厳密に確かめたうえで、exp(cI) を def_exp の部分和に尾の上界を足したボールで作り、成分ごとに exp(c)δ_{kl} のボールと
# 重なることを c の 6 個の値 × n = 2, 4, 8 で確かめる。結論の -g_μ = (-γ)_C は、ℂ を実数の対として definition_of_cc の積で確かめる。
# 対照: 準備 3 で (A - B) - (C - B) を A + C と取り違えると一致しない。exp(cI) を exp(-c)I と取り違えると重ならない。
load("_prelude.sage")

rep = Report("action_of_T_check_Vprime_on_check_psi: 準備 1〜4・6〜8、Step 6 の値に依らない行、結論の -g_μ")


def gen_mats(R, names, n):
    return {nm: matrix(R, n, n, [R(f"{nm}_{i}{j}") for i in range(n) for j in range(n)]) for nm in names}


def chain(lines, label, offset=0):
    """ラベルの行番号は証明の等号の番号（offset はその鎖の前に置いた等号の数）。"""
    for t in range(1, len(lines)):
        rep.check(lines[t - 1][0] == lines[t][0], f"{label} 第 {t + offset} 行（{lines[t][1]}）", quiet=True)


def main():
    for n in [2, 3, 4]:
        names = ["A", "B", "C", "W", "X"]
        R = PolynomialRing(QQ, [f"{nm}_{i}{j}" for nm in names for i in range(n) for j in range(n)] + ["c"])
        Mt = gen_mats(R, names, n)
        A, B, C, W, X = [Mt[nm] for nm in names]
        c = R("c")
        I_ = body_identity(R, n); O = matrix(R, n, n, 0)
        cI = body_scalar(c, I_)
        # 準備 1
        chain([(body_difference(body_product(cI, W), body_product(W, cI)), ""),
               (comm(cI, W), "def_ad_X_matrix"),
               (O, "scalar_identity_commutes")], f"準備 1 n={n}")
        rep.check(body_product(cI, W) == body_product(W, cI), f"準備 1 の結論（matrix_difference_zero_iff_equal） n={n}", quiet=True)
        # 準備 2
        chain([(body_product(body_difference(A, B), C), ""),
               (body_product(body_sum(A, body_negation(B)), C), "matrix_difference_is_sum_with_negation"),
               (body_sum(body_product(A, C), body_product(body_negation(B), C)), "mat_mult_distributes_over_sum_in_left_factor"),
               (body_sum(body_product(A, C), body_negation(body_product(B, C))), "negation_factors_out_of_left_factor"),
               (body_difference(body_product(A, C), body_product(B, C)), "matrix_difference_is_sum_with_negation")], f"準備 2 の第 1 式 n={n}")
        chain([(body_product(C, body_difference(A, B)), ""),
               (body_product(C, body_sum(A, body_negation(B))), "matrix_difference_is_sum_with_negation"),
               (body_sum(body_product(C, A), body_product(C, body_negation(B))), "mat_mult_distributes_over_sum_in_right_factor"),
               (body_sum(body_product(C, A), body_negation(body_product(C, B))), "negation_factors_out_of_right_factor"),
               (body_difference(body_product(C, A), body_product(C, B)), "matrix_difference_is_sum_with_negation")], f"準備 2 の第 2 式 n={n}")
        # 準備 3（成分の鎖）
        lhs = body_difference(body_difference(A, B), body_difference(C, B))
        for kx in range(n):
            for lx in range(n):
                chain([(lhs[kx, lx], ""),
                       (body_difference(A, B)[kx, lx] - body_difference(C, B)[kx, lx], "def_matrix_difference（外側）"),
                       ((A[kx, lx] - B[kx, lx]) - (C[kx, lx] - B[kx, lx]), "def_matrix_difference 2 か所（内側）"),
                       ((A[kx, lx] - B[kx, lx]) + (-(C[kx, lx] - B[kx, lx])), "def_complex_difference"),
                       ((A[kx, lx] - B[kx, lx]) + (B[kx, lx] - C[kx, lx]), "reversed_difference_is_negation_of_difference_in_cc（右辺から左辺へ）"),
                       ((A[kx, lx] + (-B[kx, lx])) + (B[kx, lx] + (-C[kx, lx])), "def_complex_difference 2 か所"),
                       (A[kx, lx] + ((-B[kx, lx]) + (B[kx, lx] + (-C[kx, lx]))), "complex_numbers_form_a_field の和の結合律"),
                       (A[kx, lx] + (((-B[kx, lx]) + B[kx, lx]) + (-C[kx, lx])), "complex_numbers_form_a_field の和の結合律（右辺から左辺へ）"),
                       (A[kx, lx] + (R(0) + (-C[kx, lx])), "negation_plus_self_is_zero_in_cc"),
                       (A[kx, lx] + (-C[kx, lx]), "complex_zero_plus_is_original"),
                       (A[kx, lx] - C[kx, lx], "def_complex_difference（右辺から左辺へ）"),
                       (body_difference(A, C)[kx, lx], "def_matrix_difference")], f"準備 3 n={n} ({kx},{lx})")
        rep.check(lhs != body_sum(A, C), f"対照 準備 3 を A + C と取り違えると一致しない n={n}", quiet=True)
        # 準備 4（3 項の和）
        r = 3
        R4 = PolynomialRing(QQ, [f"{nm}{v}_{i}{j}" for nm in ["a", "b"] for v in range(r) for i in range(n) for j in range(n)])
        As = [matrix(R4, n, n, [R4(f"a{v}_{i}{j}") for i in range(n) for j in range(n)]) for v in range(r)]
        Bs = [matrix(R4, n, n, [R4(f"b{v}_{i}{j}") for i in range(n) for j in range(n)]) for v in range(r)]
        SAB = body_finite_sum([body_sum(As[v], Bs[v]) for v in range(r)])
        SA = body_finite_sum(As); SB = body_finite_sum(Bs)
        for kx in range(n):
            for lx in range(n):
                chain([(SAB[kx, lx], ""),
                       (sum(body_sum(As[v], Bs[v])[kx, lx] for v in range(r)), "finite_sum_of_matrices_entrywise"),
                       (sum(As[v][kx, lx] + Bs[v][kx, lx] for v in range(r)), "def_matrix_sum"),
                       (sum(As[v][kx, lx] for v in range(r)) + sum(Bs[v][kx, lx] for v in range(r)), "finite_sum_of_complex_sums"),
                       (SA[kx, lx] + SB[kx, lx], "finite_sum_of_matrices_entrywise 2 か所"),
                       (body_sum(SA, SB)[kx, lx], "def_matrix_sum")], f"準備 4 の和の等式 n={n} ({kx},{lx})")
        chain([(body_finite_sum([body_difference(As[v], Bs[v]) for v in range(r)]), ""),
               (body_finite_sum([body_sum(As[v], body_negation(Bs[v])) for v in range(r)]), "matrix_difference_is_sum_with_negation"),
               (body_sum(SA, body_finite_sum([body_negation(Bs[v]) for v in range(r)])), "和の等式"),
               (body_sum(SA, body_negation(SB)), "finite_sum_of_negated_matrices"),
               (body_difference(SA, SB), "matrix_difference_is_sum_with_negation")], f"準備 4 の差の等式 n={n}")
        # 準備 8 の可換性
        Xc = body_sum(X, cI); nX = body_negation(X)
        chain([(body_product(Xc, nX), ""),
               (body_sum(body_product(X, nX), body_product(cI, nX)), "mat_mult_distributes_over_sum_in_left_factor"),
               (body_sum(body_negation(body_product(X, X)), body_product(cI, nX)), "negation_factors_out_of_right_factor"),
               (body_sum(body_negation(body_product(X, X)), body_product(nX, cI)), "準備 1"),
               (body_sum(body_product(nX, X), body_product(nX, cI)), "negation_factors_out_of_left_factor"),
               (body_product(nX, Xc), "mat_mult_distributes_over_sum_in_right_factor")], f"準備 8 の可換性 n={n}")
        # 準備 8 の和
        chain([(body_sum(Xc, nX), ""),
               (body_sum(nX, Xc), "matrix_sum_is_commutative"),
               (body_sum(nX, body_sum(cI, X)), "matrix_sum_is_commutative"),
               (body_sum(nX, body_sum(cI, body_negation(nX))), "matrix_double_negation"),
               (body_sum(nX, body_difference(cI, nX)), "matrix_difference_is_sum_with_negation"),
               (cI, "matrix_plus_difference_cancels")], f"準備 8 の和 n={n}")
        # 準備 6: (cI)_{kl} = c I_{kl} = c δ_{kl}、c δ_kk = c 1 = c、c δ_kl = c 0 = 0（k ≠ l）
        for kx in range(n):
            for lx in range(n):
                dl = R(1) if kx == lx else R(0)
                chain([(cI[kx, lx], ""), (c * I_[kx, lx], "def_matrix_scalar_multiple"), (c * dl, "def_identity_matrix")], f"準備 6 の第 1 の鎖 n={n} ({kx},{lx})")
                chain([(c * dl, ""), (c * (R(1) if kx == lx else R(0)), "def_kronecker_delta"), ((c if kx == lx else R(0)), ("complex_numbers_form_a_field の乗法の単位元" if kx == lx else "complex_times_zero_is_zero (z → c)"))], f"準備 6 の第 2 の鎖 n={n} ({kx},{lx})")
        # Step 6 の T(W) の鎖のうち exp の値に依らない行（結合律・スカラーの外出し・右単位元）:
        # exp(X̌ + cI)・exp(-X̌) を不定元の行列 E1 = A、E2 = B、exp(c) を不定元 c に置いて確かめる
        chain([(body_product(body_product(W, A), B), ""), (body_product(W, body_product(A, B)), "mat_mult_associative")], f"Step 6 n={n}", offset=4)
        chain([(body_product(W, body_scalar(c, I_)), ""), (body_scalar(c, body_product(W, I_)), "scalar_multiple_factors_out_of_right_factor"),
               (body_scalar(c, W), "identity_matrix_is_right_unit_of_mat_mult")], f"Step 6 n={n}", offset=8)

    # 準備 7 の第 2〜6 行（exp の値に依らない）: exp(c) を不定元 E に置き、場合分けの式 → (E·1, 0) → (E·1, E·0) → Eδ_kl → (E I)_kl を比べる
    RE = PolynomialRing(QQ, ["cc", "E"]); cc, Ev = RE.gens()
    for n in [2, 3, 4]:
        IE = body_identity(RE, n); cIE = body_scalar(cc, IE)
        for kx in range(n):
            for lx in range(n):
                case1 = Ev if kx == lx else RE(0)          # 第 1 行の右辺で exp((cI)_kk) を、準備 6 の (cI)_kk = c を経て exp(c) = E と書いたもの
                chain([(case1, ""),
                       ((Ev * RE(1)) if kx == lx else RE(0), "complex_numbers_form_a_field の乗法の単位元を右辺から左辺へ（k = l）"),
                       ((Ev * RE(1)) if kx == lx else (Ev * RE(0)), "complex_times_zero_is_zero (z → exp(c)) を右辺から左辺へ（k ≠ l）"),
                       (Ev * (RE(1) if kx == lx else RE(0)), "def_kronecker_delta"),
                       (body_scalar(Ev, IE)[kx, lx], "準備 6 の第 1 の鎖（c → exp(c)）")], f"準備 7 n={n} ({kx},{lx})", offset=2)
                rep.check(cIE[kx, kx] == cc, f"準備 7 の第 2 行の根拠 (cI)_kk = c n={n}", quiet=True)
    # 準備 7 の第 1 行（exp_of_diagonal_matrix の当てはめ、ℝ への脱出）と主張: exp(cI) = exp(c)I（ボール）。cI が対角で対角成分が c であることは準備 6 の厳密な鎖が担う
    CVALS = [CB(0), CB(1), CB(-2), CB(QQ(1) / 3, -1), CB(-RB(5).log(), 2), CB(RB(7).sqrt(), QQ(1) / 2)]
    for n in [2, 4, 8]:
        I_ = body_identity(CB, n)
        for cv in CVALS:
            E = body_exp_ball_cb(body_scalar(cv, I_))
            ec = cv.exp()
            ok = all(E[kx, lx].overlaps(ec if kx == lx else CB(0)) for kx in range(n) for lx in range(n))
            rep.check(ok, f"準備 7 exp(cI) = exp(c)I c={cv.mid()} n={n}", quiet=True)
            if cv != CB(0):
                rep.check(not all(E[kx, kx].overlaps((-cv).exp()) for kx in range(n)), f"対照 exp(cI) ≠ exp(-c)I c={cv.mid()} n={n}", quiet=True)
        print(f"exp(cI): n={n} で済み")

    # 結論の -g_μ = (-γ)_C: ℂ を実数の対 (x, y) とし、definition_of_cc の積 (a,b)(c,d) = (ac - bd, ad + bc) で見る
    Rg = PolynomialRing(QQ, "gam")
    gam = Rg.gen()

    def cmul(z, w):
        return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])
    def cneg(z):                    # ℂ の加法の逆元（definition_of_cc の和の逆元）: -(x, y) = (-x, -y)
        return (-z[0], -z[1])
    one_C = (Rg(1), Rg(0))          # 1_C = ι(1) = (1, 0)
    m1C = cneg(one_C)               # -1_C を 1_C の加法の逆元として作る
    gC = (gam, Rg(0))               # g_μ = (γ)_C = (γ, 0)
    lines = [(cneg(gC), "-g_μ（加法の逆元として独立に作る）"),
             (cneg((gam, Rg(0))), "-(γ)_C（g_μ の定め方）"),
             (cmul(m1C, gC), "(-1_C)(γ)_C（multiply_by_minus_one）"),
             (cmul((Rg(-1), Rg(0)), gC), "(-1)_C(γ)_C（-1_C = ι(-1)）"),
             (((-1) * gam, Rg(0)), "((-1)γ)_C（real_inclusion_preserves_product）"),
             ((-gam, Rg(0)), "(-γ)_C（ℝ の (-1)x = -x）")]
    for t in range(1, len(lines)):
        rep.check(lines[t - 1][0] == lines[t][0], f"結論の -g_μ の鎖 第 {t} 行 {lines[t][1]}", quiet=False)
    rep.check(cmul(m1C, gC) != (gam, Rg(0)), "対照 -g_μ ≠ (γ)_C", quiet=True)


def body_exp_ball_cb(A):
    n = A.nrows()
    s = sum((z.real()**2 + z.imag()**2) for z in A.list()).sqrt()
    s = RB(s.upper())
    N = 20
    while not (s < N + 2 and (s**(N + 1) / factorial(N + 1)) < RB(2)**(-300)):
        N += 10
    E = matrix(CB, n, n, 0); Pw = body_identity(CB, n)
    for p in range(N + 1):
        E = body_sum(E, body_scalar(CB(1) / factorial(p), Pw))
        if p < N:
            Pw = body_product(Pw, A)
    rad = (s**(N + 1) / factorial(N + 1) / (1 - s / (N + 2))).upper()
    return matrix(CB, n, n, lambda r_, c_: CB(E[r_, c_].real().add_error(rad), E[r_, c_].imag().add_error(rad)))


main()
rep.finish()
