# 対象ラベル: claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix
# W:=QQ^M、基底 w を標準基底、双対基底 f を標準基底の双対（f_i(w_k)=δ_{i,k}）とし、φ((x,g))=Σ β_k(x) c_k + Σ g(w_k) c_k^T を
# 埋め込みの像で評価する（Φ(γ(v))=φ(v) なので、像での確認である）。M=1,2,3 のすべての i で、二つの線型結合の値と主張を ZZ の厳密計算で確かめる。
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
    ct = {k: c[k].transpose() for k in c}
    for i in range(1, M + 1):
        x = [0] * M; g = [1 if k == i else 0 for k in range(1, M + 1)]
        first = sum(x[k - 1] * c[k] for k in range(1, M + 1))
        second = sum(g[k - 1] * ct[k] for k in range(1, M + 1))
        phi = first + second
        assert phi == ct[i]                                                       # 主張
    print("M=%d: PASS" % M)
print("ALL PASS")
