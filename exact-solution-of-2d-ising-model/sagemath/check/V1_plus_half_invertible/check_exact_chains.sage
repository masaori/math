# 対象ラベル: V1_plus_half_invertible
# 二つの鎖の全行と最後の所属を厳密に確かめる。K_1 := 2 log y（y ∈ {2, 3, 3/2}）と選ぶと X = (log y)·iH_1^(+) で、
# iH_1^(+) は整数の固有値をもつ整数行列なので、exp(±X) = Σ_λ y^{±λ}P_λ が QQ に乗る（共通の準備の exp_V1_half_exact）。
# ℝ への脱出は K_1 の選び方の一点だけで、等号はすべて厳密。
#   - 第二行・第三行の exp の肩: 定義の (i/2)K_1H_1^(+) と X の肩はどちらも iH_1^(+) の (log y) 倍で、同じ射影の和になる
#     （肩の行列 iH_1^(+) が整数行列であることを KG で確かめる）
#   - 第四行: -(-X) = X は肩の行列で厳密に（matrix_double_negation）、exp(-(-X)) は sign = -(-1) で作る
#   - 各行を本文の積（mat_mult の成分の式）で組み、隣り合う行が等しく、単位行列に着く
#   - Sage の inverse で求めた逆行列が h = exp(-X) に等しい（独立な経路）
load("_prelude.sage")
for M in range(2, 5):
    n = 2**M
    Id = body_identity(QQ, n)
    S1 = iH1_plus_integer_matrix(M)
    assert body_negation(body_negation(S1)) == S1
    for y in [QQ(2), QQ(3), QQ(3)/2]:
        EX = exp_V1_half_exact(M, y, +1)
        EmX = exp_V1_half_exact(M, y, -1)
        EmmX = exp_V1_half_exact(M, y, -(-1))
        h = EmX
        B = EX
        chain1 = [body_product(B, h), body_product(B, EmX), body_product(EX, EmX), body_product(EX, EmX),
                  body_product(EmmX, EmX), Id]
        chain2 = [body_product(h, B), body_product(EmX, B), body_product(EmX, EX), body_product(EmX, EX), Id]
        check_chain(chain1, f"(V_1^(+))^(1/2) h（M={M}, y={y}）")
        check_chain(chain2, f"h (V_1^(+))^(1/2)（M={M}, y={y}）")
        assert B.inverse() == h
        assert B * h == Id and h * B == Id      # Sage の行列積でも
        # 対照: y を替えた exp(-X') は逆元にならない
        assert body_product(B, exp_V1_half_exact(M, y + 1, -1)) != Id
    print(f"  M_col={M}: y ∈ {{2,3,3/2}} で二つの鎖の各行が等しく I に着き、Sage の逆行列 = exp(-X)（QQ で厳密）")
print("RESULT: PASS")
