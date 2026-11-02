# 対象ラベル: sign_flip_conjugation
# Step 0 の可逆性の鎖を一行ずつ厳密に確かめる（QQ(i) 上、M = 2, 3, 4, 5）。
#   E_mE_m = σ^xσ^x = I（m 奇数）、E_mE_m = II = I（m 偶数）（E_m の定義、pauli_matrix_products / identity_matrix_is_left_unit_of_mat_mult）
#   FF = (σ^z⊠…⊠σ^z)(σ^z⊠…⊠σ^z)              （F の定義）
#      = (σ^zσ^z)⊠…⊠(σ^zσ^z)                  （kronecker_product_rule (1)）
#      = I⊠…⊠I                                （pauli_matrix_products の σ^zσ^z = I）
#      = I_{Mat(2^M,C)}                        （kronecker_product_rule (2)）
#   EE = (E_1⊠…⊠E_M)(E_1⊠…⊠E_M)               （E の定義）
#      = (E_1E_1)⊠…⊠(E_ME_M)                  （kronecker_product_rule (1)）
#      = I⊠…⊠I                                （上の E_mE_m = I）
#      = I_{Mat(2^M,C)}                        （kronecker_product_rule (2)）
#   U^{-1} = (EF)^{-1} = F^{-1}E^{-1} = FE^{-1} = FE（def_invertible_elements_of_R (ii)）:
#   (EF)(FE) = I と (FE)(EF) = I を def_invertible_elements_of_R (ii) の証明の 6 行ずつで確かめ、
#   Sage の逆行列 (EF)^{-1} とも突き合わせる。
# E・F は旧定義の行列の積 ∏_{m 奇数} σ_m^x・∏_m σ_m^z とも一致することを確かめる（定義の言い換えで行列が変わらないこと）。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
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
for M in range(2, 6):
    d = 2 ** M
    Id = matrix(GAUSSIAN, d, d, lambda k, l: 1 if k == l else 0)
    Em = [sx if m % 2 == 1 else id2 for m in range(1, M + 1)]
    for m in range(1, M + 1):
        # E_mE_m = σ^xσ^x = I（m 奇数）、E_mE_m = II = I（m 偶数）
        mid = sx * sx if m % 2 == 1 else id2 * id2
        chain = [Em[m - 1] * Em[m - 1], mid, id2]
        assert all(c == chain[0] for c in chain), (M, m)
        count += len(chain) - 1
    F = kron([sz] * M)
    E = kron(Em)
    # 旧定義（サイトの行列の積）との一致
    def site(A, m):
        return kron([A if k == m else id2 for k in range(1, M + 1)])
    Fold = Id
    Eold = Id
    for m in range(1, M + 1):
        Fold = Fold * site(sz, m)
        if m % 2 == 1:
            Eold = Eold * site(sx, m)
    assert F == Fold and E == Eold
    chainF = [F * F, kron([sz] * M) * kron([sz] * M), kron([sz * sz] * M), kron([id2] * M), Id]
    chainE = [E * E, kron(Em) * kron(Em), kron([A * A for A in Em]), kron([id2] * M), Id]
    for ch in (chainF, chainE):
        assert all(c == ch[0] for c in ch), M
        count += len(ch) - 1
    U = E * F
    h = F * E
    chain1 = [U * h, (E * F) * (F * E), ((E * F) * F) * E, (E * (F * F)) * E, (E * Id) * E, E * E, Id]
    chain2 = [h * U, (F * E) * (E * F), ((F * E) * E) * F, (F * (E * E)) * F, (F * Id) * F, F * F, Id]
    for ch in (chain1, chain2):
        assert all(c == ch[0] for c in ch), M
        count += len(ch) - 1
    assert U.inverse() == F.inverse() * E.inverse() == F * E.inverse() == F * E
    count += 3

# 否定コントロール: 因子に自乗が I でない σ^xσ^y を置くと、同じ判定で積が I にならない
M = 2
bad = kron([sx * sy, sz])
assert bad * bad != matrix(GAUSSIAN, 4, 4, lambda k, l: 1 if k == l else 0)
print("PASS sign_flip_conjugation Step 0 の E・F・U の可逆性の鎖: %d 段" % count)
