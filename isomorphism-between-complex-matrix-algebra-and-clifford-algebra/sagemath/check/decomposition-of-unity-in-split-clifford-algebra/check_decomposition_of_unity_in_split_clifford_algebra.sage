# 対象ラベル: claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors,
#   claim_sum_over_subsets_of_selected_products_is_product_of_sums, claim_decomposition_of_unity_in_split_clifford_algebra
# クリフォード代数の中の等式を、準同型 Φ（Φ(a†_i)=c_i、Φ(a_i)=c_i^T）による行列の像で、整数行列の厳密計算で確かめる。像での確認であり、クリフォード代数の中の等式の証明ではない。
# 一般の ℂ-代数についての主張（claim_sum_over_subsets_of_selected_products_is_product_of_sums）は、交換しない整数行列の族で確かめる。
# 部分集合の 2 進の番号付け e_m は、本文の漸化式どおりの作り方と、S ↦ 1+Σ_{t∈S}2^{t-1} の逆写像を表から作る作り方の二つで作り、
# 一致することを確かめてから使う。
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

def creation_matrices(M, P):       # def_creation_operator_matrix（Φ(a†_i)=c_i）
    return {i: matrix(ZZ, len(P), len(P), lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
            for i in range(1, M + 1)}

def oprod(factors, I):             # def_ordered_product_in_algebra（左から右へ掛ける）
    r = I
    for f in factors:
        r = r * f
    return r

def setup(M):
    P = power_set(M)
    c = creation_matrices(M, P)
    ct = {i: c[i].transpose() for i in c}     # def_annihilation_operator_matrix（Φ(a_i)=c_i^T）
    I = identity_matrix(ZZ, len(P))
    y = lambda S: {t: (c[t] if t in S else I) for t in range(1, M + 1)}          # Φ(y^S_t)
    z = lambda T: {t: (ct[t] if t in T else I) for t in range(1, M + 1)}         # Φ(z^T_t)
    Ad = lambda S: oprod([y(S)[t] for t in range(1, M + 1)], I)                   # Φ(a†_S)
    An = lambda T: oprod([z(T)[M + 1 - k] for k in range(1, M + 1)], I)           # Φ(a_T)
    x = {i: ct[i] * c[i] for i in range(1, M + 1)}                                # Φ(x_i)=Φ(a_i a†_i)
    Pv = oprod([x[i] for i in range(1, M + 1)], I)                                # Φ(P)
    return P, c, ct, I, y, z, Ad, An, x, Pv

def two_pow(m):                    # def_binary_numbering_of_power_set の 2^0:=1、2^m:=2·2^{m-1}
    return 1 if m == 0 else 2 * two_pow(m - 1)

def e_by_recursion(m, k):          # def_binary_numbering_of_power_set の漸化式どおりの e_m(k)
    if m == 0:
        assert k == 1
        return frozenset()
    h = two_pow(m - 1)
    assert 1 <= k <= 2 * h
    return e_by_recursion(m - 1, k) if k <= h else e_by_recursion(m - 1, k - h) | frozenset([m])

def e_by_inverting_sum_of_powers(m):
    # 漸化式とは別の作り方: 写像 S ↦ 1 + Σ_{t∈S} 2^{t-1}（P_m → {1..2^m}）を表に作り、全単射であることを確かめて逆写像の表を返す
    code = {S: 1 + sum(2 ** (t - 1) for t in S) for S in power_set(m)}
    assert sorted(code.values()) == list(range(1, 2 ** m + 1))
    inv = {k: S for S, k in code.items()}
    return [inv[k] for k in range(1, 2 ** m + 1)]

def binary_numbering(m):           # e_m(k) を k=1..2^m の順に並べた表（二つの作り方が一致することを確かめてから返す）
    by_recursion = [e_by_recursion(m, k) for k in range(1, two_pow(m) + 1)]
    by_inverse = e_by_inverting_sum_of_powers(m)
    assert two_pow(m) == 2 ** m
    assert by_recursion == by_inverse
    return by_recursion

def expansion_holds(M, g, h, I):   # claim_sum_over_subsets_of_selected_products_is_product_of_sums の各 m
    for m in range(0, M + 1):
        e = binary_numbering(m)
        assert len(e) == 2 ** m and len(set(e)) == 2 ** m
        v = lambda S, i: g[i] if i in S else h[i]
        lhs = sum((oprod([v(e[k], i) for i in range(1, m + 1)], I) for k in range(2 ** m)), 0 * I)
        rhs = oprod([h[i] + g[i] for i in range(1, m + 1)], I)
        assert lhs == rhs
        if m >= 1:
            n = 2 ** (m - 1)
            for k in range(n):                                        # 準備（イ）（ロ）
                assert m not in e[k] and e[k] == binary_numbering(m - 1)[k]
                assert e[n + k] == binary_numbering(m - 1)[k] | {m}
    return True

for M in range(1, 4):
    P, c, ct, I, y, z, Ad, An, x, Pv = setup(M)
    An_le = lambda T, m: oprod([z(T)[m + 1 - k] for k in range(1, m + 1)], I)
    Ad_le = lambda U, m: oprod([y(U)[t] for t in range(1, m + 1)], I)
    P_le = lambda m: oprod([x[i] for i in range(1, m + 1)], I)
    for S in P:
        u = {i: (c[i] * ct[i] if i in S else ct[i] * c[i]) for i in range(1, M + 1)}   # Φ(u^S_i)
        for m in range(0, M + 1):
            assert (Ad_le(S, m) * P_le(m)) * An_le(S, m) == oprod([u[i] for i in range(1, m + 1)], I)
            if m >= 1:
                for t in range(1, m):
                    assert z(S)[t] * u[m] == u[m] * z(S)[t]                              # 準備（ロ）
                assert y(S)[m] * P_le(m - 1) == P_le(m - 1) * y(S)[m]                    # 準備（イ）
        assert (Ad(S) * Pv) * An(S) == oprod([u[i] for i in range(1, M + 1)], I)
    # 1 の分解に当てる形（g_i=a†_i a_i、h_i=a_i a†_i）
    assert expansion_holds(M, {i: c[i] * ct[i] for i in range(1, M + 1)}, {i: ct[i] * c[i] for i in range(1, M + 1)}, I)
    for i in range(1, M + 1):
        assert ct[i] * c[i] + c[i] * ct[i] == I                                         # 準備（ハ）
    total = sum(((Ad(S) * Pv) * An(S) for S in P), 0 * I)
    assert total == I                                                                    # 主張の像
    eM = binary_numbering(M)
    total_by_numbering = sum(((Ad(eM[k]) * Pv) * An(eM[k]) for k in range(2 ** M)), 0 * I)
    assert total_by_numbering == I                                                       # 番号付け e_M の順に足しても同じ
    assert sum((Ad(S) * An(S) for S in P), 0 * I) != I                                   # 否定コントロール: P を抜くと 1 にならない
    # 一般の ℂ-代数の主張: 交換しない整数行列 3×3 の族
    set_random_seed(20261112 + M)
    I3 = identity_matrix(ZZ, 3)
    g = {i: random_matrix(ZZ, 3, 3, x=-3, y=4) for i in range(1, M + 1)}
    h = {i: random_matrix(ZZ, 3, 3, x=-3, y=4) for i in range(1, M + 1)}
    assert any(g[i] * h[i] != h[i] * g[i] for i in g)
    assert expansion_holds(M, g, h, I3)
    if M >= 2:   # 否定コントロール: 因子の順序を逆にした積の和は一般には一致しない
        e = binary_numbering(M)
        v = lambda S, i: g[i] if i in S else h[i]
        rev = sum((oprod([v(S, i) for i in range(M, 0, -1)], I3) for S in e), 0 * I3)
        assert rev != oprod([h[i] + g[i] for i in range(1, M + 1)], I3)
    print("M=%d: PASS" % M)
print("ALL PASS")
