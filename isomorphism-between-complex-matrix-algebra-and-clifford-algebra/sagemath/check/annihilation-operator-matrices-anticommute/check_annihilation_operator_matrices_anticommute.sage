# 対象ラベル: claim_annihilation_operator_matrices_anticommute
# c_i と c_i^T を def_creation_operator_matrix・def_annihilation_operator_matrix の成分の式どおりに作り、
# M=1,2,3 のすべての k, l, S, U, T で準備の項の書き直しと等式 (★) を、すべての i, j（i=j を含む）, S, U で
# 本題の鎖の各行と主張の式を ZZ の厳密計算で確かめる。
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

for M in range(1, 4):
    P = power_set(M)
    idx = {T: n for n, T in enumerate(P)}
    def cmat(i):
        return matrix(ZZ, len(P), len(P), lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
    c = {i: cmat(i) for i in range(1, M + 1)}
    # def_annihilation_operator_matrix: (c_i^T)_{S,T} := (c_i)_{T,S}（転置の組み込み関数を使わず成分の式で作る）
    cT = {i: matrix(ZZ, len(P), len(P), lambda s, t: c[i][t, s]) for i in range(1, M + 1)}
    for k in range(1, M + 1):
        for l in range(1, M + 1):
            lhs = cT[k] * cT[l]
            rhs = c[l] * c[k]
            for S in P:
                for U in P:
                    s, u = idx[S], idx[U]
                    for T in P:
                        t = idx[T]
                        term = cT[k][s, t] * cT[l][t, u]
                        assert term == c[k][t, s] * c[l][u, t] == c[l][u, t] * c[k][t, s]   # 項の書き直し
                    assert lhs[s, u] == sum(cT[k][s, idx[T]] * cT[l][idx[T], u] for T in P)
                    assert lhs[s, u] == sum(c[l][u, idx[T]] * c[k][idx[T], s] for T in P)
                    assert lhs[s, u] == rhs[u, s]                                         # (★)
    for i in range(1, M + 1):
        for j in range(1, M + 1):
            ac = cT[i] * cT[j] + cT[j] * cT[i]
            acc = c[i] * c[j] + c[j] * c[i]
            for S in P:
                for U in P:
                    s, u = idx[S], idx[U]
                    line1 = (cT[i] * cT[j])[s, u] + (cT[j] * cT[i])[s, u]
                    line2 = (c[j] * c[i])[u, s] + (c[i] * c[j])[u, s]
                    line3 = (c[i] * c[j])[u, s] + (c[j] * c[i])[u, s]
                    assert ac[s, u] == line1 == line2 == line3 == acc[u, s] == 0
            assert ac == 0                                                                # 主張
    print("M=%d: PASS" % M)
# 否定コントロール: 生成作用素どうしでない組（c_i と c_i^T）では i=i の和が 0 にならないこと
c1 = matrix(ZZ, 2, 2, [0, 0, 1, 0]); assert c1 * c1.transpose() + c1.transpose() * c1 != 0
print("ALL PASS")
