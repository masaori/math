# 対象ラベル: iH_is_real_symmetric
# Step 1 の H_2・S_2 の鎖と Step 2 の S_1^{(+)} の鎖を一行ずつ厳密に確かめる（M = 2, 3, 4, 5）。
#   H_2 = Σ_m Z_mY_m = Σ_m ((-i)σ_m^x) = (-i)Σ_m σ_m^x
#   S_2 = (iK_2^*)H_2 = (iK_2^*)((-i)Σσ^x) = ((iK_2^*)(-i))Σσ^x = (i(K_2^*(-i)))Σσ^x = (i((-i)K_2^*))Σσ^x
#       = ((i(-i))K_2^*)Σσ^x = (1·K_2^*)Σσ^x = K_2^*Σσ^x
#   S_1^{(+)} = (iK_1)H_1^{(+)} = (iK_1)(ΣY_mZ_{m+1} - Y_MZ_1) = (iK_1)(Σ((-i)σ^zσ^z) - Y_MZ_1) = (iK_1)(Σ((-i)σ^zσ^z) - (-i)G) = (iK_1)((-i)Σσ^zσ^z - (-i)G)
#       = (iK_1)((-i)(Σσ^zσ^z - G)) = ((iK_1)(-i))(Σσ^zσ^z - G) = … = (1·K_1)(Σσ^zσ^z - G) = K_1(Σσ^zσ^z - G) = K_1Σσ^zσ^z - K_1G
# スカラー倍・和・差・有限和は本文の定義どおり成分から組み、主張の両端は Sage の行列演算（独立な経路）とも比べる。
# ℂ の積の結合律・交換律・単位元の行は、成分を可換な多項式環に置くので構成上かならず一致する（写し間違いの検出は他の行が担う）。
# 帰属: 成分は QQ(i)[K_1, K_2^*]（K_1, K_2^* は不定元。不定元で成り立つ等号は任意の実数を代入しても成り立つ）。厳密計算。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
P = PolynomialRing(GAUSSIAN, ["K1", "K2s"])
K1, K2s = P.gens()
iu = P(I_)
sx = matrix(P, [[0, 1], [1, 0]])
sy = matrix(P, [[0, -iu], [iu, 0]])
sz = matrix(P, [[1, 0], [0, -1]])
id2 = matrix(P, 2, 2, lambda k, l: 1 if k == l else 0)


def kron(factors):
    out = matrix(P, 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def scal(a, A):          # def_matrix_scalar_multiple
    return matrix(P, A.nrows(), A.ncols(), lambda r, c: P(a) * A[r, c])


def msum(A, B):          # def_matrix_sum
    return matrix(P, A.nrows(), A.ncols(), lambda r, c: A[r, c] + B[r, c])


def mdiff(A, B):         # def_matrix_difference
    return matrix(P, A.nrows(), A.ncols(), lambda r, c: A[r, c] - B[r, c])


def fsum(Xs):            # def_finite_sum_of_matrices（左から足す）
    acc = Xs[0]
    for X in Xs[1:]:
        acc = msum(acc, X)
    return acc


def check_chain(lines, tag):
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (tag, t)


count = 0
for M in range(2, 6):
    def site(a, m):
        return kron([a if k == m else id2 for k in range(1, M + 1)])
    def prod(ms):
        out = kron([id2] * M)
        for X in ms:
            out = out * X
        return out
    Z = {m: prod([site(sx, j) for j in range(1, m)] + [site(sz, m)]) for m in range(1, M + 1)}
    Y = {m: prod([site(sx, j) for j in range(1, m)] + [site(sy, m)]) for m in range(1, M + 1)}
    G = prod([site(sy, 1)] + [site(sx, j) for j in range(2, M)] + [site(sy, M)])
    H2 = fsum([Z[m] * Y[m] for m in range(1, M + 1)])                                      # def_H2
    H1p = mdiff(fsum([Y[m] * Z[m + 1] for m in range(1, M)]), Y[M] * Z[1])                # def_H1_plus
    mi = -iu
    Sx = fsum([site(sx, m) for m in range(1, M + 1)])
    Szz = fsum([site(sz, m) * site(sz, m + 1) for m in range(1, M)])
    # 前提: 上で得た Z_mY_m = (-i)σ_m^x、Y_mZ_{m+1} = (-i)σ_m^zσ_{m+1}^z、Y_MZ_1 = (-i)G
    for m in range(1, M + 1):
        assert Z[m] * Y[m] == scal(mi, site(sx, m))
    for m in range(1, M):
        assert Y[m] * Z[m + 1] == scal(mi, site(sz, m) * site(sz, m + 1))
    assert Y[M] * Z[1] == scal(mi, G)
    # Step 1 の H_2 の鎖
    h2 = [H2,
          fsum([scal(mi, site(sx, m)) for m in range(1, M + 1)]),   # 上で得た Z_mY_m
          scal(mi, Sx)]                                             # finite_sum_of_scalar_multiples
    check_chain(h2, ("H2", M))
    # Step 1 の S_2 の鎖
    s2 = [scal(iu * K2s, H2),                     # S_2 の定義
          scal(iu * K2s, scal(mi, Sx)),           # 上で得た H_2 の表示
          scal((iu * K2s) * mi, Sx),              # scalar_multiple_is_associative
          scal(iu * (K2s * mi), Sx),              # 積の結合律
          scal(iu * (mi * K2s), Sx),              # 積の交換律
          scal((iu * mi) * K2s, Sx),              # 積の結合律
          scal(P(1) * K2s, Sx),                   # i(-i) = 1
          scal(K2s, Sx)]                          # 乗法の単位元
    check_chain(s2, ("S2", M))
    assert (iu * K2s) * H2 == K2s * sum(site(sx, m) for m in range(1, M + 1)) == s2[0]
    # Step 2 の S_1^{(+)} の鎖
    D = mdiff(Szz, G)
    s1 = [scal(iu * K1, H1p),                                                                   # S_1^{(+)} の定義
          scal(iu * K1, mdiff(fsum([Y[m] * Z[m + 1] for m in range(1, M)]), Y[M] * Z[1])),       # def_H1_plus
          scal(iu * K1, mdiff(fsum([scal(mi, site(sz, m) * site(sz, m + 1)) for m in range(1, M)]), Y[M] * Z[1])),  # 上で得た Y_mZ_{m+1} を各項へ
          scal(iu * K1, mdiff(fsum([scal(mi, site(sz, m) * site(sz, m + 1)) for m in range(1, M)]), scal(mi, G))),  # 上で得た Y_MZ_1 = (-i)G
          scal(iu * K1, mdiff(scal(mi, Szz), scal(mi, G))),                                     # finite_sum_of_scalar_multiples
          scal(iu * K1, scal(mi, D)),                                                           # scalar_multiple_distributes_over_matrix_difference（右辺から左辺）
          scal((iu * K1) * mi, D),                                                              # scalar_multiple_is_associative
          scal(iu * (K1 * mi), D),                                                              # 積の結合律
          scal(iu * (mi * K1), D),                                                              # 積の交換律
          scal((iu * mi) * K1, D),                                                              # 積の結合律
          scal(P(1) * K1, D),                                                                   # i(-i) = 1
          scal(K1, D),                                                                          # 乗法の単位元
          mdiff(scal(K1, Szz), scal(K1, G))]                                                    # scalar_multiple_distributes_over_matrix_difference
    check_chain(s1, ("S1plus", M))
    assert (iu * K1) * H1p == K1 * sum(site(sz, m) * site(sz, m + 1) for m in range(1, M)) - K1 * G == s1[0]
    # 対照: 境界項の符号を取り違えた K_1Σσ^zσ^z + K_1G とは一致しない
    assert s1[0] != msum(scal(K1, Szz), scal(K1, G))
    count += 1
print(f"checked the H_2, S_2 and S_1^(+) chains for M = 2,...,5 ({count} sizes)")
print("RESULT: PASS")
