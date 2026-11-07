# 対象ラベル: claim_creation_operator_matrices_anticommute
# c_i を def_creation_operator_matrix の成分の式どおりに作り、M=1,2,3 のすべての i, j（i=j を含む）, S, U で、
# 準備の等式 (★)、条件 C_{i,j} と C_{j,i} の同値、j<i と i<j の場合の鎖の各行、主張の式を ZZ の厳密計算で確かめる。
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

def cond(k, l, S, U):              # 条件 C_{k,l}(S,U)
    return k not in U and l not in U and k != l and S == (U | {l}) | {k}

for M in range(1, 4):
    P = power_set(M)
    idx = {T: n for n, T in enumerate(P)}
    def cmat(i):
        return matrix(ZZ, len(P), len(P), lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
    c = {i: cmat(i) for i in range(1, M + 1)}
    for k in range(1, M + 1):
        for l in range(1, M + 1):
            prod = c[k] * c[l]
            for S in P:
                for U in P:
                    e = prod[idx[S], idx[U]]
                    expected = sign(N(k, U | {l})) * sign(N(l, U)) if cond(k, l, S, U) else 0
                    assert e == expected                                    # (★)
    for i in range(1, M + 1):
        for j in range(1, M + 1):
            ac = c[i] * c[j] + c[j] * c[i]
            for S in P:
                for U in P:
                    assert cond(i, j, S, U) == cond(j, i, S, U)             # 条件の同値
                    if cond(i, j, S, U):
                        a, b = sign(N(i, U)), sign(N(j, U))
                        line1 = sign(N(i, U | {j})) * b + sign(N(j, U | {i})) * a
                        assert ac[idx[S], idx[U]] == line1
                        if j < i:
                            assert N(i, U | {j}) == N(i, U) + 1 and N(j, U | {i}) == N(j, U)
                            assert sign(N(i, U) + 1) == -1 * a
                            assert line1 == (-1 * a) * b + b * a == -1 * (a * b) + 1 * (a * b) == (1 + (-1)) * (a * b) == 0
                        else:
                            assert N(i, U | {j}) == N(i, U) and N(j, U | {i}) == N(j, U) + 1
                            assert sign(N(j, U) + 1) == -1 * b
                            assert line1 == a * b + (-1 * b) * a == 1 * (a * b) + (-1) * (a * b) == (1 + (-1)) * (a * b) == 0
                    assert ac[idx[S], idx[U]] == 0
            assert ac == 0                                                  # 主張
    print("M=%d: PASS" % M)
print("ALL PASS")
