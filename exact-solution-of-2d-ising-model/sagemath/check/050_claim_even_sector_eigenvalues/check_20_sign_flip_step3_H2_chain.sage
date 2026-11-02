# 対象ラベル: sign_flip_conjugation
# Step 3 の H_2 の鎖を一行ずつ厳密に確かめる（M = 2, 3, 4, 5）。UXU^{-1} は (UX)U^{-1}、T_U(X) := (UX)U^{-1}。
#   UH_2U^{-1} = U(Σ_{m=1}^{M} Z_mY_m)U^{-1}            （def_H2）
#             = T_U(Σ_{m=1}^{M} Z_mY_m)                  （T_B の定義）
#             = Σ_{m=1}^{M} T_U(Z_mY_m)                  （matrix_conjugation_preserves_finite_sum）
#             = Σ_{m=1}^{M} U(Z_mY_m)U^{-1}              （T_B の定義を各項に）
#             = Σ_{m=1}^{M} (-(Z_mY_m))                  （上の U(Z_jY_j)U^{-1} = -(Z_jY_j)）
#             = -Σ_{m=1}^{M} Z_mY_m                      （finite_sum_of_negated_matrices）
#             = -H_2                                     （def_H2）
# 有限和は def_finite_sum_of_matrices のとおり左から足す。項の鎖 U(Z_jY_j)U^{-1} = -(Z_jY_j) の 5 行も確かめる。
# 帰属: 行列の成分は QQ(i)（厳密計算）。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = matrix(GAUSSIAN, 2, 2, lambda k, l: 1 if k == l else 0)   # def_identity_matrix
pauli = {"x": sx, "y": sy, "z": sz}


def kron(factors):
    # def_kronecker: 多重添字 (s_1..s_M), (t_1..t_M) の成分は ∏_k (A_k)_{s_k t_k}
    M = len(factors)
    d = 2 ** M
    R = factors[0].base_ring()
    def entry(r, c):
        val = R(1)
        for k in range(M):
            s = (r >> (M - 1 - k)) & 1
            t = (c >> (M - 1 - k)) & 1
            val *= factors[k][s, t]
        return val
    out = matrix(R, d, d, entry)
    ref = matrix(R, 1, 1, [1])
    for A in factors:
        ref = ref.tensor_product(A)
    assert out == ref
    return out


def neg(A):
    # def_matrix_negation: 成分ごとに -z = (-1)·z（multiply_by_minus_one）
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: (-1) * A[r, c])


def fsum(Xs):
    # def_finite_sum_of_matrices: Σ_{j=1}^{1} X_j = X_1、Σ_{j=1}^{r+1} X_j = (Σ_{j=1}^{r} X_j) + X_{r+1}
    acc = Xs[0]
    for X in Xs[1:]:
        acc = acc + X
    return acc


count = 0
for M in range(2, 6):
    Id = kron([id2] * M)
    F = kron([sz] * M)
    E = kron([sx if m % 2 == 1 else id2 for m in range(1, M + 1)])
    U = E * F
    Uinv = F * E                     # Step 0 の U^{-1} = FE
    assert U * Uinv == Id and Uinv * U == Id

    def T(X):
        return (U * X) * Uinv

    sig = {(a, k): kron([pauli[a] if m == k else id2 for m in range(1, M + 1)])
           for a in "xyz" for k in range(1, M + 1)}
    Z = {}
    Y = {}
    for m in range(1, M + 1):
        prod = Id
        for k in range(1, m):
            prod = prod * sig[("x", k)]
        Z[m] = prod * sig[("z", m)]                   # def_jordan_wigner_Z_matrices
        Y[m] = prod * sig[("y", m)]                   # def_jordan_wigner_Y_matrices
    # Step 2 の結論（check_19 が鎖を確かめた値）
    for m in range(1, M + 1):
        assert T(Z[m]) == neg(Z[m]) and T(Y[m]) == Y[m]
    # 項の鎖 U(Z_jY_j)U^{-1} = -(Z_jY_j)
    for j in range(1, M + 1):
        term = [
            (U * (Z[j] * Y[j])) * Uinv,
            T(Z[j] * Y[j]),
            T(Z[j]) * T(Y[j]),
            ((U * Z[j]) * Uinv) * ((U * Y[j]) * Uinv),
            neg(Z[j]) * Y[j],
            neg(Z[j] * Y[j]),
        ]
        assert all(c == term[0] for c in term), (M, j)
        count += len(term) - 1
    H2 = fsum([Z[m] * Y[m] for m in range(1, M + 1)])  # def_H2
    chain = [
        (U * H2) * Uinv,
        (U * fsum([Z[m] * Y[m] for m in range(1, M + 1)])) * Uinv,
        T(fsum([Z[m] * Y[m] for m in range(1, M + 1)])),
        fsum([T(Z[m] * Y[m]) for m in range(1, M + 1)]),
        fsum([(U * (Z[m] * Y[m])) * Uinv for m in range(1, M + 1)]),
        fsum([neg(Z[m] * Y[m]) for m in range(1, M + 1)]),
        neg(fsum([Z[m] * Y[m] for m in range(1, M + 1)])),
        neg(H2),
    ]
    assert all(c == chain[0] for c in chain), M
    count += len(chain) - 1

# 否定コントロール（M = 3）: 項の鎖の 4 行目で Step 2 の符号を取り違えて UZ_jU^{-1} = +Z_j とすると、
# その行は Z_jY_j になり、5 行目以降の -(Z_jY_j) と一致しない。和を取った Σ Z_mY_m も右端 -H_2 と一致しない
M = 3
Id = kron([id2] * M)
F = kron([sz] * M)
E = kron([sx, id2, sx])
U = E * F
Uinv = F * E
sig = {(a, k): kron([pauli[a] if m == k else id2 for m in range(1, M + 1)]) for a in "xyz" for k in range(1, M + 1)}
Zs = [Id * sig[("z", 1)], sig[("x", 1)] * sig[("z", 2)], sig[("x", 1)] * sig[("x", 2)] * sig[("z", 3)]]
Ys = [Id * sig[("y", 1)], sig[("x", 1)] * sig[("y", 2)], sig[("x", 1)] * sig[("x", 2)] * sig[("y", 3)]]
wrong_rows = []
for k in range(3):
    right = ((U * Zs[k]) * Uinv) * ((U * Ys[k]) * Uinv)
    wrong = Zs[k] * ((U * Ys[k]) * Uinv)               # UZ_jU^{-1} を +Z_j と取り違えた 4 行目
    assert right == neg(Zs[k] * Ys[k])
    assert wrong != neg(Zs[k] * Ys[k])
    wrong_rows.append(wrong)
H2 = fsum([Zs[k] * Ys[k] for k in range(3)])
assert (U * H2) * Uinv == neg(H2)
assert fsum(wrong_rows) != neg(H2)
print("PASS sign_flip_conjugation Step 3 の H_2 の鎖と項の鎖: %d 段" % count)
