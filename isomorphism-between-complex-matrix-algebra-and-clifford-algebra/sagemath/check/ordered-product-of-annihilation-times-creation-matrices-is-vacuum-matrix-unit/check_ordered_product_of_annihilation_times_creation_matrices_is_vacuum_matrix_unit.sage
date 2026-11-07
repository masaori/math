# 対象ラベル: claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit
# c_i・c_i^T・E_{x,y}・単位行列を定義の成分の式どおりに ZZ 上の行列として作り、M=1,2,3 で、
# 準備 (star_1)・(star_2)、帰納法の各段 (Pi_m)_{S,U} = chi_m(S,U)、本題の後半の C_M の同値、主張 Pi_M = E_{∅,∅} を確かめる。
from itertools import combinations

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def N(i, T):                       # def_count_of_subset_elements_below_index の帰納的な式
    if i == 1:
        return 0
    return N(i - 1, T) + 1 if (i - 1) in T else N(i - 1, T)

def sign(n):                       # def_sign_of_nonnegative_integer の帰納的な式
    return 1 if n == 0 else -1 * sign(n - 1)

def delta(x, y):
    return 1 if x == y else 0

empty = frozenset()
negative_rejected = 0
for M in range(1, 4):
    P = power_set(M)
    n = len(P)
    idx = {S: k for k, S in enumerate(P)}
    def mat(f):
        return matrix(ZZ, n, n, lambda a, b: f(P[a], P[b]))
    def ent(A, S, U):
        return A[idx[S], idx[U]]
    c = {i: mat(lambda S, T, i=i: sign(N(i, T)) if (i not in T and S == T | {i}) else 0) for i in range(1, M + 1)}
    cT = {i: mat(lambda S, T, i=i: c[i][idx[T], idx[S]]) for i in range(1, M + 1)}   # def_annihilation_operator_matrix
    x = {i: cT[i] * c[i] for i in range(1, M + 1)}
    eta = lambda i, U: 1 if i not in U else 0
    Cm = lambda m, S, U: S == U and all(t not in S for t in range(1, m + 1))
    chi = lambda m, S, U: 1 if Cm(m, S, U) else 0
    # (star_1)
    for i in range(1, M + 1):
        for T in P:
            for U in P:
                assert ent(x[i], T, U) == delta(U, T) * eta(i, U)
                if i not in U:
                    cond = (i not in T) and (U | {i} == T | {i})
                    assert cond == (T == U)                             # 条件と T=U の同値
                    assert ent(cT[i], T, U | {i}) == ent(c[i], U | {i}, T)
    # (star_2) と C_m の同値
    for m in range(1, M + 1):
        for S in P:
            for U in P:
                assert Cm(m, S, U) == (Cm(m - 1, S, U) and m not in U)
                assert chi(m - 1, S, U) * eta(m, U) == chi(m, S, U)
    # 帰納法: Pi_0 = 1, Pi_m = Pi_{m-1} * x_m（def_ordered_product_in_algebra）
    Pi = identity_matrix(ZZ, n)
    for S in P:
        for U in P:
            assert ent(Pi, S, U) == chi(0, S, U)
    for m in range(1, M + 1):
        prev = Pi
        Pi = prev * x[m]
        for S in P:
            for U in P:
                r = {T: ent(prev, S, T) * eta(m, U) for T in P}
                for T in P:
                    assert ent(prev, S, T) * ent(x[m], T, U) == delta(U, T) * r[T]
                assert sum(delta(U, T) * r[T] for T in P) == r[U]
                assert ent(Pi, S, U) == chi(m, S, U)
    # 本題の後半
    E00 = mat(lambda u, v: delta(empty, u) * delta(empty, v))     # def_matrix_unit
    for S in P:
        for U in P:
            assert Cm(M, S, U) == (S == empty and U == empty)
    assert Pi == E00
    # 否定コントロール: 生成と消滅の順を入れ替えた c_i c_i^T の積は E_{∅,∅} にならない
    Q = identity_matrix(ZZ, n)
    for i in range(1, M + 1):
        Q = Q * (c[i] * cT[i])
    assert Q != E00
    negative_rejected += 1
    print("M=%d: PASS" % M)
print("negative controls rejected: %d" % negative_rejected)
print("ALL PASS")
