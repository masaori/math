# 対象ラベル: claim_creation_and_annihilation_operator_matrices_anticommute
# c_i と c_i^T を def_creation_operator_matrix・def_annihilation_operator_matrix の成分の式どおりに作り、
# M=1,2,3 のすべての i, j（i=j を含む）, S, U で、右辺の成分 (♭)、準備の等式 (★1)(★2)、
# i=j での D1・D2 の同値、i≠j での D1・D2 と D の同値、D のもとでの集合の等式と鎖の各行、主張の式を ZZ の厳密計算で確かめる。
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

def delta(x, y):                   # def_kronecker_delta
    return ZZ(1) if x == y else ZZ(0)

negatives = 0
for M in range(1, 4):
    P = power_set(M)
    idx = {T: n for n, T in enumerate(P)}
    n = len(P)
    def cmat(i):
        return matrix(ZZ, n, n, lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
    c = {i: cmat(i) for i in range(1, M + 1)}
    cT = {i: matrix(ZZ, n, n, lambda s, t: c[i][t, s]) for i in range(1, M + 1)}   # (c_i^T)_{S,T}:=(c_i)_{T,S}
    I = identity_matrix(ZZ, n)
    for i in range(1, M + 1):
        for j in range(1, M + 1):
            A1 = c[i] * cT[j]
            A2 = cT[j] * c[i]
            lhs = A1 + A2
            rhs = delta(i, j) * I
            for S in P:
                Sp = frozenset(t for t in S if t != i)          # S'
                assert i not in Sp
                if i in S:
                    assert Sp | {i} == S                        # (♯)
                for U in P:
                    s, u = idx[S], idx[U]
                    assert rhs[s, u] == delta(i, j) * delta(S, U)                      # (♭)
                    D1 = (i in S) and (j not in Sp) and (U == Sp | {j})
                    D2 = (i not in U) and (j not in S) and (U | {i} == S | {j})
                    assert A1[s, u] == (sign(N(i, Sp)) * sign(N(j, Sp)) if D1 else 0)   # (★1)
                    assert A2[s, u] == (sign(N(j, S)) * sign(N(i, U)) if D2 else 0)     # (★2)
                    if i == j:
                        assert D1 == ((i in S) and U == S)
                        assert D2 == ((i not in S) and U == S)
                        if U == S:
                            assert sign(N(i, Sp)) ** 2 == 1 and sign(N(i, S)) ** 2 == 1
                    else:
                        D = (i in S) and (j not in S) and (U == Sp | {j})
                        assert D1 == D and D2 == D
                        if D:
                            assert S == Sp | {i} and U == Sp | {j} and j not in Sp
                            al, be = sign(N(i, Sp)), sign(N(j, Sp))
                            if j < i:
                                assert N(j, Sp | {i}) == N(j, Sp) and N(i, Sp | {j}) == N(i, Sp) + 1
                                assert sign(N(i, Sp) + 1) == -1 * al
                                assert lhs[s, u] == al * be + be * ((-1) * al) == (1 + (-1)) * (al * be) == 0
                            else:
                                assert N(j, Sp | {i}) == N(j, Sp) + 1 and N(i, Sp | {j}) == N(i, Sp)
                                assert sign(N(j, Sp) + 1) == -1 * be
                                assert lhs[s, u] == al * be + ((-1) * be) * al == (1 + (-1)) * (al * be) == 0
                            # 否定コントロール: 符号の打ち消しを落とした式 αβ+αβ は 0 にならない
                            assert al * be + al * be != 0
                            negatives += 1
                    assert lhs[s, u] == rhs[s, u]
            assert lhs == rhs                                                          # 主張
    print("M=%d: PASS" % M)
print("negative controls:", negatives)
print("ALL PASS")
