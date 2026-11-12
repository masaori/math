# 対象ラベル: claim_initial_reverse_ordered_annihilation_product_splits_off_last_number, claim_vacuum_factor_commutes_with_lower_initial_parts,
#   claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset, claim_vacuum_sandwich_when_last_number_is_in_neither_subset,
#   claim_vacuum_sandwich_when_last_number_is_in_both_subsets, claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part,
#   claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero, claim_vacuum_element_sandwich_of_annihilation_and_creation_products
# 主張が自明に（両辺が零で）通っていないことを、両辺が零でない件・挟む前は零でないのに挟むと零になる件を数え、正であることで確かめる。
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
    An_le = lambda T, m: oprod([z(T)[m + 1 - k] for k in range(1, m + 1)], I)   # Φ(a_{T,≤m})
    Ad_le = lambda U, m: oprod([y(U)[t] for t in range(1, m + 1)], I)           # Φ(a†_{U,≤m})
    P_le = lambda m: oprod([x[i] for i in range(1, m + 1)], I)                  # Φ(P_{≤m})
    Q = lambda T, U, m: (P_le(m) * (An_le(T, m) * Ad_le(U, m))) * P_le(m)       # Φ(Q^{T,U}_m)
    count = 0
    nontriv = {"一致して Q が零でない": 0, "一致せず a_{T,≤m}a†_{U,≤m} が零でないのに Q が零": 0,
               "両方に入り両辺が零でない": 0, "どちらにも入らず両辺が零でない": 0,
               "T=U で両辺が零でない": 0, "T≠U で a_T a†_U が零でないのに両辺が零": 0}
    for T in P:
        assert An_le(T, M) == An(T) and Ad_le(T, M) == Ad(T) and P_le(M) == Pv     # 定義の m=M の読み
        for U in P:
            for m in range(0, M + 1):
                agree = all((t in T) == (t in U) for t in range(1, m + 1))
                if agree:
                    assert Q(T, U, m) == P_le(m)                                    # 一致する場合の主張
                    if Q(T, U, m) != Z:
                        nontriv["一致して Q が零でない"] += 1
                else:
                    assert Q(T, U, m) == Z                                          # 一致しない場合の主張
                    if An_le(T, m) * Ad_le(U, m) != Z:
                        nontriv["一致せず a_{T,≤m}a†_{U,≤m} が零でないのに Q が零"] += 1
                if m == 0:
                    continue
                assert An_le(T, m) == z(T)[m] * An_le(T, m - 1)                     # 消滅の逆順の積の分解
                G = An_le(T, m - 1) * Ad_le(U, m - 1)
                assert x[m] * G == G * x[m]                                         # 番号 m の因子との交換
                assert An_le(T, m) * Ad_le(U, m) == z(T)[m] * (G * y(U)[m])         # 準備（ハ）
                assert x[m] * P_le(m - 1) == P_le(m - 1) * x[m]                     # 準備（イ）
                assert ct[m] * P_le(m - 1) == P_le(m - 1) * ct[m] and c[m] * P_le(m - 1) == P_le(m - 1) * c[m]
                inT, inU = (m in T), (m in U)
                if inT != inU:
                    assert Q(T, U, m) == Z                                          # ちょうど一方に入る場合
                elif not inT:
                    assert Q(T, U, m) == Q(T, U, m - 1) * x[m]                      # どちらにも入らない場合
                    if Q(T, U, m) != Z:
                        nontriv["どちらにも入らず両辺が零でない"] += 1
                else:
                    assert Q(T, U, m) == ct[m] * (Q(T, U, m - 1) * c[m])            # 両方に入る場合
                    if Q(T, U, m) != Z:
                        nontriv["両方に入り両辺が零でない"] += 1
                    assert Q(T, U, m) != c[m] * (Q(T, U, m - 1) * ct[m]) or Q(T, U, m - 1) == Z  # 否定コントロール（生成と消滅を取り違えた漸化式）
                count += 1
            delta = 1 if T == U else 0
            assert (Pv * (An(T) * Ad(U))) * Pv == delta * Pv                        # 主張の像
            if T == U and Pv != Z:
                nontriv["T=U で両辺が零でない"] += 1
            if T != U and An(T) * Ad(U) != Z:
                nontriv["T≠U で a_T a†_U が零でないのに両辺が零"] += 1
    # 否定コントロール: P で挟まないと δ にならない組がある
    assert any(An(T) * Ad(U) != (1 if T == U else 0) * I for T in P for U in P)
    for key in ["一致して Q が零でない", "両方に入り両辺が零でない", "どちらにも入らず両辺が零でない", "T=U で両辺が零でない"]:
        assert nontriv[key] > 0                                                     # 主張が非自明に成り立った件がある
    if M >= 2:
        for key in ["一致せず a_{T,≤m}a†_{U,≤m} が零でないのに Q が零", "T≠U で a_T a†_U が零でないのに両辺が零"]:
            assert nontriv[key] > 0
    print("M=%d: PASS (%d 件の漸化式; %s)" % (M, count, ", ".join("%s %d 件" % (k, v) for k, v in nontriv.items())))
print("ALL PASS")
