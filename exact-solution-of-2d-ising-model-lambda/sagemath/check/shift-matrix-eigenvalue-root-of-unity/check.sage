# 対象ラベル: claim_shift_matrix_eigenvalue_root_of_unity
#   併せて引く定義・主張: def_shift_matrix, def_qbar_matrix_eval, def_qbar_eigenvalue,
#                         def_qbar_eigenvector, def_root_of_unity_set, def_qbar_vector_smul,
#                         def_qbar_zero_vector, claim_qbar_matrix_eval_pow,
#                         claim_qbar_matrix_eval_identity, claim_qbar_eigenvector_pow,
#                         claim_qbar_identity_action, claim_qbar_smul_eq_zero,
#                         theorem_shift_matrix_order
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「シフト行列の固有値は 1 の L 乗根である」を、小さい L で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。整係数多項式環は ZZ['x']、
# 代数的数の全体 Qbar は QQbar（厳密な代数的数の体）で表す。行列の添字は行配位
# （長さ L の +1/-1 の並び）で、実行のたび同じ順序に並べる。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 添字集合とシフト行列。R_L が 2^L 元で、U_{tau,tau'} が tau' = S(tau) のとき 1、
#      そうでないとき 0 であること。
#   2. 第 1 の鎖の 3 段。Ev_xi(U)^L = Ev_xi(U^L) = Ev_xi(I) = I^Qbar_L。
#      （xi を複数取り、値が xi によらないことも確かめる。）
#   3. 第 2 の鎖の 3 段。固有ベクトル v について z^L ⊙ v = Ev_xi(U)^L · v = I^Qbar_L · v = v。
#   4. 第 3 の鎖（各点の計算）。(z^L + (-1)) ⊙ v が零ベクトルであること。
#   5. 最後の段。claim_qbar_smul_eq_zero を当てて z^L + (-1) = 0、すなわち z^L = 1 であること。
#   6. 主張そのもの。Ev_xi(U) の固有値がすべて mu_L に属すること。
#   7. 主張が空虚でないこと。固有値が実際に存在し、L 個の相異なる 1 の L 乗根が現れること。
#   8. 仮定が効いていること。1 の L 乗根でない代数的数（2 や sqrt(2)）が固有値でないこと。

Ls = [1, 2, 3, 4, 5]

R = ZZ["x"]
x = R.gen()

# 代入する点 xi。シフト行列の成分は定数多項式なので、値は xi によらないはずである。
xis = [QQbar(0), QQbar(1), QQbar(2), QQbar(-1) / QQbar(3), QQbar(2).sqrt(), QQbar(-1).sqrt()]


def row_configs(L):
    """行配位の全体 R_L（長さ L の +1/-1 の並び）を、実行のたび同じ順序で返す。"""
    return [tuple(1 if (mask >> y) & 1 == 0 else -1 for y in range(L))
            for mask in range(2 ** L)]


def shift(tau):
    """巡回シフト S(tau)(y) = tau(y + 1 mod L)。"""
    L = len(tau)
    return tuple(tau[(y + 1) % L] for y in range(L))


def shift_matrix_poly(L):
    """シフト行列 U （成分は Z[x] の定数多項式 kappa(1) / kappa(0)）。"""
    taus = row_configs(L)
    idx = {tau: i for i, tau in enumerate(taus)}
    M = matrix(R, len(taus), len(taus), lambda i, j: R(0))
    for tau in taus:
        M[idx[tau], idx[shift(tau)]] = R(1)
    return M


def evaluate(M, xi):
    """成分ごとの評価 Ev_xi（Z[x] の行列を Qbar の行列へ運ぶ）。"""
    return matrix(QQbar, M.nrows(), M.ncols(),
                  lambda i, j: QQbar(M[i, j](xi)))


print("== シフト行列の固有値は 1 の L 乗根である ==")
ok = True

for L in Ls:
    taus = row_configs(L)
    idx = {tau: i for i, tau in enumerate(taus)}
    n = len(taus)
    U = shift_matrix_poly(L)

    # 1. 添字集合とシフト行列の成分。
    assert n == 2 ** L
    for tau in taus:
        for tau2 in taus:
            expected = R(1) if tau2 == shift(tau) else R(0)
            assert U[idx[tau], idx[tau2]] == expected

    I_qbar = identity_matrix(QQbar, n)
    UL = U ** L  # Z[x] の行列の冪（A^1 := A から右へ掛ける）
    assert UL == identity_matrix(R, n), "U^L = I が破れた"

    # 2. 第 1 の鎖。Ev_xi(U)^L = Ev_xi(U^L) = Ev_xi(I) = I^Qbar_L。xi によらないことも見る。
    mats = []
    for xi in xis:
        A = evaluate(U, xi)
        assert A ** L == evaluate(UL, xi), "Ev_xi(U)^L = Ev_xi(U^L) が破れた"
        assert evaluate(UL, xi) == evaluate(identity_matrix(R, n), xi)
        assert evaluate(identity_matrix(R, n), xi) == I_qbar
        assert A ** L == I_qbar
        mats.append(A)
    for A in mats[1:]:
        assert A == mats[0], "Ev_xi(U) が xi に依存した"

    A = mats[0]

    # 3–6. 固有値と固有ベクトルを取り、鎖の各段と結論を確かめる。
    eigenvalues = []
    n_vectors = 0
    for z, vecs, mult in A.eigenvectors_right():
        z = QQbar(z)
        eigenvalues.append(z)
        for v in vecs:
            v = vector(QQbar, v)
            assert v != 0, "固有ベクトルが零ベクトルだった"
            n_vectors += 1
            # 3. z^L ⊙ v = A^L · v = I^Qbar_L · v = v。
            assert A * v == z * v
            assert z ** L * v == (A ** L) * v
            assert (A ** L) * v == I_qbar * v
            assert I_qbar * v == v
            # 4. (z^L + (-1)) ⊙ v が零ベクトル。
            assert (z ** L + QQbar(-1)) * v == vector(QQbar, [QQbar(0)] * n)
        # 5–6. z^L + (-1) = 0、すなわち z^L = 1（z が mu_L に属する）。
        assert z ** L + QQbar(-1) == QQbar(0)
        assert z ** L == QQbar(1), "固有値が 1 の L 乗根でなかった"

    # 7. 空虚でないこと。相異なる固有値がちょうど L 個（1 の原始 L 乗根の全体）現れる。
    distinct = set(eigenvalues)
    assert len(distinct) == L, "相異なる固有値の個数が L と違った"
    for m in range(L):
        assert QQbar.zeta(L) ** m in distinct

    # 8. 1 の L 乗根でない代数的数は固有値でない（仮定が効いていること）。
    for z0 in [QQbar(2), QQbar(2).sqrt()]:
        if z0 ** L != QQbar(1):
            assert (A - z0 * I_qbar).right_kernel().dimension() == 0, \
                "1 の L 乗根でない代数的数が固有値になった"

    print("L=%d: R_L は %d 元。xi %d 個で Ev_xi(U) が一致し、"
          "固有値 %d 個（相異なるもの %d 個）すべてが mu_L に属し、"
          "固有ベクトル %d 本で鎖の各段が成立した"
          % (L, n, len(xis), len(eigenvalues), len(distinct), n_vectors))

print("すべて通過" if ok else "失敗あり")
