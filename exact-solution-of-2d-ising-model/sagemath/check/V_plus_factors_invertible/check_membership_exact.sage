# 対象ラベル: V_plus_factors_invertible
# check_membership_chain.sage と同じ内容を厳密に確かめる。K_1 := 2 log y（y ∈ {2, 3}）と選ぶと B・B^{-1} = exp(±X) は
# 固有値の射影の和として QQ に乗り（共通の準備の exp_V1_half_exact）、K_2 := log x（x ∈ {2, 3}）と選ぶと V_2 は成分の定義で QQ に、
# V2_invertible の証明の h = (a^{-1})_C exp(-Y) は AA に乗る。ℝ への脱出は K_1・K_2 の選び方だけで、等号はすべて厳密。
#   - BV_2 ∈ R^×: (ii) の逆元 V_2^{-1}B^{-1} を掛けると両順で I（本文の積の成分の式で）、Sage の inverse とも一致
#   - V^(+) = (BV_2)B が B(V_2B) に等しい（def_V_plus の括弧の約束）
#   - (BV_2)B ∈ R^×: (ii) の逆元 B^{-1}(V_2^{-1}B^{-1}) を掛けると両順で I、Sage の inverse とも一致
# 対照: 順を入れ替えた B^{-1}V_2^{-1} は BV_2 の逆元にならない。
load("_prelude.sage")
for M in range(2, 5):
    n = 2**M
    Id = body_identity(AA, n)
    for x in [QQ(2), QQ(3)]:
        a = prefactor_exact(M, x)
        V2 = V2_components_exact(M, x)
        V2inv = body_scalar(a**(-1), exp_iK2star_H2_exact(M, x, -1))
        assert body_product(V2, V2inv) == Id == body_product(V2inv, V2)
        for y in [QQ(2), QQ(3)]:
            B = exp_V1_half_exact(M, y, +1).change_ring(AA)
            Binv = exp_V1_half_exact(M, y, -1).change_ring(AA)
            assert body_product(B, Binv) == Id == body_product(Binv, B)
            G = body_product(B, V2)
            Ginv = body_product(V2inv, Binv)
            assert body_product(G, Ginv) == Id and body_product(Ginv, G) == Id
            assert G.inverse() == Ginv
            assert body_product(G, body_product(Binv, V2inv)) != Id
            Vp = body_product(G, B)
            assert Vp == body_product(B, body_product(V2, B))
            Vpinv = body_product(Binv, Ginv)
            assert body_product(Vp, Vpinv) == Id and body_product(Vpinv, Vp) == Id
            assert Vp.inverse() == Vpinv
    print(f"  M_col={M}: x, y ∈ {{2,3}} で (ii) の逆元が BV_2・(BV_2)B の両順で I を与え、Sage の逆行列と一致（AA で厳密）。対照は I にならない")
print("RESULT: PASS")
