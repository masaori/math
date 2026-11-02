# 対象ラベル: T_V_plus_is_conjugation
# 証明の鎖の 9 つの値を、成分が独立な不定元の X（全ての X ∈ R を一度に表す）について別々に作り、隣り合う値の一致を確かめる。
#   L0 T_(V+)(X)               def_T_V_plus の入れ子 T_S(T_V2(T_S(X)))（def_T_g の値: Sage の積と inverse）
#   L1 T'_S(T'_V2(T'_S(X)))    mat_conj の T'（成分の式と、可逆性の主張が与える逆元）
#   L2 (T'_S ∘ T'_V2)(T'_S(X)) 合成を Python の合成関数として作って当てる（合成の定義の展開で計算を含まない。L4 も同じ）
#   L3 T'_{SV2}(T'_S(X))       合成則の右辺。(SV_2)^{-1} は合成則の証明の H^{-1}G^{-1} = V_2^{-1}S^{-1}
#   L4 (T'_{SV2} ∘ T'_S)(X)
#   L5 T'_{(SV2)S}(X)          ((SV_2)S)^{-1} = S^{-1}(V_2^{-1}S^{-1})
#   L6 T'_{V+}(X)              def_V_plus の V^(+) := (SV_2)S への置き換え（計算を含まない）。行列は L5 と同じで逆元を Sage の inverse に
#                              替えたので、L5 = L6 が確かめるのは逆元が一つに決まること
#   L7 T_{V+}(X)               def_T_g の値（Sage の積と inverse）
# 主張: L0 = L7 が不定元の X で成り立つので、二つの写像は全ての値が一致する。
# 対照: 合成の順を入れ替えた T_{V2}(T_S(T_S(X))) と T'_{V2 S}(T'_S(X)) は L0 と一致しない（S と V_2 は可換でない）。
load("_prelude.sage")


def compose(f, g):
    """写像の合成 (f ∘ g)(X) := f(g(X))。"""
    return lambda X: f(g(X))


for M in [2, 3, 4]:
    n = 2**M
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            K, (S, Sinv, V2, V2inv) = factors_exact(M, x, y)
            P, X = generic_matrix(K, n)
            TS = lambda Z: T_prime(S, Sinv, Z)
            TV2 = lambda Z: T_prime(V2, V2inv, Z)
            G, Ginv = body_product(S, V2), body_product(V2inv, Sinv)
            TG = lambda Z: T_prime(G, Ginv, Z)
            L0 = T_def(S, T_def(V2, T_def(S, X)))
            L1 = TS(TV2(TS(X)))
            L2 = compose(TS, TV2)(TS(X))
            L3 = TG(TS(X))
            L4 = compose(TG, TS)(X)
            L5 = T_prime(body_product(G, S), body_product(Sinv, Ginv), X)
            Vp = body_product(body_product(S, V2), S)
            L6 = T_prime(Vp, Vp.inverse(), X)
            L7 = T_def(Vp, X)
            chain = [L0, L1, L2, L3, L4, L5, L6, L7]
            for k in range(len(chain) - 1):
                assert chain[k] == chain[k + 1], (M, x, y, k)
            assert L0 == L7
            assert T_def(V2, T_def(S, T_def(S, X))) != L0
            GV = body_product(V2, S)
            assert T_prime(GV, GV.inverse(), TS(X)) != L0
    print(f"  M_col={M}: x, y ∈ {{2,3}} で鎖の 8 つの値が不定元の X で順に一致し、L0 = L7（数体で厳密）。対照の順は一致しない")
print("RESULT: PASS")
