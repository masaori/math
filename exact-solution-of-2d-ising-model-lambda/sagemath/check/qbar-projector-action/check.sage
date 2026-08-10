# 対象ラベル: claim_qbar_projector_action
#   併せて引く定義: def_qbar_projector, def_qbar_vector, def_qbar_vector_smul,
#                   def_qbar_vector_sum, def_qbar_matrix, def_qbar_matrix_action,
#                   def_qbar_matrix_product, def_qbar_matrix_power,
#                   def_qbar_identity_matrix, def_root_of_unity_set, def_algebraic_numbers
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の定義 1 件
# 「列ベクトルを固有空間へ落とす写像」P_{A,z}(v) = ⊕_{k=0}^{L-1} z^{L-k} ⊙ (A^k · v) と、
# 主張 1 件「落とす写像への行列の作用は冪の指数を 1 つ進める」
# A · P_{A,z}(v) = ⊕_{k=0}^{L-1} z^{L-k} ⊙ (A^{k+1} · v) を、小さい L について確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 鎖の 5 段（落とす写像の定義・作用が有限和を保つこと・作用がスカラー倍を保つこと・
#      作用が行列の積と両立すること・冪の一歩の式）。
#   3. 主張そのもの。両辺が全成分で一致すること。
#   4. 主張が空虚でないこと。両辺が零ベクトルでない例があること。
#   5. 使っていない仮定。A^L = I も z^L = 1 も使っていないので、それらを満たさない
#      A・z でも主張が成り立つこと（本文が「この定義は 2 つを仮定しない」と書いた根拠）。
#   6. 係数が冪の形であることも使っていない。z^{L-k} を勝手な代数的数の族に取り替えても
#      同じ等式が成り立つこと（Lean の必要十分版が係数を勝手な写像に取っている根拠）。
#   7. 応用の形。A を Ev_ξ(U)（シフト行列の評価。U^L = I を満たす）に、z を 1 の L 乗根に
#      取っても成り立つこと。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def vec_smul(R, z, v):
    # (z ⊙ v)(τ) = z v(τ)
    return {t: z * v[t] for t in R}

def vec_sum(R, ks, vs, zero):
    # (⊕_{k∈s} v_k)(τ) = Σ_{k∈s} v_k(τ)。成分ごとの有限和として定める。
    return {t: sum((vs[k][t] for k in ks), zero) for t in R}

def act(R, A, v, zero):
    # (A · v)(τ) = Σ_{τ'} A[τ][τ'] v(τ')
    return {t: sum((A[t][u] * v[u] for u in R), zero) for t in R}

def mat_product(R, A, B, zero):
    return {t: {u: sum((A[t][w] * B[w][u] for w in R), zero) for u in R} for t in R}

def identity_mat(R, zero, one):
    return {t: {u: (one if t == u else zero) for u in R} for t in R}

def mat_pow(R, A, k, zero, one):
    # A^0 := I, A^{k+1} := A A^k（本文と同じ向き。左から掛ける）
    P = identity_mat(R, zero, one)
    for _ in range(k):
        P = mat_product(R, A, P, zero)
    return P

def eq_vec(R, v, w):
    return all(v[t] == w[t] for t in R)

# 検証に使う代数的数（すべて QQbar の厳密な元。有理数でないものを混ぜる）。
alg = [QQbar(0), QQbar(1), QQbar(-2), QQbar(3)/QQbar(5),
       QQbar(2).sqrt(), -QQbar(3).sqrt(), QQbar(-1).sqrt(), QQbar(5).nth_root(3)]

def sample(k):
    return alg[k % len(alg)]

def make_matrix(R, idx, shift):
    # 添字の番号から決まる規則で成分を選ぶ（乱数を使わないので再現する）。
    return {t: {u: sample(3 * idx[t] + 5 * idx[u] + shift) for u in R} for t in R}

def make_vector(R, idx, shift):
    return {t: sample(2 * idx[t] + shift) for t in R}

def shift_matrix_eval(R, L, idx):
    # Ev_ξ(U)。U は行配位の巡回シフト S の置換行列（成分は 0 と 1 の定数多項式なので、
    # x に何を代入しても同じ行列になる）。U^L = I を満たす。
    def S(t):
        return tuple(t[(j + 1) % L] for j in range(L))
    return {t: {u: (QQbar(1) if u == S(t) else QQbar(0)) for u in R} for t in R}

zero = QQbar(0)
one = QQbar(1)

print("== 落とす写像への行列の作用は冪の指数を 1 つ進めること ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"
    idx = {t: i for i, t in enumerate(R)}
    ks = list(range(L))

    nontrivial = False
    for shift in range(3):
        A = make_matrix(R, idx, shift)
        v = make_vector(R, idx, shift + 1)
        # 行列の冪と、一歩ぶんの積は z に依らないので先に作る。
        powA = {k: mat_pow(R, A, k, zero, one) for k in range(L + 1)}
        prodA = {k: mat_product(R, A, powA[k], zero) for k in ks}
        actPow = {k: act(R, powA[k], v, zero) for k in range(L + 1)}
        actProd = {k: act(R, prodA[k], v, zero) for k in ks}
        actActPow = {k: act(R, A, actPow[k], zero) for k in ks}

        # ---- 第 5 段。冪の一歩の式 A^{k+1} = A A^k（z に依らない） ---------
        for k in ks:
            assert all(prodA[k][t][u] == powA[k + 1][t][u]
                       for t in R for u in R), "第 5 段（冪の一歩の式）"

        for zi in range(len(alg)):
            z = alg[zi]
            coeff = {k: z ** (L - k) for k in ks}

            # ---- 鎖の第 1 段。落とす写像の定義 ----------------------------
            terms0 = {k: vec_smul(R, coeff[k], actPow[k]) for k in ks}
            P = vec_sum(R, ks, terms0, zero)
            lhs = act(R, A, P, zero)

            # ---- 第 2 段。作用が有限和を保つこと --------------------------
            step2 = vec_sum(R, ks, {k: act(R, A, terms0[k], zero) for k in ks}, zero)
            assert eq_vec(R, lhs, step2), "第 2 段（作用が有限和を保つこと）"

            # ---- 第 3 段。作用がスカラー倍を保つこと ----------------------
            step3 = vec_sum(
                R, ks, {k: vec_smul(R, coeff[k], actActPow[k]) for k in ks}, zero)
            assert eq_vec(R, step2, step3), "第 3 段（作用がスカラー倍を保つこと）"

            # ---- 第 4 段。作用が行列の積と両立すること --------------------
            step4 = vec_sum(
                R, ks, {k: vec_smul(R, coeff[k], actProd[k]) for k in ks}, zero)
            assert eq_vec(R, step3, step4), "第 4 段（作用が行列の積と両立すること）"

            # ---- 第 5 段（上で確かめた冪の一歩の式）で右辺へ着く ----------
            rhs = vec_sum(
                R, ks, {k: vec_smul(R, coeff[k], actPow[k + 1]) for k in ks}, zero)

            # ---- 2・3. 主張そのもの ---------------------------------------
            assert eq_vec(R, lhs, rhs), "主張が成り立たない"

            # ---- 4. 空虚でないこと ----------------------------------------
            if any(lhs[t] != zero for t in R):
                nontrivial = True

            # ---- 6. 係数が冪の形であることを使っていないこと ---------------
            free = {k: sample(7 * k + zi + shift) for k in ks}
            lhs_free = act(R, A, vec_sum(
                R, ks, {k: vec_smul(R, free[k], actPow[k]) for k in ks}, zero), zero)
            rhs_free = vec_sum(
                R, ks, {k: vec_smul(R, free[k], actPow[k + 1]) for k in ks}, zero)
            assert eq_vec(R, lhs_free, rhs_free), "係数を勝手な族に取り替えると破れた"

    assert nontrivial, "両辺が零ベクトルでない例が無い"

    # ---- 5. A^L = I も z^L = 1 も使っていないこと --------------------------
    A_bad = make_matrix(R, idx, 1)
    assert any(mat_pow(R, A_bad, L, zero, one)[t][u] != identity_mat(R, zero, one)[t][u]
               for t in R for u in R), "A^L = I でない例のはずが I になっている"
    z_bad = QQbar(2).sqrt()
    assert z_bad ** L != one, "z^L = 1 でない例のはずが 1 になっている"
    v_bad = make_vector(R, idx, 2)
    powBad = {k: mat_pow(R, A_bad, k, zero, one) for k in range(L + 1)}
    actBad = {k: act(R, powBad[k], v_bad, zero) for k in range(L + 1)}
    lhs_bad = act(R, A_bad, vec_sum(
        R, ks,
        {k: vec_smul(R, z_bad ** (L - k), actBad[k]) for k in ks}, zero), zero)
    rhs_bad = vec_sum(
        R, ks, {k: vec_smul(R, z_bad ** (L - k), actBad[k + 1]) for k in ks}, zero)
    assert eq_vec(R, lhs_bad, rhs_bad), "A^L = I も z^L = 1 も無い場合に破れた"

    # ---- 7. 応用の形（A = Ev_ξ(U)、z は 1 の L 乗根） ----------------------
    U = shift_matrix_eval(R, L, idx)
    assert all(mat_pow(R, U, L, zero, one)[t][u] == identity_mat(R, zero, one)[t][u]
               for t in R for u in R), "Ev_ξ(U)^L = I が成り立っていない"
    powU = {k: mat_pow(R, U, k, zero, one) for k in range(L + 1)}
    roots = [QQbar.zeta(L) ** r for r in range(L)]
    for shift in range(2):
        v = make_vector(R, idx, shift + 3)
        actU = {k: act(R, powU[k], v, zero) for k in range(L + 1)}
        for z in roots:
            assert z ** L == one, "1 の L 乗根でない"
            lhs_u = act(R, U, vec_sum(
                R, ks, {k: vec_smul(R, z ** (L - k), actU[k]) for k in ks}, zero), zero)
            rhs_u = vec_sum(
                R, ks, {k: vec_smul(R, z ** (L - k), actU[k + 1]) for k in ks}, zero)
            assert eq_vec(R, lhs_u, rhs_u), "応用の形で破れた"

    print(("L=%d: R_L は %d 元。行列 3 通り × スカラー %d 通りのすべてで鎖の 5 段と主張が"
           "成り立ち、両辺が零ベクトルでない例がある。"
           "A^L = I も z^L = 1 も満たさない例でも、係数を勝手な代数的数の族に取り替えても"
           "成り立つ。応用の形（Ev_ξ(U) と 1 の L 乗根 %d 個）でも成り立つ")
          % (L, len(R), len(alg), L))

print("すべて通過")
