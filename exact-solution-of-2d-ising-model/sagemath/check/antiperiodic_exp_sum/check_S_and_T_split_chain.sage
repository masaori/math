# 対象ラベル: antiperiodic_exp_sum
# (1) S の 1 等号: Σ exp(i(k_R θ̃_{μ_Z})_C) = Σ exp(i(2π(2μ_R - 1)k_R / (2(M)_R))_C)。
# (2) 奇偶の分割の前提: {1, …, 2M} が {2μ-1} と {2μ}（1 ≤ μ ≤ M）にただ一通りに分かれる。
# (3) T_{2M,k} = ⋯ = S + T_{M,k} の 9 等号。
# M_col = 2..8、k = -3M..3M で、各行をその行の式の形のまま UCF で厳密に組み、隣の行と比べる。
# 対照: 半整数運動量を整数運動量（μ - 1/2 を μ）に替えると (1) が崩れる (M, k) がある。
load("_prelude.sage")
for M in M_RANGE:
    MN = Integer(M)
    # (2)
    odd = [2 * mu - 1 for mu in range(1, MN + 1)]
    even = [2 * mu for mu in range(1, MN + 1)]
    assert sorted(odd + even) == list(range(1, 2 * MN + 1)) and not set(odd) & set(even)
    broke = False
    for k in K_RANGE(M):
        kR, MR = QQ(k), QQ(M)
        # (1)
        S0 = S_claim_form(M, k)
        S1 = sum(E((2 * QQ(mu) - 1) * kR / (2 * MR)) for mu in range(1, MN + 1))
        assert S0 == S1
        S = S0
        if S0 != sum(E(kR * QQ(mu) / MR) for mu in range(1, MN + 1)):
            broke = True
        # (3)
        L = []
        L.append(T(2 * MN, k))                                                          # T_{2M,k}
        L.append(sum(E(QQ(r) * kR / QQ(2 * MN)) for r in range(1, 2 * MN + 1)))        # N = 2(M)_N を代入
        L.append(sum(E(QQ(r) * kR / (2 * MR)) for r in range(1, 2 * MN + 1)))          # (2(M)_N)_R = 2(M)_R
        L.append(sum(E(QQ(ZZ(2 * mu - 1)) * kR / (2 * MR)) for mu in range(1, MN + 1))
                 + sum(E(QQ(ZZ(2 * mu)) * kR / (2 * MR)) for mu in range(1, MN + 1)))   # 奇偶で分割（((2μ-1)_Z)_R の形）
        L.append(sum(E((2 * QQ(ZZ(mu)) - 1) * kR / (2 * MR)) for mu in range(1, MN + 1))
                 + sum(E((2 * QQ(ZZ(mu))) * kR / (2 * MR)) for mu in range(1, MN + 1)))  # 包含が単位元・差・積を保つ
        L.append(S + sum(E((2 * QQ(mu)) * kR / (2 * MR)) for mu in range(1, MN + 1)))  # S の上の式
        L.append(S + sum(E((2 * (QQ(mu) * kR)) / (2 * MR)) for mu in range(1, MN + 1)))  # 積の交換律・結合律
        L.append(S + sum(E(QQ(mu) * kR / MR) for mu in range(1, MN + 1)))              # 約分
        L.append(S + sum(E(QQ(mu) * kR / QQ(MN)) for mu in range(1, MN + 1)))          # ((M)_N)_R = (M)_R
        L.append(S + T(MN, k))                                                          # T_{M,k} の定義
        for a, b in zip(L, L[1:]):
            assert a == b
    assert broke
    print(f"  M_col={M}: k = {-3*M}..{3*M} で S の等号・奇偶の分割・T_(2M,k) の 9 等号が成り立つ。整数運動量に替えると崩れる k がある")
print("RESULT: PASS")
