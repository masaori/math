# 対象ラベル: antiperiodic_exp_sum
# 場合分けの段を M_col = 2..8 で確かめる。
# (1) k ≢ 0 (mod M) の段: 2M | k なら M | k の対偶 2M ∤ k、δ^{2M}_{(k,0)} = δ^{M}_{(k,0)} = 0_C、和の 7 等号の鎖（k = -3M..3M）。
# (2) k = lM の段: δ^{M}_{(k,0)} = 1_C、2M | k ⇔ 2M | lM ⇔ 2 | l の 2 つの同値（l = -6..6）。
# (3) l が偶数の鎖の 10 等号、l が奇数の鎖の 8 等号を、各行をその行の形のまま UCF で厳密に組み、隣の行と比べる。
#     鎖の始まりの S は主張の左辺の式（S_claim_form）で、鎖の終わりは (M)_C(-1_C)^l（minus_one_power）。
# (4) 「とくに」: |k| < M かつ k ≠ 0 のとき M ∤ k であること、その背理法の鎖
#     |lM| = |l||M| = |l|M = |k| < M、|l| < 1、|l| = 0、l = 0、k = lM = 0·M = 0 を、仮定を外した全ての (l, k) で
#     各等号・不等号として確かめ、仮定 |k| < M が成り立つのは l = 0 だけであることを見る。k = 0 の鎖の 2 等号。
load("_prelude.sage")
one, zero = UCF(1), UCF(0)
for M in M_RANGE:
    MN = Integer(M)
    MC = to_C(M)
    # (1)
    for k in K_RANGE(M):
        if k % M != 0:
            assert k % (2 * M) != 0
            assert delta(2 * MN, k, 0) == zero and delta(MN, k, 0) == zero
            L = [S_claim_form(M, k),
                 to_C(2 * M) * zero - MC * zero,
                 zero - MC * zero,
                 zero - zero,
                 zero + (-zero),
                 -zero,
                 UCF(-1) * zero,
                 zero]
            for a, b in zip(L, L[1:]):
                assert a == b
    # (2), (3)
    for l in range(-6, 7):
        k = l * M
        assert delta(MN, k, 0) == one
        assert (k % (2 * M) == 0) == ((l * M) % (2 * M) == 0) == (l % 2 == 0)
        S = S_claim_form(M, k)
        if l % 2 == 0:
            assert delta(2 * MN, k, 0) == one
            L = [S,
                 to_C(2 * M) * one - MC * one,
                 to_C(2 * M) - MC * one,
                 to_C(2 * M) - MC,
                 UCF(QQ(2) * QQ(M)) - MC,
                 UCF(2) * MC - MC,
                 UCF(2) * MC - one * MC,
                 (UCF(2) - one) * MC,
                 one * MC,
                 MC * one,
                 MC * minus_one_power(l)]
        else:
            assert delta(2 * MN, k, 0) == zero
            L = [S,
                 to_C(2 * M) * zero - MC * one,
                 zero - MC * one,
                 zero - MC,
                 zero + (-MC),
                 -MC,
                 UCF(-1) * MC,
                 MC * UCF(-1),
                 MC * minus_one_power(l)]
        for a, b in zip(L, L[1:]):
            assert a == b
    # (4)
    for l in range(-6, 7):
        k = l * M
        assert abs(l * M) == abs(l) * abs(M) == abs(l) * M == abs(k)
        if abs(k) < M:
            assert abs(l) * M < 1 * M and abs(l) < 1 and abs(l) == 0 and l == 0
            assert k == l * M == 0 * M == 0
    for k in K_RANGE(M):
        if abs(k) < M and k != 0:
            assert k % M != 0
            assert S_claim_form(M, k) == zero
    assert MC * minus_one_power(0) == MC * one == MC
    assert S_claim_form(M, 0) == MC
    print(f"  M_col={M}: 非整除の段、整除の段の同値、偶数・奇数の鎖、「とくに」の背理法の鎖と k = 0 の鎖が成り立つ")
print("RESULT: PASS")
