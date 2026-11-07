# 対象ラベル: claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices
# c_t・c_t^T・E_{x,y}・単位行列を定義の成分の式どおりに ZZ 上の行列として作り、M=1,2,3 のすべての T で、
# 準備 (star) と中間の式 (dagger)、T^<m> の集合の等式、帰納法の各段 E_{∅,∅} Pi_m = E_{∅,T^<m>}、主張 E_{∅,∅} Pi_M = E_{∅,T} を確かめる。
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
    cT = {i: mat(lambda S, T, i=i: ent(c[i], T, S)) for i in range(1, M + 1)}   # def_annihilation_operator_matrix
    E = lambda x, y: mat(lambda u, v: delta(x, u) * delta(y, v))                 # def_matrix_unit
    # 準備 (star): R のすべての元が s+1 以上なら E_{∅,R} c_s^T = E_{∅,R∪{s}}。(dagger) と二つの場合の値も確かめる
    for s in range(1, M + 1):
        for R in P:
            if not all(t >= s + 1 for t in R):
                continue
            assert s not in R and N(s, R) == 0
            L = E(empty, R) * cT[s]
            for X in P:
                for U in P:
                    assert ent(L, X, U) == delta(empty, X) * ent(c[s], U, R)          # (dagger)
                    if U == R | {s}:
                        assert ent(c[s], U, R) == sign(N(s, R)) == 1
                    else:
                        assert ent(c[s], U, R) == 0
            assert L == E(empty, R | {s})
    for T in P:
        z = {t: (cT[t] if t in T else I) for t in range(1, M + 1)}
        w = {k: z[M + 1 - k] for k in range(1, M + 1)}
        sub = lambda m: frozenset(t for t in range(1, M + 1) if t in T and t >= M + 1 - m)
        Pi = {0: I}
        for m in range(1, M + 1):
            Pi[m] = Pi[m - 1] * w[m]                # def_ordered_product_in_algebra
        assert sub(0) == empty
        for m in range(1, M + 1):
            s = M + 1 - m
            assert all(t >= s + 1 for t in sub(m - 1))
            if s in T:
                assert sub(m - 1) | {s} == sub(m)
            else:
                assert sub(m - 1) == sub(m)
        for m in range(0, M + 1):
            assert E(empty, empty) * Pi[m] == E(empty, sub(m))
        assert sub(M) == T
        assert E(empty, empty) * Pi[M] == E(empty, T)
        # 否定コントロール: 番号順 z_1 ... z_M に掛けた積は、T が 2 元か 3 元なら符号が変わり E_{∅,T} にならない
        Q = I
        for t in range(1, M + 1):
            Q = Q * z[t]
        if len(T) >= 2 and len(T) % 4 in (2, 3):
            assert E(empty, empty) * Q != E(empty, T)
            negative_rejected += 1
    print("M=%d: PASS" % M)
print("negative controls rejected: %d" % negative_rejected)
