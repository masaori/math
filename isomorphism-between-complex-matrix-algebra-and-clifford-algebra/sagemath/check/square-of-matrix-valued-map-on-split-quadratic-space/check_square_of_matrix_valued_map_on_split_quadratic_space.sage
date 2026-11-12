# 対象ラベル: claim_square_of_matrix_valued_map_on_split_quadratic_space
# W:=QQ^M、基底 w を標準基底、x∈W の座標 β_k(x)=x_k、g∈W^* の値 g(w_k)=g_k を多項式環 QQ[x_1..x_M, g_1..g_M] の不定元に取り、
# C:=Σ x_k c_k、D:=Σ g_k c_k^T、φ((x,g))=C+D として、準備の一つ目から五つ目と本文の鎖の行を、多項式環の上の行列の厳密計算で確かめる。
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
    R = PolynomialRing(QQ, ['x%d' % k for k in range(1, M + 1)] + ['g%d' % k for k in range(1, M + 1)])
    xs = R.gens()[:M]
    gs = R.gens()[M:]
    c = creation_matrices(M, P, R)
    ct = {k: c[k].transpose() for k in c}
    I = identity_matrix(R, n)
    lam = {k: xs[k - 1] for k in range(1, M + 1)}
    mu = {k: gs[k - 1] for k in range(1, M + 1)}
    C = sum(lam[k] * c[k] for k in range(1, M + 1))
    D = sum(mu[k] * ct[k] for k in range(1, M + 1))
    assert C * C == 0                                                           # 準備の一つ目
    assert D * D == 0                                                           # 準備の二つ目
    for k in range(1, M + 1):
        for l in range(1, M + 1):
            assert ct[l] * c[k] + c[k] * ct[l] == (1 if k == l else 0) * I      # 項の一つ目の等式
        assert D * c[k] + c[k] * D == sum(mu[l] * (ct[l] * c[k] + c[k] * ct[l]) for l in range(1, M + 1))   # 反交換子の線型結合
        assert c[k] * D + D * c[k] == mu[k] * I                                 # 準備の三つ目
    target = sum(lam[k] * (mu[k] * I) for k in range(1, M + 1))
    assert C * D + D * C == sum(lam[k] * (c[k] * D + D * c[k]) for k in range(1, M + 1)) == target   # 準備の四つ目
    gx = sum(xs[k - 1] * gs[k - 1] for k in range(1, M + 1))                    # g(x)=Σ β_k(x) g(w_k)
    assert gx * I == target                                                     # 準備の五つ目
    phi = C + D
    assert phi * phi == C * C + C * D + D * C + D * D == C * D + D * C          # 本文の鎖の分配法則と零の行
    assert phi * phi == gx * I                                                  # 主張（q((x,g))=g(x)）
    wrong = C + sum(mu[k] * c[k] for k in range(1, M + 1))                      # 否定コントロール: c_k^T を c_k に替える
    assert wrong * wrong != gx * I
    print("M=%d: PASS" % M)
print("ALL PASS")
