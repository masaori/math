# 対象ラベル: def_invertible_elements_of_R
# 逆元の一意性の鎖 h_1 = h_1 I = h_1(g h_2) = (h_1 g) h_2 = I h_2 = h_2。
# 等号の第一・第三・第五行は仮定を使わない一般の等式なので不定元で、
# 第二・第四行は仮定 g h_2 = I・h_1 g = I の代入なので、具体の可逆行列 g（成分は QQ(i)）と、
# Sage の solve_left / solve_right で独立に求めた h_1（左から掛けて I）・h_2（右から掛けて I）で確かめる。
load("_prelude.sage")

for n in SIZES:
    P, (h1s, gs, h2s) = generic_matrices(n, ["h1", "g", "h2"])
    I = body_identity(P, n)
    assert h1s == body_product(h1s, I)                                     # 第一行
    assert body_product(h1s, body_product(gs, h2s)) == body_product(body_product(h1s, gs), h2s)  # 第三行
    assert body_product(I, h2s) == h2s                                     # 第五行

    IK = body_identity(K, n)
    for seed in SEEDS:
        g = concrete_invertible(n, seed)
        h1 = g.solve_left(IK)    # h1 * g = I を解く
        h2 = g.solve_right(IK)   # g * h2 = I を解く
        # 仮定: h_1, h_2 はどちらも両側の逆元の条件を満たす
        assert body_product(g, h1) == IK and body_product(h1, g) == IK
        assert body_product(g, h2) == IK and body_product(h2, g) == IK
        chain = [
            h1,
            body_product(h1, IK),
            body_product(h1, body_product(g, h2)),
            body_product(body_product(h1, g), h2),
            body_product(IK, h2),
            h2,
        ]
        # 第二行: g h_2 = I の代入、第四行: h_1 g = I の代入
        assert body_product(g, h2) == IK
        assert body_product(h1, g) == IK
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], (n, seed, t)
    print(f"n = {n}: 鎖の一般の行を不定元で、鎖の全体を {len(SEEDS)} 個の具体の g で確かめた")

print("RESULT: PASS")
