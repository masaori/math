# 対象ラベル: claim_annihilation_generator_commutes_with_other_number_reversed_pair, claim_vacuum_factors_with_different_numbers_commute,
#   claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator, claim_creation_generator_times_vacuum_factor_is_creation_generator,
#   claim_vacuum_factor_is_idempotent, claim_creation_vacuum_annihilation_factor_of_one_number
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
    Z = zero_matrix(ZZ, len(P))
    for i in range(1, M + 1):
        for j in range(1, M + 1):
            if j == i:
                continue
            # claim_annihilation_generator_commutes_with_other_number_reversed_pair の像と、証明の準備・鎖の行
            assert ct[i] * c[j] + c[j] * ct[i] == Z
            assert ct[i] * (c[j] * ct[j]) == (ct[i] * c[j]) * ct[j] == -(c[j] * ct[i]) * ct[j] == -(c[j] * (ct[i] * ct[j]))
            assert -(c[j] * (ct[i] * ct[j])) == c[j] * (ct[j] * ct[i]) == (c[j] * ct[j]) * ct[i]
            # claim_vacuum_factors_with_different_numbers_commute の像と鎖の行
            assert x[i] * x[j] == ct[i] * (c[i] * x[j]) == ct[i] * (x[j] * c[i]) == (x[j] * ct[i]) * c[i] == x[j] * x[i]
        # claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator の像と鎖の行
        assert x[i] * ct[i] == ct[i] * (c[i] * ct[i])
        assert ct[i] * ct[i] == Z
        assert (ct[i] * ct[i]) * c[i] + ct[i] * (c[i] * ct[i]) == ct[i] * (ct[i] * c[i] + c[i] * ct[i])
        assert ct[i] * c[i] + c[i] * ct[i] == I
        assert x[i] * ct[i] == ct[i]
        # claim_creation_generator_times_vacuum_factor_is_creation_generator の像と鎖の行
        assert c[i] * x[i] == (c[i] * ct[i]) * c[i]
        assert ct[i] * (c[i] * c[i]) + (c[i] * ct[i]) * c[i] == (ct[i] * c[i] + c[i] * ct[i]) * c[i]
        assert c[i] * x[i] == c[i]
        # claim_vacuum_factor_is_idempotent の像
        assert x[i] * x[i] == (x[i] * ct[i]) * c[i] == x[i]
        # 否定コントロール: 順序を入れ替えると成り立たない
        assert ct[i] * x[i] != ct[i]
        assert x[i] * c[i] != c[i]
        # claim_creation_vacuum_annihilation_factor_of_one_number の像（すべての S）
        for S in P:
            u = (c[i] * ct[i]) if i in S else (ct[i] * c[i])
            assert (y(S)[i] * x[i]) * z(S)[i] == u
            if i in S:
                assert (y(S)[i] * x[i]) * z(S)[i] != ct[i] * c[i]      # 否定コントロール
    print("M=%d: PASS" % M)
print("ALL PASS")
