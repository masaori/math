# 対象ラベル: claim_entry_of_matrix_times_creation_operator_matrix
# c_j を def_creation_operator_matrix の成分の式どおりに作り、成分が不定元の行列 A（QQ 上の多項式環）について、
# M=1,2,3 のすべての j, S, U で、証明の各行の等式と主張の式を確かめる。
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

for M in range(1, 4):
    P = power_set(M)
    names = ["a_%d_%d" % (s, t) for s in range(len(P)) for t in range(len(P))]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    A = {(P[s], P[t]): g[s * len(P) + t] for s in range(len(P)) for t in range(len(P))}
    for j in range(1, M + 1):
        c = {(S, T): (sign(N(j, T)) if (j not in T and S == T | {j}) else 0) for S in P for T in P}
        for S in P:
            for U in P:
                lhs = sum(A[(S, T)] * c[(T, U)] for T in P)      # 行列の積の定義
                if j in U:
                    for T in P:                                   # j∈U の準備の等式
                        assert c[(T, U)] == 0
                        assert A[(S, T)] * c[(T, U)] == (0 * 1) * 1
                    assert lhs == 0
                else:
                    Rset = U | {j}
                    for T in P:                                   # j∉U の二つの準備の等式
                        assert c[(T, U)] == delta(Rset, T) * sign(N(j, U))
                        r_T = A[(S, T)] * sign(N(j, U))
                        assert A[(S, T)] * c[(T, U)] == delta(Rset, T) * r_T
                    assert sum(delta(Rset, T) * A[(S, T)] * sign(N(j, U)) for T in P) == A[(S, Rset)] * sign(N(j, U))
                    assert lhs == A[(S, Rset)] * sign(N(j, U))
    print("M=%d: PASS" % M)
print("ALL PASS")
