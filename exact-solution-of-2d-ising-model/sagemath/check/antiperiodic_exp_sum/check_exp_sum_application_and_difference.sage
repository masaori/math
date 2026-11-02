# 対象ラベル: antiperiodic_exp_sum
# (1) exp_sum の適用の 4 行: T_{2M,k} = (2(M)_N)_C δ^{2(M)_N}_{(k,0)} = (2M)_C δ^{2(M)_N}_{(k,0)}、
#     T_{M,k} = ((M)_N)_C δ^{(M)_N}_{(k,0)} = (M)_C δ^{(M)_N}_{(k,0)}。
# (2) S = T_{2M,k} - T_{M,k} = (2M)_C δ^{2M} - (M)_C δ^{M} の 2 等号。
# M_col = 2..8、k = -3M..3M で UCF で厳密に。δ は def_delta_M の場合分けのまま作る。
load("_prelude.sage")
for M in M_RANGE:
    MN = Integer(M)
    for k in K_RANGE(M):
        T2, T1 = T(2 * MN, k), T(MN, k)
        d2, d1 = delta(2 * MN, k, 0), delta(MN, k, 0)
        assert T2 == UCF(QQ(ZZ(2 * MN))) * d2
        assert UCF(QQ(ZZ(2 * MN))) * d2 == to_C(2 * M) * d2
        assert T1 == UCF(QQ(ZZ(MN))) * d1
        assert UCF(QQ(ZZ(MN))) * d1 == to_C(M) * d1
        S = S_claim_form(M, k)
        assert S == T2 - T1
        assert T2 - T1 == to_C(2 * M) * d2 - to_C(M) * d1
    print(f"  M_col={M}: exp_sum の適用の 4 行と S = T_(2M,k) - T_(M,k) の 2 等号が k = {-3*M}..{3*M} で成り立つ")
print("RESULT: PASS")
