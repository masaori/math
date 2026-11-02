# 対象ラベル: sign_flip_conjugation
# Step 1 の σ_k^pσ_k^q の鎖と Fσ_k^yF^{-1} の鎖を一行ずつ厳密に確かめる
# （QQ(i) 上、M = 2, 3, 4、全ての k）。
#   (A) σ_k^pσ_k^q = -(σ_k^qσ_k^p) の 10 行の鎖を (p, q) = (z, x), (y, z) の両方で
#   (B) Fσ_k^yF^{-1} の鎖: (σ_k^zσ_k^y)σ_k^z = σ_k^z(σ_k^yσ_k^z) = … = -σ_k^y（7 行）
# 1 行目（k 以外のサイトの因子は可換）も、F = ∏σ_m^z と F^{-1} = F（Step 0）から組んで右辺と比べる。
# クロネッカー積は def_kronecker の成分の式（因子の成分の積）で自前に作り、Sage の tensor_product と突き合わせる。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = matrix(GAUSSIAN, 2, 2, lambda k, l: 1 if k == l else 0)   # def_identity_matrix
mo = GAUSSIAN(-1)                                                # -1_C


def kron(factors):
    # def_kronecker: 多重添字 (s_1..s_M), (t_1..t_M) の成分は ∏_k (A_k)_{s_k t_k}
    M = len(factors)
    d = 2 ** M
    def entry(r, c):
        val = GAUSSIAN(1)
        for k in range(M):
            s = (r >> (M - 1 - k)) & 1
            t = (c >> (M - 1 - k)) & 1
            val *= factors[k][s, t]
        return val
    out = matrix(GAUSSIAN, d, d, entry)
    ref = matrix(GAUSSIAN, 1, 1, [1])
    for A in factors:
        ref = ref.tensor_product(A)
    assert out == ref
    return out


def neg(A):
    # def_matrix_negation: 成分ごとの -A_ij = (-1)·A_ij（multiply_by_minus_one）
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, j: mo * A[i, j])


def smul(c, A):
    # def_matrix_scalar_multiple
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, j: c * A[i, j])


def at(M, k, A, other):
    return [A if m == k else other for m in range(1, M + 1)]


count = 0
for M in range(2, 5):
    d = 2 ** M
    Id = matrix(GAUSSIAN, d, d, lambda k, l: 1 if k == l else 0)
    F = Id
    for m in range(1, M + 1):
        F = F * kron(at(M, m, sz, id2))                   # F = ∏_m σ_m^z（本文の定義どおりサイトの行列の積）
    assert F == kron([sz] * M)
    assert F * F == Id                                    # Step 0 より F^{-1} = F
    for k in range(1, M + 1):
        S = {
            "x": kron(at(M, k, sx, id2)),
            "y": kron(at(M, k, sy, id2)),
            "z": kron(at(M, k, sz, id2)),
        }
        two = {"x": sx, "y": sy, "z": sz}
        # (A) σ_k^pσ_k^q = -(σ_k^qσ_k^p)
        for a, b in [("z", "x"), ("y", "z")]:
            A, B = two[a], two[b]
            assert A * B == neg(B * A)                                   # pauli_matrix_products の向き
            chainA = [
                S[a] * S[b],
                kron(at(M, k, A, id2)) * kron(at(M, k, B, id2)),          # def_site_pauli_matrices
                kron(at(M, k, A * B, id2 * id2)),                          # kronecker_product_rule (1)
                kron(at(M, k, A * B, id2)),                                # identity_matrix_is_left_unit_of_mat_mult
                kron(at(M, k, neg(B * A), id2)),                           # pauli_matrix_products
                kron(at(M, k, smul(mo, B * A), id2)),                      # negation_is_scalar_multiple_by_minus_one
                smul(mo, kron(at(M, k, B * A, id2))),                      # kronecker_multilinear
                smul(mo, kron(at(M, k, B * A, id2 * id2))),                # identity_matrix_is_left_unit_of_mat_mult
                smul(mo, kron(at(M, k, B, id2)) * kron(at(M, k, A, id2))), # kronecker_product_rule (1)
                smul(mo, S[b] * S[a]),                                     # def_site_pauli_matrices
                neg(S[b] * S[a]),                                          # negation_is_scalar_multiple_by_minus_one
            ]
            assert all(c == chainA[0] for c in chainA), ("A", a, b, M, k)
            count += len(chainA) - 1
        Sy, Sz = S["y"], S["z"]
        # (B) Fσ_k^yF^{-1}
        chainB = [
            F * Sy * F,
            (Sz * Sy) * Sz,                                              # k 以外のサイトの因子は可換
            Sz * (Sy * Sz),                                              # mat_mult_associative
            Sz * neg(Sz * Sy),                                           # (A) を (p, q) = (y, z) で
            neg(Sz * (Sz * Sy)),                                         # negation_factors_out_of_right_factor
            neg((Sz * Sz) * Sy),                                         # mat_mult_associative
            neg(Id * Sy),                                                # Step 0（σ_k^zσ_k^z = I）
            neg(Sy),                                                     # identity_matrix_is_left_unit_of_mat_mult
        ]
        assert all(c == chainB[0] for c in chainB), ("B", M, k)
        count += len(chainB) - 1

# 否定コントロール: (B) の 4 行目で符号を落とすと、同じ判定で鎖が落ちる
M, k = 2, 1
Sy = kron(at(M, k, sy, id2))
Sz = kron(at(M, k, sz, id2))
bad = [Sz * (Sy * Sz), Sz * (Sz * Sy)]
assert not all(c == bad[0] for c in bad)
print("PASS sign_flip_conjugation Step 1 の σ_k^pσ_k^q の鎖（(z,x)・(y,z)）と Fσ_k^yF^{-1} の鎖: %d 段" % count)
