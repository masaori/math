# 対象ラベル: antiperiodic_exp_sum
# 場合分けの段を M_col = 2..8 で確かめる。
# (1) k ≢ 0 (mod M) の段: 2M | k なら M | k の対偶 2M ∤ k、δ^{2M}_{(k,0)} = δ^{M}_{(k,0)} = 0_C、和の 7 等号の鎖（k = -3M..3M）。
# (2) k = lM の段: δ^{M}_{(k,0)} = 1_C、2M | k ⇔ 2M | lM ⇔ 2 | l の 2 つの同値（l = -6..6）。
# (3) l が偶数の鎖の 10 等号、l が奇数の鎖の 8 等号を、各行をその行の形のまま UCF で厳密に組み、隣の行と比べる。
#     鎖の始まりの S は主張の左辺の式（S_claim_form）で、鎖の終わりは (M)_C(-1_C)^l（minus_one_power）。
# (4) 「とくに」: |k| < M かつ k ≠ 0 のとき M ∤ k であること、その背理法の鎖
#     0_N + (M)_N = (M)_N、0_N ≤ (M)_N（順序と和）、0_Z = ι(0_N) ≤ ι((M)_N) = ((M)_N)_Z = M（ι_{N→Z} は零と順序を保つ、略記 n_Z）、|·| は def_int_absolute_value の場合分けの式（int_abs_cases）、
#     |lM| = |l||M| = |l|M（|M| = M は 0 ≤ M の場合の式）= |k| < M、0_Z ≤ |l|（int_absolute_value_is_nonnegative）、|l| < 1、|l| + 1 ≤ 1（def_int_strict_order）、|l| = |l| + 0 = |l| + (1 + (−1)) = (|l| + 1) + (−1) ≤ 1 + (−1) = 0、
#     |l| = 0（反対称律）、l = 0（int_absolute_value_zero_implies_zero）、k = lM = 0·M = 0（int_zero_times_is_zero、x → M）を、仮定を外した全ての (l, k) で
#     各等号・不等号として確かめ、仮定 |k| < M が成り立つのは l = 0 だけであることを見る。k = 0 の鎖の 2 等号。
load("_prelude.sage")

def int_abs_cases(x):
    # def_int_absolute_value: 0 <= x なら x、そうでなければ -x（Sage の abs と一致することも見る）
    x = ZZ(x)
    v = x if 0 <= x else -x
    assert v == abs(x)
    return v
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
    # 0_N ≤ (M)_N の 2 行と 0_Z ≤ M_col の 4 行: 0_N + (M)_N = (M)_N、0_N ≤ (M)_N（順序と和、d = (M)_N）、
    # 0_Z = ι(0_N) ≤ ι((M)_N) = ((M)_N)_Z = M_col
    MN = NN(M)
    assert NN(0) + MN == MN and NN(0) <= MN                       # 0_N + (M)_N = (M)_N、順序と和（d -> (M)_N）
    assert ZZ(NN(0)) == 0 and ZZ(NN(0)) <= ZZ(MN) and ZZ(MN) == M   # ι は零と順序を保つ、略記 n_Z、(M)_N の定義
    # |M_col| = M_col: def_int_absolute_value の 0 <= x の場合の式（x -> M_col）
    assert 0 <= M and int_abs_cases(ZZ(M)) == ZZ(M)
    for l in range(-6, 7):
        k = l * M
        assert int_abs_cases(l * M) == int_abs_cases(l) * int_abs_cases(M) == int_abs_cases(l) * M == int_abs_cases(k)
        # int_absolute_value_is_nonnegative（x -> l）
        assert 0 <= int_abs_cases(l)
        if abs(k) < M:
            assert abs(l) * M < 1 * M and abs(l) < 1
            # def_int_strict_order: |l| < 1_Z を |l| + 1_Z <= 1_Z と書き直す（ZZ の < と同値であることも見る）
            assert (abs(l) < 1) == (abs(l) + 1 <= 1) and abs(l) + 1 <= 1
            # |l| <= 0_Z を導く 5 行（和の単位元・加法逆元・結合律・順序と加法の両立・加法逆元）
            a0 = ZZ(abs(l))
            chain = [a0, a0 + 0, a0 + (1 + (-1)), (a0 + 1) + (-1)]
            for a, b in zip(chain, chain[1:]):
                assert a == b
            assert (a0 + 1) + (-1) <= 1 + (-1) and 1 + (-1) == 0
            # 反対称律: |l| <= 0 と 0 <= |l| から |l| = 0
            assert a0 <= 0 and 0 <= a0 and a0 == 0
            # int_absolute_value_zero_implies_zero（x -> l）: |l| = 0 から l = 0
            assert int_abs_cases(l) == 0 and l == 0
            assert k == l * M == 0 * M == 0   # 最後の等号は int_zero_times_is_zero（x -> M）
    for k in K_RANGE(M):
        if abs(k) < M and k != 0:
            assert k % M != 0
            assert S_claim_form(M, k) == zero
    assert MC * minus_one_power(0) == MC * one == MC
    assert S_claim_form(M, 0) == MC
    print(f"  M_col={M}: 非整除の段、整除の段の同値、偶数・奇数の鎖、「とくに」の背理法の鎖と k = 0 の鎖が成り立つ")
print("RESULT: PASS")
