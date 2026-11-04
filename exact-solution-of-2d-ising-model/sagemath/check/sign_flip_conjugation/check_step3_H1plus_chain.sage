# 対象ラベル: sign_flip_conjugation
# Step 3 の H_1^{(+)} の鎖を一行ずつ厳密に確かめる（M = 2, 3, 4, 5）。UXU^{-1} は (UX)U^{-1}、T_U(X) := (UX)U^{-1}。
#   UH_1^{(+)}U^{-1} = U(Σ_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1)U^{-1}             （def_H1_plus）
#                    = T_U(Σ_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1)                   （T_B の定義）
#                    = T_U(Σ_{m=1}^{M-1} Y_mZ_{m+1}) - T_U(Y_MZ_1)              （matrix_conjugation_preserves_difference）
#                    = Σ_{m=1}^{M-1} T_U(Y_mZ_{m+1}) - T_U(Y_MZ_1)              （matrix_conjugation_preserves_finite_sum）
#                    = Σ_{m=1}^{M-1} U(Y_mZ_{m+1})U^{-1} - U(Y_MZ_1)U^{-1}      （T_B の定義を各項と引く項に）
#                    = Σ_{m=1}^{M-1} (-(Y_mZ_{m+1})) - (-(Y_MZ_1))              （上の U(Y_jZ_k)U^{-1} = -(Y_jZ_k)）
#                    = (-Σ_{m=1}^{M-1} Y_mZ_{m+1}) - (-(Y_MZ_1))                （finite_sum_of_negated_matrices）
#                    = -(Σ_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1)                     （difference_of_negated_matrices）
#                    = -H_1^{(+)}                                               （def_H1_plus）
# 有限和は def_finite_sum_of_matrices のとおり左から足す。差は def_matrix_difference のとおり成分ごと。
# 項の鎖 U(Y_jZ_k)U^{-1} = -(Y_jZ_k) の 5 行も全ての j, k で確かめる。
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



def sub(A, B):
    # def_matrix_difference: 成分ごとの差
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: A[r, c] - B[r, c])


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
    # Step 2 の結論（check_step2_Z_Y_chains.sage が鎖を確かめた値）
    for m in range(1, M + 1):
        assert T(Z[m]) == neg(Z[m]) and T(Y[m]) == Y[m]
    # 項の鎖 U(Y_jZ_k)U^{-1} = -(Y_jZ_k)
    for j in range(1, M + 1):
        for k in range(1, M + 1):
            term = [
                (U * (Y[j] * Z[k])) * Uinv,
                T(Y[j] * Z[k]),
                T(Y[j]) * T(Z[k]),
                ((U * Y[j]) * Uinv) * ((U * Z[k]) * Uinv),
                Y[j] * neg(Z[k]),
                neg(Y[j] * Z[k]),
            ]
            assert all(c == term[0] for c in term), (M, j, k)
            count += len(term) - 1
    S = fsum([Y[m] * Z[m + 1] for m in range(1, M)])   # Σ_{m=1}^{M-1} Y_mZ_{m+1}（M - 1 ≥ 1）
    W = Y[M] * Z[1]
    H1p = sub(S, W)                                     # def_H1_plus
    chain = [
        (U * H1p) * Uinv,
        (U * sub(fsum([Y[m] * Z[m + 1] for m in range(1, M)]), W)) * Uinv,
        T(sub(S, W)),
        sub(T(S), T(W)),
        sub(fsum([T(Y[m] * Z[m + 1]) for m in range(1, M)]), T(W)),
        sub(fsum([(U * (Y[m] * Z[m + 1])) * Uinv for m in range(1, M)]), (U * W) * Uinv),
        sub(fsum([neg(Y[m] * Z[m + 1]) for m in range(1, M)]), neg(W)),
        sub(neg(fsum([Y[m] * Z[m + 1] for m in range(1, M)])), neg(W)),
        neg(sub(S, W)),
        neg(H1p),
    ]
    assert all(c == chain[0] for c in chain), M
    count += len(chain) - 1

# 否定コントロール（M = 3）: difference_of_negated_matrices の行で (-A) - (-B) を -(A + B) と取り違えると
# 右端 -H_1^{(+)} と一致しない（引く項 Y_MZ_1 は零行列でない）。また項の鎖の 4 行目で Step 2 の符号を取り違えて
# UZ_kU^{-1} = +Z_k とすると、その行は Y_jZ_k になり -(Y_jZ_k) と一致しない。
M = 3
Id = kron([id2] * M)
sig = {(a, k): kron([pauli[a] if m == k else id2 for m in range(1, M + 1)]) for a in "xyz" for k in range(1, M + 1)}
Zs = {1: sig[("z", 1)], 2: sig[("x", 1)] * sig[("z", 2)], 3: sig[("x", 1)] * sig[("x", 2)] * sig[("z", 3)]}
Ys = {1: sig[("y", 1)], 2: sig[("x", 1)] * sig[("y", 2)], 3: sig[("x", 1)] * sig[("x", 2)] * sig[("y", 3)]}
S = fsum([Ys[m] * Zs[m + 1] for m in range(1, M)])
W = Ys[M] * Zs[1]
H1p = sub(S, W)
assert W != 0
assert neg(S + W) != neg(H1p)
for j in range(1, M + 1):
    for k in range(1, M + 1):
        assert Ys[j] * Zs[k] != neg(Ys[j] * Zs[k])
print("PASS sign_flip_conjugation Step 3 の H_1^{(+)} の鎖と項の鎖: %d 段" % count)
