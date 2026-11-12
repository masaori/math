# 対象ラベル: claim_creation_generator_times_ordered_creation_product_with_index_is_zero
# クリフォード代数の中の等式を、準同型 Φ（Φ(a†_i)=c_i、Φ(a_i)=c_i^T）による行列の像で、整数行列の厳密計算で確かめる。像での確認であり、クリフォード代数の中の等式の証明ではない。
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

for M in range(1, 4):
    P, c, ct, I, y, z, Ad, An, x, Pv = setup(M)
    for T in P:
        for i in T:
            assert Ad(T) != 0
            assert c[i] * Ad(T) == 0                                              # 主張の像
            assert c[i] * Ad(T - {i}) != 0                                        # 否定コントロール: i を含まない部分集合では零にならない
    print("M=%d: PASS" % M)
print("ALL PASS")
