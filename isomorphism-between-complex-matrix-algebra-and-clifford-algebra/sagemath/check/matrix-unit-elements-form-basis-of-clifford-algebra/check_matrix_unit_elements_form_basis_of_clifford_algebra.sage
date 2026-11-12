# 対象ラベル: claim_entry_of_image_of_linear_combination_of_matrix_unit_elements,
#   claim_family_of_matrix_unit_elements_is_linearly_independent, claim_family_of_matrix_unit_elements_spans_clifford_algebra,
#   theorem_matrix_unit_elements_form_basis_of_clifford_algebra
# クリフォード代数の中の族 b_m = E_{S_m,T_m}（行列単位にあたる元）を、準同型 Φ（Φ(a†_i)=c_i、Φ(a_i)=c_i^T）による行列の像で確かめる。
# 像での確認であり、クリフォード代数の中の主張の証明ではない。M=1,2,3、整数行列の厳密計算（ZZ）。
from itertools import combinations

def two_pow(M):
    return 1 if M == 0 else 2 * two_pow(M - 1)

def int_pow(n, k):
    return 1 if k == 0 else n * int_pow(n, k - 1)

def e(M, k):                                      # def_binary_numbering_of_power_set
    if M == 0:
        return frozenset()
    h = two_pow(M - 1)
    return e(M - 1, k) if k <= h else e(M - 1, k - h) | frozenset([M])

def eta(n, k, m):                                 # def_base_n_numbering_of_maps
    if k == 0:
        return {}
    q, rho = divmod(m - 1, int_pow(n, k - 1))
    x = dict(eta(n, k - 1, rho + 1))
    x[k] = q + 1
    return x

def N_(i, T):                                     # def_count_of_subset_elements_below_index
    if i == 1:
        return 0
    return N_(i - 1, T) + 1 if (i - 1) in T else N_(i - 1, T)

def sign(n):                                      # def_sign_of_nonnegative_integer
    return ZZ(1) if n == 0 else ZZ(-1) * sign(n - 1)

def delta(a, b):
    return ZZ(1) if a == b else ZZ(0)

def oprod(factors, I):
    r = I
    for f in factors:
        r = r * f
    return r

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

for M in range(1, 4):
    P = power_set(M)
    n = len(P)
    idx = {S: k for k, S in enumerate(P)}
    I = identity_matrix(ZZ, n)
    Z0 = zero_matrix(ZZ, n)
    c = {i: matrix(ZZ, n, n, lambda s, t: sign(N_(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
         for i in range(1, M + 1)}                                                   # def_creation_operator_matrix
    ct = {i: c[i].transpose() for i in c}                                           # def_annihilation_operator_matrix
    E = lambda S, T: matrix(ZZ, n, n, lambda u, v: delta(S, P[u]) * delta(T, P[v]))  # def_matrix_unit
    Ad = lambda S: oprod([c[t] if t in S else I for t in range(1, M + 1)], I)       # Φ(a†_S)
    An = lambda T: oprod([ct[M + 1 - k] if (M + 1 - k) in T else I for k in range(1, M + 1)], I)   # Φ(a_T)
    Pv = oprod([ct[i] * c[i] for i in range(1, M + 1)], I)                         # Φ(P)
    nn = two_pow(M)
    NM = int_pow(nn, 2)
    p = {m: (e(M, eta(nn, 2, m)[1]), e(M, eta(nn, 2, m)[2])) for m in range(1, NM + 1)}   # def_numbering_of_pairs_of_subsets
    Phib = {m: (Ad(p[m][0]) * Pv) * An(p[m][1]) for m in p}                         # Φ(b_m)
    for m in p:
        assert Phib[m] == E(*p[m])                                                  # 証明の（イ）
        for j in p:
            assert E(*p[m])[idx[p[j][0]], idx[p[j][1]]] == delta(m, j)              # 証明の（ロ）
    set_random_seed(20261112 + M)
    for trial in range(4):
        lam = {m: ZZ.random_element(-9, 10) for m in p}
        img = sum((lam[m] * Phib[m] for m in p), Z0)                                # Φ(Σ λ_m b_m)
        for j in p:
            assert img[idx[p[j][0]], idx[p[j][1]]] == lam[j]                        # 線型結合の像の成分は係数
        F = random_matrix(ZZ, n, n, x=-9, y=10)                                     # Φ(x) の代わり
        assert sum((F[idx[p[m][0]], idx[p[m][1]]] * Phib[m] for m in p), Z0) == F   # 張ることの像
    flat = matrix(ZZ, [Phib[m].list() for m in sorted(p)])
    assert flat.rank() == NM == n * n                                               # 一次独立の像
    # 否定の対照: 第二成分を第一成分に揃えた族 E_{S_m,S_m} は、M ≥ 1 では一次独立にならない
    bad = matrix(ZZ, [((Ad(p[m][0]) * Pv) * An(p[m][0])).list() for m in sorted(p)])
    assert bad.rank() < NM
print("PASS matrix-unit-elements-form-basis-of-clifford-algebra M=1,2,3")
