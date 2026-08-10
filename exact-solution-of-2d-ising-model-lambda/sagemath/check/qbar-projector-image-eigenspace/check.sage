# 対象ラベル: claim_qbar_projector_image_eigenspace
#   併せて引く定義: def_qbar_projector, def_qbar_eigenspace, def_qbar_vector,
#                   def_qbar_vector_smul, def_qbar_vector_sum, def_qbar_matrix,
#                   def_qbar_matrix_action, def_qbar_matrix_product, def_qbar_matrix_power,
#                   def_qbar_identity_matrix, def_root_of_unity_set, def_algebraic_numbers
#   併せて引く主張: claim_qbar_projector_action, claim_qbar_identity_action
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「落とす写像の像は固有空間に入る」を小さい L について確かめる。すなわち
# A^L = I かつ z^L = 1 のとき P_{A,z}(v) ∈ E_A(z)、言い換えると
# A · P_{A,z}(v) = z ⊙ P_{A,z}(v) であること。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 準備 2（a_L = a_0）と準備 3（z^{L+1} = z）が仮定のもとで成り立つこと。
#   3. 鎖の各段（前の主張の右辺 → 添字のずらし → j=L の項の分離 → 準備 2・3 の適用 →
#      k=0 の項の復帰 → 分配則 → z ⊙ P へ）。
#   4. 主張そのもの。A · P = z ⊙ P が全成分で一致すること。
#   5. 主張が空虚でないこと。P が零ベクトルでない例があること。
#   6. **仮定が効いていること。** A^L = I を落とすと破れる例、z^L = 1 を落とすと破れる例が
#      実際にあること（準備 2・準備 3 がこの段で初めて要ることの裏取り）。
#   7. 応用の形。A を Ev_ξ(U)（シフト行列の評価。U^L = I を満たす置換行列）に、
#      z を 1 の L 乗根に取ったときが本来の使い道であること。

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

def eq_mat(R, A, B):
    return all(A[t][u] == B[t][u] for t in R for u in R)

def eq_vec(R, v, w):
    return all(v[t] == w[t] for t in R)

def projector(R, ks, z, actPow, zero):
    # P_{A,z}(v) = ⊕_{k=0}^{L-1} z^{L-k} ⊙ (A^k · v)
    L = len(ks)
    return vec_sum(R, ks, {k: vec_smul(R, z ** (L - k), actPow[k]) for k in ks}, zero)

zero = QQbar(0)
one = QQbar(1)

# 検証に使う代数的数（すべて QQbar の厳密な元。有理数でないものを混ぜる）。
alg = [QQbar(0), QQbar(1), QQbar(-2), QQbar(3)/QQbar(5),
       QQbar(2).sqrt(), -QQbar(3).sqrt(), QQbar(-1).sqrt(), QQbar(5).nth_root(3)]

def sample(k):
    return alg[k % len(alg)]

def make_vector(R, idx, shift):
    return {t: sample(2 * idx[t] + shift) for t in R}

def make_matrix(R, idx, shift):
    # 添字の番号から決まる規則で成分を選ぶ（乱数を使わないので再現する）。
    return {t: {u: sample(3 * idx[t] + 5 * idx[u] + shift) for u in R} for t in R}

def permutation_matrix(R, perm, zero, one):
    # 置換 perm の置換行列。perm^L = id なら L 乗が I になる。
    return {t: {u: (one if u == perm(t) else zero) for u in R} for t in R}

def cyclic_shift(L):
    def S(t):
        return tuple(t[(j + 1) % L] for j in range(L))
    return S

print("== 落とす写像の像は固有空間に入ること ==")

for L in [1, 2, 3, 4]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"
    idx = {t: i for i, t in enumerate(R)}
    ks = list(range(L))

    # A^L = I を満たす行列として、L 乗すると恒等になる置換の置換行列を使う。
    # 巡回シフト S は S^L = id なので条件を満たす。
    U = permutation_matrix(R, cyclic_shift(L), zero, one)
    assert eq_mat(R, mat_pow(R, U, L, zero, one), identity_mat(R, zero, one)), \
        "U^L = I が成り立っていない"
    # もう 1 つ、成分が 0/1 でない例（U の -1 倍。(-U)^L = (-1)^L U^L なので L が偶数のときだけ
    # I になる）。L の偶奇で使い分ける。
    Uminus = {t: {u: -U[t][u] for u in R} for t in R}
    mats = [U] + ([Uminus] if L % 2 == 0 else [])
    for A in mats:
        assert eq_mat(R, mat_pow(R, A, L, zero, one), identity_mat(R, zero, one)), \
            "A^L = I が成り立っていない"

    roots = [QQbar.zeta(L) ** r for r in range(L)]
    nontrivial = False

    for A in mats:
        powA = {k: mat_pow(R, A, k, zero, one) for k in range(L + 1)}
        for shift in range(3):
            v = make_vector(R, idx, shift + 1)
            actPow = {k: act(R, powA[k], v, zero) for k in range(L + 1)}

            # ---- 2. 準備 2（a_L = a_0）------------------------------------
            # a_k = (A^k · v)(τ)。A^L = I と I·v = v から a_L = a_0 = v(τ)。
            assert eq_vec(R, actPow[L], v), "準備 2（a_L = a_0）が破れた"
            assert eq_vec(R, actPow[0], v), "準備 2（a_0 = v(τ)）が破れた"

            for z in roots:
                # ---- 2. 準備 3（z^{L+1} = z）------------------------------
                assert z ** L == one, "1 の L 乗根でない"
                assert z ** (L + 1) == z, "準備 3（z^{L+1} = z）が破れた"

                P = projector(R, ks, z, actPow, zero)
                lhs = act(R, A, P, zero)

                # ---- 3. 鎖の各段 -----------------------------------------
                # 第 1 段。前の主張（claim_qbar_projector_action）の右辺。
                step1 = vec_sum(
                    R, ks,
                    {k: vec_smul(R, z ** (L - k), actPow[k + 1]) for k in ks}, zero)
                assert eq_vec(R, lhs, step1), "第 1 段（前の主張の右辺）"

                # 第 2-4 段。成分ごとの有限和に開き、添字を j = k+1 へずらす。
                a = {k: {t: actPow[k][t] for t in R} for k in range(L + 1)}
                step_shift = {t: sum((z ** (L - j + 1) * a[j][t]
                                      for j in range(1, L + 1)), zero) for t in R}
                assert eq_vec(R, step1, step_shift), "添字のずらし（j = k+1）"

                # 第 5 段。j = L の項を分ける。
                step_split = {t: sum((z ** (L - j + 1) * a[j][t]
                                      for j in range(1, L)), zero)
                                 + z * a[L][t] for t in R}
                assert eq_vec(R, step_shift, step_split), "j = L の項の分離"

                # 第 6-7 段。準備 2（a_L = a_0）と準備 3（z = z^{L+1}）を当てる。
                step_prep = {t: sum((z ** (L - j + 1) * a[j][t]
                                     for j in range(1, L)), zero)
                                + z ** (L + 1) * a[0][t] for t in R}
                assert eq_vec(R, step_split, step_prep), "準備 2・準備 3 の適用"

                # 第 8 段。k = 0 の項を有限和へ戻す。
                step_back = {t: sum((z ** (L - k + 1) * a[k][t] for k in ks), zero)
                             for t in R}
                assert eq_vec(R, step_prep, step_back), "k = 0 の項の復帰"

                # 第 9-10 段。z^{L-k+1} = z^{L-k} z と分配則で z を外へ出す。
                step_dist = {t: z * sum((z ** (L - k) * a[k][t] for k in ks), zero)
                             for t in R}
                assert eq_vec(R, step_back, step_dist), "分配則で z を外へ出す段"

                # 第 11-13 段。有限和とスカラー倍の定義で z ⊙ P へ戻す。
                rhs = vec_smul(R, z, P)
                assert eq_vec(R, step_dist, rhs), "z ⊙ P への戻し"

                # ---- 4. 主張そのもの -------------------------------------
                assert eq_vec(R, lhs, rhs), "主張（A · P = z ⊙ P）が成り立たない"

                # ---- 5. 空虚でないこと -----------------------------------
                if any(P[t] != zero for t in R):
                    nontrivial = True

    assert nontrivial, "P が零ベクトルでない例が無い"

    # ---- 6. 仮定が効いていること -------------------------------------------
    # (a) z^L = 1 を落とすと破れる。A は U（A^L = I は満たす）、z は √2（z^L ≠ 1）。
    broke_z = False
    z_bad = QQbar(2).sqrt()
    assert z_bad ** L != one, "z^L = 1 でない例のはずが 1 になっている"
    powU = {k: mat_pow(R, U, k, zero, one) for k in range(L + 1)}
    for shift in range(3):
        v = make_vector(R, idx, shift + 1)
        actU = {k: act(R, powU[k], v, zero) for k in range(L + 1)}
        P = projector(R, ks, z_bad, actU, zero)
        if not eq_vec(R, act(R, U, P, zero), vec_smul(R, z_bad, P)):
            broke_z = True
    assert broke_z, "z^L = 1 を落としても破れなかった（仮定が効いていない）"

    # (b) A^L = I を落とすと破れる。A は一般の行列（A^L ≠ I）、z は 1 の L 乗根。
    broke_A = False
    for shift in range(3):
        A_bad = make_matrix(R, idx, shift)
        if eq_mat(R, mat_pow(R, A_bad, L, zero, one), identity_mat(R, zero, one)):
            continue
        powBad = {k: mat_pow(R, A_bad, k, zero, one) for k in range(L + 1)}
        v = make_vector(R, idx, shift + 2)
        actBad = {k: act(R, powBad[k], v, zero) for k in range(L + 1)}
        for z in roots:
            P = projector(R, ks, z, actBad, zero)
            if not eq_vec(R, act(R, A_bad, P, zero), vec_smul(R, z, P)):
                broke_A = True
    assert broke_A, "A^L = I を落としても破れなかった（仮定が効いていない）"

    # ---- 7. 応用の形（A = Ev_ξ(U)、z は 1 の L 乗根）が上で確かめた場合そのもの ----
    # mats の先頭が U（シフト行列の評価。成分は 0 と 1 の定数なので x への代入に依らない）。
    print(("L=%d: R_L は %d 元。A^L = I を満たす行列 %d 通り × 1 の L 乗根 %d 個 × "
           "列ベクトル 3 通りのすべてで、鎖の各段と主張 A · P = z ⊙ P が成り立ち、"
           "P が零ベクトルでない例がある。z^L = 1 を落とした場合と A^L = I を落とした場合は"
           "実際に破れる（仮定が効いている）")
          % (L, len(R), len(mats), len(roots)))

print("すべて通過")
