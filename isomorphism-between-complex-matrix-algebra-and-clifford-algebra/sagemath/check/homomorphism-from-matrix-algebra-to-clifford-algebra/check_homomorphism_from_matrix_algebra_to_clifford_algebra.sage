# 対象ラベル: claim_product_of_matrix_unit_elements_of_split_clifford_algebra, claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit,
#   claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism, claim_homomorphism_to_matrix_algebra_on_matrix_unit_element,
#   claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity,
#   claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements, claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix,
#   claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements, claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix,
#   theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra
# クリフォード代数の中の等式を、準同型 Φ（Φ(a†_i)=c_i、Φ(a_i)=c_i^T）による行列の像で、整数行列の厳密計算で確かめる。
# 像での確認であり、クリフォード代数の中の等式の証明ではない。M=1,2,3。
from itertools import combinations

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def N(i, T):                       # def_count_of_subset_elements_below_index
    if i == 1:
        return 0
    return N(i - 1, T) + 1 if (i - 1) in T else N(i - 1, T)

def sign(n):                       # def_sign_of_nonnegative_integer
    return ZZ(1) if n == 0 else ZZ(-1) * sign(n - 1)

def delta(a, b):                   # def_kronecker_delta
    return ZZ(1) if a == b else ZZ(0)

def oprod(factors, I):             # def_ordered_product_in_algebra（左から右へ掛ける）
    r = I
    for f in factors:
        r = r * f
    return r

for M in range(1, 4):
    P = power_set(M)
    n = len(P)
    idx = {S: k for k, S in enumerate(P)}
    I = identity_matrix(ZZ, n)
    Z0 = zero_matrix(ZZ, n)
    c = {i: matrix(ZZ, n, n, lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
         for i in range(1, M + 1)}                                                 # def_creation_operator_matrix
    ct = {i: matrix(ZZ, n, n, lambda s, t: c[i][t, s]) for i in c}                # def_annihilation_operator_matrix
    E = lambda S, T: matrix(ZZ, n, n, lambda u, v: delta(S, P[u]) * delta(T, P[v]))  # def_matrix_unit
    empty = frozenset()
    Y = lambda S: [c[t] if t in S else I for t in range(1, M + 1)]                  # Φ(y^S_t)=Y_t
    Zm = lambda T: {t: (ct[t] if t in T else I) for t in range(1, M + 1)}          # Φ(z^T_t)=Z_t
    W = lambda T: [Zm(T)[M + 1 - k] for k in range(1, M + 1)]                       # W_k=Z_{M+1-k}
    Ad = lambda S: oprod(Y(S), I)                                                   # Φ(a†_S)
    An = lambda T: oprod(W(T), I)                                                   # Φ(a_T)
    Pv = oprod([ct[i] * c[i] for i in range(1, M + 1)], I)                         # Φ(P)
    e = {(S, T): (Ad(S) * Pv) * An(T) for S in P for T in P}                        # Φ(e_{S,T})
    assert Pv == E(empty, empty)
    for S in P:
        assert Ad(S) * E(empty, empty) == E(S, empty)
        assert E(S, empty) * E(empty, empty) == E(S, empty)                         # 準備（ニ）
        assert E(empty, empty) * An(S) == E(empty, S)
    for S in P:
        for T in P:
            assert e[(S, T)] == E(S, T)                                             # Φ(e_{S,T})=E_{S,T}
            for U in P:
                for R in P:
                    assert e[(S, T)] * e[(U, R)] == delta(T, U) * e[(S, R)]         # 行列単位にあたる元の積の規則の像
    PsiImg = lambda F: sum((1 * sum((F[idx[S], idx[T]] * e[(S, T)] for T in P), Z0) for S in P), Z0)   # Φ(Ψ(F))
    set_random_seed(20261112 + M)
    for trial in range(3):
        F = random_matrix(ZZ, n, n, x=-4, y=5)
        G = random_matrix(ZZ, n, n, x=-4, y=5)
        assert PsiImg(F) == F                                                       # Φ∘Ψ=id
        assert PsiImg(F * G) == PsiImg(F) * PsiImg(G)                               # Ψ が乗法を保つことの像
        assert PsiImg(F + G) == PsiImg(F) + PsiImg(G) and PsiImg(3 * F) == 3 * PsiImg(F)
    assert PsiImg(I) == I                                                           # Ψ(1_B)=1_A の像
    for S in P:
        for T in P:
            assert PsiImg(E(S, T)) == e[(S, T)]                                     # Ψ(E_{S,T})=e_{S,T} の像
    for i in range(1, M + 1):
        for T in P:
            for S in P:                                                             # 列の和の証明の（イ）（ハ）の成分
                expected = sign(N(i, T)) * delta(T | {i}, S) if i not in T else 0
                assert c[i][idx[S], idx[T]] == expected
            col = sum((c[i][idx[S], idx[T]] * e[(S, T)] for S in P), Z0)
            assert col == c[i] * e[(T, T)]                                          # 生成作用素の行列の列の和の像
        for S in P:
            row = sum((ct[i][idx[S], idx[T]] * e[(S, T)] for T in P), Z0)
            assert row == e[(S, S)] * ct[i]                                         # 消滅作用素の行列の行の和の像
        assert sum((c[i] * e[(T, T)] for T in P), Z0) == c[i]                       # Ψ(c_i)=a†_i の像
        assert sum((e[(S, S)] * ct[i] for S in P), Z0) == ct[i]                     # Ψ(c_i^T)=a_i の像
        assert PsiImg(c[i]) == c[i] and PsiImg(ct[i]) == ct[i]                      # Ψ∘Φ が生成元で恒等写像であることの像
    # 否定コントロール
    if M >= 2:
        fwd = lambda T: oprod([Zm(T)[t] for t in range(1, M + 1)], I)               # a_T を番号順に掛けると符号が変わる
        assert any((Ad(S) * Pv) * fwd(T) != E(S, T) for S in P for T in P)
        assert any(sum((c[i][idx[S], idx[T]] * e[(S, T)] for S in P), Z0) != e[(T, T)] * c[i] for i in c for T in P)
    Fn = random_matrix(ZZ, n, n, x=-4, y=5)
    swapped = sum((sum((Fn[idx[S], idx[T]] * e[(T, S)] for T in P), Z0) for S in P), Z0)
    assert swapped == Fn.transpose()
    if Fn != Fn.transpose():
        assert swapped != Fn                                                        # e_{T,S} で作ると逆写像にならない
    assert sum((e[(S, S)] for S in P if S != empty), Z0) != I                       # 1 の分解から一項を抜くと I にならない
    print("M=%d: PASS" % M)
print("ALL PASS")
