# 対象ラベル: sign_flip_conjugation
# Step 0 の鎖 σ_m^aσ_m^a = I_{Mat(2^{M_col},C)}（a ∈ {x, z}）の 5 行を一行ずつ厳密に確かめる
# （QQ(i) 上、M = 2, 3, 4、全ての m）。
#   σ_m^aσ_m^a
#   = (I⊠…⊠σ^a⊠…⊠I)(I⊠…⊠σ^a⊠…⊠I)        （def_site_pauli_matrices）
#   = (II)⊠…⊠(σ^aσ^a)⊠…⊠(II)                （kronecker_product_rule (1)）
#   = (II)⊠…⊠I⊠…⊠(II)                       （pauli_matrix_products の σ^aσ^a = I）
#   = I⊠…⊠I⊠…⊠I                             （identity_matrix_is_left_unit_of_mat_mult）
#   = I_{Mat(2^{M_col},C)}                    （kronecker_product_rule (2)）
# クロネッカー積は def_kronecker の成分の式（因子の成分の積）で自前に作り、Sage の tensor_product と突き合わせる。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = matrix(GAUSSIAN, 2, 2, lambda k, l: 1 if k == l else 0)   # def_identity_matrix


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


count = 0
for M in range(2, 5):
    d = 2 ** M
    Id = matrix(GAUSSIAN, d, d, lambda k, l: 1 if k == l else 0)
    for s in [sx, sz]:
        for m in range(1, M + 1):
            site = [s if k == m else id2 for k in range(1, M + 1)]
            sig = kron(site)                                       # σ_m^a
            chain = [
                sig * sig,
                kron(site) * kron(site),                           # def_site_pauli_matrices
                kron([(s * s) if k == m else (id2 * id2) for k in range(1, M + 1)]),   # kronecker_product_rule (1)
                kron([id2 if k == m else (id2 * id2) for k in range(1, M + 1)]),       # pauli_matrix_products
                kron([id2 for k in range(1, M + 1)]),              # identity_matrix_is_left_unit_of_mat_mult
                Id,                                                # kronecker_product_rule (2)
            ]
            assert all(c == chain[0] for c in chain), (M, m)
            count += len(chain) - 1

# 否定コントロール: m 番目の因子の積を σ^xσ^y（≠ I）にすると、同じ判定で鎖が落ちる
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
M = 2
bad = [
    kron([sx, id2]) * kron([sy, id2]),
    kron([sx * sy, id2 * id2]),
    matrix(GAUSSIAN, 4, 4, lambda k, l: 1 if k == l else 0),
]
assert not all(c == bad[0] for c in bad)
print("PASS sign_flip_conjugation Step 0 の σ_m^aσ_m^a = I の鎖: %d 段" % count)
