# 対象ラベル: sign_flip_conjugation
# Step 1 の鎖のうち、名前だけの根拠「パウリ行列の積」を参照に替えた 3 つを一行ずつ厳密に確かめる
# （QQ(i) 上、M = 2, 3, 4、全ての k）。
#   (A) σ_k^zσ_k^x = -(σ_k^xσ_k^z) の 10 行の鎖
#   (B) Fσ_k^xF^{-1} の鎖の 2 行目以降: (σ_k^zσ_k^x)σ_k^z = … = -σ_k^x（5 行）
#   (C) Fσ_k^zF^{-1} の鎖の 2 行目以降: (σ_k^zσ_k^z)σ_k^z = Iσ_k^z = σ_k^z（2 行）
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
        Sx = kron(at(M, k, sx, id2))
        Sz = kron(at(M, k, sz, id2))
        # 成分ごとの符号反転・-1 倍を Sage 組み込みの演算（独立な経路）と突き合わせる
        assert neg(sx * sz) == -(sx * sz) and smul(mo, sx * sz) == -(sx * sz)
        assert neg(Sx * Sz) == -(Sx * Sz) and smul(mo, Sx * Sz) == -(Sx * Sz)
        # (A) σ_k^zσ_k^x = -(σ_k^xσ_k^z)
        chainA = [
            Sz * Sx,
            kron(at(M, k, sz, id2)) * kron(at(M, k, sx, id2)),          # def_site_pauli_matrices
            kron(at(M, k, sz * sx, id2 * id2)),                          # kronecker_product_rule (1)
            kron(at(M, k, sz * sx, id2)),                                # identity_matrix_is_left_unit_of_mat_mult
            kron(at(M, k, neg(sx * sz), id2)),                           # pauli_matrix_products
            kron(at(M, k, smul(mo, sx * sz), id2)),                      # negation_is_scalar_multiple_by_minus_one
            smul(mo, kron(at(M, k, sx * sz, id2))),                      # kronecker_multilinear
            smul(mo, kron(at(M, k, sx * sz, id2 * id2))),                # identity_matrix_is_left_unit_of_mat_mult
            smul(mo, kron(at(M, k, sx, id2)) * kron(at(M, k, sz, id2))), # kronecker_product_rule (1)
            smul(mo, Sx * Sz),                                           # def_site_pauli_matrices
            neg(Sx * Sz),                                                # negation_is_scalar_multiple_by_minus_one
        ]
        assert all(c == chainA[0] for c in chainA), ("A", M, k)
        count += len(chainA) - 1
        # (B) Fσ_k^xF^{-1}
        chainB = [
            F * Sx * F,
            (Sz * Sx) * Sz,                                              # k 以外のサイトの因子は可換
            neg(Sx * Sz) * Sz,                                           # (A)
            neg((Sx * Sz) * Sz),                                         # negation_factors_out_of_left_factor
            neg(Sx * (Sz * Sz)),                                         # mat_mult_associative
            neg(Sx * Id),                                                # Step 0（σ_k^zσ_k^z = I）
            neg(Sx),                                                     # identity_matrix_is_right_unit_of_mat_mult
        ]
        assert all(c == chainB[0] for c in chainB), ("B", M, k)
        count += len(chainB) - 1
        # (C) Fσ_k^zF^{-1}
        chainC = [
            F * Sz * F,
            (Sz * Sz) * Sz,                                              # k 以外のサイトの因子は可換
            Id * Sz,                                                     # Step 0
            Sz,                                                          # identity_matrix_is_left_unit_of_mat_mult
        ]
        assert all(c == chainC[0] for c in chainC), ("C", M, k)
        count += len(chainC) - 1

# 否定コントロール: (A) の 4 行目で符号を落とすと、同じ判定で鎖が落ちる
M, k = 2, 1
bad = [
    kron(at(M, k, sz * sx, id2)),
    kron(at(M, k, sx * sz, id2)),
]
assert not all(c == bad[0] for c in bad)
print("PASS sign_flip_conjugation Step 1 の σ_k^zσ_k^x の鎖と Fσ_k^xF^{-1}・Fσ_k^zF^{-1} の鎖: %d 段" % count)
