# 対象ラベル: claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit
# c_t・E_{x,y}・単位行列を定義の成分の式どおりに ZZ 上の行列として作り、M=1,2,3 のすべての S で、
# 準備 (star)、R^<m> の集合の等式、帰納法の各段 Pi_m E_{R,∅} = E_{R^<m>,∅}、主張 Pi_M E_{∅,∅} = E_{S,∅} を確かめる。
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
    I = identity_matrix(ZZ, n)
    c = {i: mat(lambda S, T, i=i: sign(N(i, T)) if (i not in T and S == T | {i}) else 0) for i in range(1, M + 1)}
    E = lambda x, y: mat(lambda u, v: delta(x, u) * delta(y, v))   # def_matrix_unit
    # 準備 (star): R のすべての元が m+1 以上なら c_m E_{R,∅} = E_{R∪{m},∅}。場合ごとの中間の値も確かめる
    for m in range(1, M + 1):
        for R in P:
            if not all(t >= m + 1 for t in R):
                continue
            assert m not in R and N(m, R) == 0
            L = c[m] * E(R, empty)
            for X in P:
                for U in P:
                    if m in X:
                        Xp = frozenset(t for t in X if t != m)
                        assert ent(L, X, U) == sign(N(m, Xp)) * ent(E(R, empty), Xp, U)
                        assert (Xp == R) == (X == R | {m})
                    else:
                        assert ent(L, X, U) == 0 and X != R | {m}
            assert L == E(R | {m}, empty)
    for S in P:
        y = {t: (c[t] if t in S else I) for t in range(1, M + 1)}
        sup = lambda R, m: frozenset(t for t in range(1, M + 1) if t in R or (t in S and t <= m))
        Pi = {0: I}
        for m in range(1, M + 1):
            Pi[m] = Pi[m - 1] * y[m]                # def_ordered_product_in_algebra
        for m in range(0, M + 1):
            for R in P:
                if not all(t >= m + 1 for t in R):
                    continue
                if m == 0:
                    assert sup(R, 0) == R
                elif m in S:
                    assert sup(R | {m}, m - 1) == sup(R, m)
                else:
                    assert sup(R, m - 1) == sup(R, m)
                assert Pi[m] * E(R, empty) == E(sup(R, m), empty)
        assert sup(empty, M) == S
        assert Pi[M] * E(empty, empty) == E(S, empty)
        # 否定コントロール: 逆順に掛けた積は、S が 2 元以上なら符号が変わり E_{S,∅} にならない
        Q = I
        for t in range(M, 0, -1):
            Q = Q * y[t]
        if len(S) >= 2 and len(S) % 4 in (2, 3):
            assert Q * E(empty, empty) != E(S, empty)
            negative_rejected += 1
    print("M=%d: PASS" % M)
print("negative controls rejected: %d" % negative_rejected)
