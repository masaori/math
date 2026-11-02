# 対象ラベル: V_plus_factors_invertible
# 証明の二つの式 BV_2 ∈ R^× と V^(+) = (BV_2)B ∈ R^× を確かめる（B := (V_1^(+))^{1/2}）。
# どちらも def_invertible_elements_of_R (ii) の当てはめで、(ii) が与える逆元 (g_1g_2)^{-1} = g_2^{-1}g_1^{-1} を使う:
#   (BV_2)^{-1} = V_2^{-1}B^{-1}、((BV_2)B)^{-1} = B^{-1}(V_2^{-1}B^{-1})。
# B・B^{-1} = exp(±X)（X := (i/2)K_1H_1^(+)、K_1 ∈ {1/4, 1/2}）は本文の部分和と尾の上界のボールで（ℝ への脱出: exp の極限）、
# V_2・V_2^{-1} は K_2 = log x（x ∈ {2, 3}）として V2_invertible の証明の h = (a^{-1})_C exp(-Y) とともに AA で厳密に作り、
# 256 ビットのボールへ移す。
#   - (ii) の逆元の候補を掛けると、両順で I と重なる（BV_2 と V^(+) の両方）
#   - def_V_plus の (BV_2)B が括弧を替えた B(V_2B) と重なる（mat_mult_associative。def_V_plus の括弧の約束）
#   - Sage の ComplexBallField の逆行列が (ii) の候補と重なる（独立な経路）
# 対照: (ii) の順を入れ替えた B^{-1}V_2^{-1} は BV_2 の逆元にならず、I と交わらない成分がある（B と V_2 は可換でない）。
load("_prelude.sage")
for M in range(2, 5):
    n = 2**M
    Id = identity_CB(n)
    for x in [QQ(2), QQ(3)]:
        a = prefactor_exact(M, x)
        V2e = V2_components_exact(M, x)
        V2inv_e = body_scalar(a**(-1), exp_iK2star_H2_exact(M, x, -1))
        assert body_product(V2e, V2inv_e) == body_identity(AA, n) == body_product(V2inv_e, V2e)
        V2, V2inv = AA_to_CB(V2e), AA_to_CB(V2inv_e)
        for K1 in [QQ(1)/4, QQ(1)/2]:
            X = V1_half_exponent(M, K1)
            B, Binv = exp_ball(X), exp_ball(body_negation(X))
            # 第一の式: BV_2 ∈ R^×
            G = B * V2
            Ginv = V2inv * Binv
            assert balls_overlap(G * Ginv, Id) and balls_overlap(Ginv * G, Id)
            assert balls_overlap(G.inverse(), Ginv)
            assert balls_disjoint_somewhere(G * (Binv * V2inv), Id)
            # 第二の式: V^(+) = (BV_2)B ∈ R^×
            Vp = G * B
            assert balls_overlap(Vp, B * (V2 * B))
            Vpinv = Binv * Ginv
            assert balls_overlap(Vp * Vpinv, Id) and balls_overlap(Vpinv * Vp, Id)
            assert balls_overlap(Vp.inverse(), Vpinv)
    print(f"  M_col={M}: (ii) の逆元の候補が BV_2・(BV_2)B の両順で I と重なり、Sage の逆行列とも重なる。対照は I と交わらない成分がある")
print("RESULT: PASS")
