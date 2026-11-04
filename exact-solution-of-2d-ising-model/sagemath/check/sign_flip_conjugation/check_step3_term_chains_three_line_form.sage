# 対象ラベル: sign_flip_conjugation
# Step 3 の二つの鎖を一行ずつ厳密に確かめる（QQ(i) 上、M = 2, 3, 4、全ての j, k）。
#   U(Y_j Z_k)U^{-1} = (U Y_j U^{-1})(U Z_k U^{-1})   （共役は積を保つ）
#                    = Y_j(-Z_k)                        （Step 2）
#                    = -(Y_j Z_k)                       （negation_factors_out_of_right_factor）
#   U(Z_j Y_j)U^{-1} = (U Z_j U^{-1})(U Y_j U^{-1})   （共役は積を保つ）
#                    = (-Z_j)Y_j                        （Step 2）
#                    = -(Z_j Y_j)                       （negation_factors_out_of_left_factor）
# 符号反転は def_matrix_negation のとおり成分ごとに作る（Sage の -A は使わない）。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = identity_matrix(GAUSSIAN, 2)


def neg(A):
    # def_matrix_negation: (-A)_{ik} := -A_{ik}
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, k: -A[i, k])


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

    def conj(A):
        return U * A * Uinv

    # Step 2 の結論（前提として確かめる）
    for m in range(1, M + 1):
        assert conj(Z[m]) == neg(Z[m]), (M, m)
        assert conj(Y[m]) == Y[m], (M, m)
    for j in range(1, M + 1):
        for k in range(1, M + 1):
            chain = [
                conj(Y[j] * Z[k]),
                conj(Y[j]) * conj(Z[k]),
                Y[j] * neg(Z[k]),
                neg(Y[j] * Z[k]),
            ]
            assert all(c == chain[0] for c in chain), (M, j, k)
            count += len(chain) - 1
        chain = [
            conj(Z[j] * Y[j]),
            conj(Z[j]) * conj(Y[j]),
            neg(Z[j]) * Y[j],
            neg(Z[j] * Y[j]),
        ]
        assert all(c == chain[0] for c in chain), (M, j)
        count += len(chain) - 1

# 否定コントロール: 符号を落とすと最後の行が一致しない
M = 2
assert (site(M, 1, sy) * site(M, 1, sz)) != neg(site(M, 1, sy) * site(M, 1, sz))
print("PASS sign_flip_conjugation Step 3: %d 段" % count)
