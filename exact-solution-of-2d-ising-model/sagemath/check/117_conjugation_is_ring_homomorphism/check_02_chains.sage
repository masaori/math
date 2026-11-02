# 対象ラベル: conjugation_is_ring_homomorphism
# 乗法性の鎖の 9 行、単位性の鎖の 3 行、合成則の準備の 3 本（右逆元・左逆元・(GH)^{-1} = H^{-1}G^{-1}、各 5 行）、合成則の鎖の 8 行について、
# 各行に書かれた式どおりに項を組み、隣り合う項が行列として等しいことを確かめる。
# T_B は mat_conj の T_B(A) := (BA)B^{-1}。
# 帰属: A・C・X の成分は QQ 上の多項式環の不定元。正則な B と合成則の G・H は QQ 上の整数行列で行列式 ±1 のものを取り、
# 逆行列は QQ 上で厳密に求めた（B^{-1}B = I などの行が使う）。不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ。
# 正則な行列は具体的な有理行列の有限個だけを試しており、一般の正則行列は人手証明が担う。浮動小数点と RR / CC への脱出はない。
load("../../_shared/matrix_operations_by_definition.sage")

set_random_seed(117)
checked = 0
for n in [1, 2, 3]:
    P, _, (Ag, Cg, Xg) = generic_ring([("A", n, n), ("C", n, n), ("X", n, n)])
    I = body_identity(P, n)
    for trial in range(4):
        B0 = random_matrix(ZZ, n, n, algorithm="unimodular")
        A0 = random_matrix(ZZ, n, n, algorithm="unimodular")
        B, Bi = B0.change_ring(P), B0.change_ring(QQ).inverse().change_ring(P)
        Ar, Ari = A0.change_ring(P), A0.change_ring(QQ).inverse().change_ring(P)
        assert body_product(Bi, B) == I and body_product(B, Bi) == I
        assert body_product(Ari, Ar) == I and body_product(Ar, Ari) == I
        mul = body_product

        def T(G, Gi, Y):
            """mat_conj の T_G(Y) := (GY)G^{-1}。"""
            return mul(mul(G, Y), Gi)

        # 乗法性の鎖（A → Ag, C → Cg）
        A, C = Ag, Cg
        chain = [
            T(B, Bi, mul(A, C)),                                     # T_B(AC)
            mul(mul(B, mul(A, C)), Bi),                              # mat_conj の T_B の定義
            mul(mul(mul(B, A), C), Bi),                              # mat_mult_associative
            mul(mul(mul(B, A), mul(I, C)), Bi),                      # identity_matrix_is_left_unit_of_mat_mult
            mul(mul(mul(B, A), mul(mul(Bi, B), C)), Bi),             # B^{-1}B = I
            mul(mul(mul(B, A), mul(Bi, mul(B, C))), Bi),             # mat_mult_associative
            mul(mul(mul(mul(B, A), Bi), mul(B, C)), Bi),             # mat_mult_associative
            mul(mul(mul(B, A), Bi), mul(mul(B, C), Bi)),             # mat_mult_associative
            mul(T(B, Bi, A), mul(mul(B, C), Bi)),                    # mat_conj の T_B の定義
            mul(T(B, Bi, A), T(B, Bi, C)),                           # mat_conj の T_B の定義
        ]
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], ("mul", n, trial, t)
        assert B0 * (Ag * Cg) * B0.inverse() == (B0 * Ag * B0.inverse()) * (B0 * Cg * B0.inverse())

        # 単位性の鎖
        chain = [T(B, Bi, I), mul(mul(B, I), Bi), mul(B, Bi), I]
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], ("one", n, trial, t)

        # 合成則の準備（G → Ar、H → B）
        AB, BiAi = mul(Ar, B), mul(Bi, Ari)
        chain = [mul(AB, BiAi), mul(Ar, mul(B, BiAi)), mul(Ar, mul(mul(B, Bi), Ari)), mul(Ar, mul(I, Ari)), mul(Ar, Ari), I]
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], ("right inverse", n, trial, t)
        chain = [mul(BiAi, AB), mul(Bi, mul(Ari, AB)), mul(Bi, mul(mul(Ari, Ar), B)), mul(Bi, mul(I, B)), mul(Bi, B), I]
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], ("left inverse", n, trial, t)
        ABi = (A0 * B0).change_ring(QQ).inverse().change_ring(P)   # 独立な経路の (GH)^{-1}
        assert body_product(ABi, AB) == I
        # (GH)^{-1} = H^{-1}G^{-1} の鎖
        chain = [ABi, mul(ABi, I), mul(ABi, mul(AB, BiAi)), mul(mul(ABi, AB), BiAi), mul(I, BiAi), BiAi]
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], ("uniqueness", n, trial, t)

        # 合成則の鎖（G → Ar、H → B、X → Xg）
        X = Xg
        chain = [
            T(Ar, Ari, T(B, Bi, X)),                                 # (T_G ∘ T_H)(X) = T_G(T_H(X))
            T(Ar, Ari, mul(mul(B, X), Bi)),                          # mat_conj の T_B の定義（B → H）
            mul(mul(Ar, mul(mul(B, X), Bi)), Ari),                   # mat_conj の T_B の定義（B → G）
            mul(mul(mul(Ar, mul(B, X)), Bi), Ari),                   # mat_mult_associative
            mul(mul(mul(mul(Ar, B), X), Bi), Ari),                   # mat_mult_associative
            mul(mul(mul(Ar, B), X), mul(Bi, Ari)),                   # mat_mult_associative
            mul(mul(mul(Ar, B), X), ABi),                            # (GH)^{-1} = H^{-1}G^{-1}
            T(AB, ABi, X),                                           # mat_conj の T_B の定義（B → GH）
        ]
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], ("comp", n, trial, t)
        # 対照: 逆元の順序を入れ替えた G^{-1}H^{-1} では一般に一致しない（n = 1 は可換なので除く）
        if n >= 2 and mul(Ari, Bi) != BiAi:
            assert mul(mul(mul(Ar, B), X), mul(Ari, Bi)) != chain[0]
        checked += 1
print(f"checked the five chains for n = 1, 2, 3 ({checked} cases)")
print("RESULT: PASS")
