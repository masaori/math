# 対象ラベル: claim_square_of_annihilation_operator_matrix_is_zero
# c_i^T を (c_i^T)_{S,T}:=(c_i)_{T,S} で作り、M=1,2,3 のすべての i, S, U で、(c_i^T c_i^T)_{S,U}=(c_i c_i)_{U,S} と、主張 c_i^T c_i^T = 0 を
# ZZ の厳密計算で確かめる。
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

def creation_matrices(M, P, R=ZZ):  # def_creation_operator_matrix
    return {i: matrix(R, len(P), len(P), lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
            for i in range(1, M + 1)}

for M in range(1, 4):
    P = power_set(M)
    n = len(P)
    c = creation_matrices(M, P)
    for i in range(1, M + 1):
        ct = matrix(ZZ, n, n, lambda s, t: c[i][t, s])                          # def_annihilation_operator_matrix
        lhs = ct * ct
        rhs = c[i] * c[i]
        for s in range(n):
            for u in range(n):
                assert sum(ct[s, t] * ct[t, u] for t in range(n)) == sum(c[i][u, t] * c[i][t, s] for t in range(n))  # 項の書き直し
                assert lhs[s, u] == rhs[u, s]
        assert lhs == 0                                                         # 主張
    print("M=%d: PASS" % M)
print("ALL PASS")
