# 対象ラベル: T_V_plus_is_conjugation
# 証明の準備を確かめる。
#   - 四つの可逆性: S・V_2・SV_2・V^(+) について、逆元の候補（SV_2 は (ii) の V_2^{-1}S^{-1}、V^(+) は S^{-1}(V_2^{-1}S^{-1})）を
#     掛けると両順で I（mat_mult の成分の式で）
#   - T_g(X) = (gX)g^{-1} = T'_g(X): def_T_g の値（Sage の積と inverse）と、mat_conj の T'_g の値（成分の式と上の逆元）が、
#     成分が独立な不定元の X について一致する（g ∈ {S, V_2, SV_2, V^(+)}）
# 対照: 逆元の順を入れ替えた S^{-1}V_2^{-1} は SV_2 の逆元にならない。
load("_prelude.sage")
for M in [2, 3, 4]:
    n = 2**M
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            K, (S, Sinv, V2, V2inv) = factors_exact(M, x, y)
            Id = body_identity(K, n)
            G, Ginv = body_product(S, V2), body_product(V2inv, Sinv)
            Vp = body_product(G, S)
            Vpinv = body_product(Sinv, Ginv)
            for g, gi in [(S, Sinv), (V2, V2inv), (G, Ginv), (Vp, Vpinv)]:
                assert body_product(g, gi) == Id and body_product(gi, g) == Id
            assert body_product(G, body_product(Sinv, V2inv)) != Id
            P, X = generic_matrix(K, n)
            for g, gi in [(S, Sinv), (V2, V2inv), (G, Ginv), (Vp, Vpinv)]:
                assert T_def(g, X) == T_prime(g, gi, X)
    print(f"  M_col={M}: x, y ∈ {{2,3}} で四つの逆元が両順で I、不定元の X で T_g(X) = T'_g(X)（4 つの g、数体で厳密）。対照は I にならない")
print("RESULT: PASS")
