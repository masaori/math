# 対象ラベル: sign_flip_conjugation
# Step 3 の「T_B の定義 → 乗法性 → T_B の定義」の三行と、Step 4 の二つの六行の鎖を一行ずつ厳密に確かめる
# （QQ(i) 上、M = 2, 3, 4、Step 3 は全ての j, k）。UXU^{-1} は本文どおり (UX)U^{-1} と組む。
#   U(Y_jZ_k)U^{-1} = T_U(Y_jZ_k) = T_U(Y_j)T_U(Z_k) = (UY_jU^{-1})(UZ_kU^{-1})   （conjugation_is_ring_homomorphism）
#   U(Z_jY_j)U^{-1} = T_U(Z_jY_j) = T_U(Z_j)T_U(Y_j) = (UZ_jU^{-1})(UY_jU^{-1})
#   US U^{-1} = (U(aH))U^{-1} = (a(UH))U^{-1} = a((UH)U^{-1}) = a(-H) = -(aH) = -S
#     （(a, H, S) = (iK_1, H_1^{(+)}, S_1^{(+)}), (iK_2^*, H_2, S_2)。K_1, K_2^* は正の有理数の代表値）
# 符号反転は def_matrix_negation、スカラー倍は def_matrix_scalar_multiple のとおり成分ごとに作る。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = identity_matrix(GAUSSIAN, 2)


def neg(A):
    # def_matrix_negation: (-A)_{ik} := -A_{ik}
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, k: -A[i, k])


def smul(a, A):
    # def_matrix_scalar_multiple: (aA)_{ik} := a A_{ik}
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, k: a * A[i, k])


K1 = QQ(3) / 7
K2s = QQ(5) / 11


def site(M, k, s):
    # def_site_pauli_matrices: 第 k サイト（1 始まり）に s、他は 2 次の単位行列のクロネッカー積
    out = matrix(GAUSSIAN, 1, 1, [1])
    for m in range(1, M + 1):
        out = out.tensor_product(s if m == k else id2)
    return out


count = 0
for M in range(2, 5):
    d = 2 ** M
    X = {k: site(M, k, sx) for k in range(1, M + 1)}
    Zs = {k: site(M, k, sz) for k in range(1, M + 1)}
    Ys = {k: site(M, k, sy) for k in range(1, M + 1)}

    def string(m):
        out = identity_matrix(GAUSSIAN, d)
        for k in range(1, m):
            out = out * X[k]
        return out

    Z = {m: string(m) * Zs[m] for m in range(1, M + 1)}
    Y = {m: string(m) * Ys[m] for m in range(1, M + 1)}
    E = identity_matrix(GAUSSIAN, d)
    for m in range(1, M + 1, 2):
        E = E * X[m]
    F = identity_matrix(GAUSSIAN, d)
    for m in range(1, M + 1):
        F = F * Zs[m]
    U = E * F
    Uinv = U.inverse()

    def T(A):
        # conjugation_is_ring_homomorphism の T_B(A) = B A B^{-1}（B = U）。(BA)B^{-1} と組む
        return (U * A) * Uinv

    for j in range(1, M + 1):
        for k in range(1, M + 1):
            chain = [
                (U * (Y[j] * Z[k])) * Uinv,
                T(Y[j] * Z[k]),
                T(Y[j]) * T(Z[k]),
                ((U * Y[j]) * Uinv) * ((U * Z[k]) * Uinv),
            ]
            assert all(c == chain[0] for c in chain), (M, j, k)
            count += len(chain) - 1
        chain = [
            (U * (Z[j] * Y[j])) * Uinv,
            T(Z[j] * Y[j]),
            T(Z[j]) * T(Y[j]),
            ((U * Z[j]) * Uinv) * ((U * Y[j]) * Uinv),
        ]
        assert all(c == chain[0] for c in chain), (M, j)
        count += len(chain) - 1

    # Step 4
    H1p = sum((Y[m] * Z[m + 1] for m in range(1, M)), matrix(GAUSSIAN, d, d)) - Y[M] * Z[1]
    H2 = sum((Z[m] * Y[m] for m in range(1, M + 1)), matrix(GAUSSIAN, d, d))
    # Step 3 の結論（前提として確かめる）
    assert (U * H1p) * Uinv == neg(H1p), M
    assert (U * H2) * Uinv == neg(H2), M
    for (a, H) in [(I_ * K1, H1p), (I_ * K2s, H2)]:
        S = smul(a, H)                                  # S := aH
        chain = [
            (U * S) * Uinv,                             # US U^{-1}
            (U * smul(a, H)) * Uinv,                    # S の定義
            smul(a, U * H) * Uinv,                      # scalar_multiple_factors_out_of_right_factor
            smul(a, (U * H) * Uinv),                    # scalar_multiple_factors_out_of_left_factor
            smul(a, neg(H)),                            # Step 3
            neg(smul(a, H)),                            # scalar_multiple_of_negated_matrix
            neg(S),                                     # S の定義
        ]
        assert all(c == chain[0] for c in chain), (M, a)
        count += len(chain) - 1

# 否定コントロール: Step 4 の符号を落とすと最後の行が一致しない
M = 2
Hc = site(M, 1, sy) * site(M, 2, sz)
assert smul(I_ * K1, neg(Hc)) != smul(I_ * K1, Hc)
print("PASS sign_flip_conjugation Step 3 の T_U の三行と Step 4: %d 段" % count)
