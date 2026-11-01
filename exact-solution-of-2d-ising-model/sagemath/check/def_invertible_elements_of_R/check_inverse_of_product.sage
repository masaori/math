# 対象ラベル: def_invertible_elements_of_R
# (ii) h := g_2^{-1} g_1^{-1} に対する二つの鎖
#   (g_1g_2)h = (g_1g_2)(g_2^{-1}g_1^{-1}) = ((g_1g_2)g_2^{-1})g_1^{-1} = (g_1(g_2g_2^{-1}))g_1^{-1}
#             = (g_1 I)g_1^{-1} = g_1g_1^{-1} = I
#   h(g_1g_2) = (g_2^{-1}g_1^{-1})(g_1g_2) = ((g_2^{-1}g_1^{-1})g_1)g_2 = (g_2^{-1}(g_1^{-1}g_1))g_2
#             = (g_2^{-1} I)g_2 = g_2^{-1}g_2 = I
# と、主張 (g_1g_2)^{-1} = g_2^{-1}g_1^{-1}。
# 結合律の二行（第二・第三行）と単位行列との積の行（第五行）は、g_2^{-1}, g_1^{-1} を独立な不定元 a, b に置いた
# 一般の等式として一行ずつ確かめる。代入の行（第一・第四・第六行）と鎖の全体は、具体の可逆行列（成分は QQ(i)）と
# Sage の inverse で求めた逆行列で確かめる。
load("_prelude.sage")

for n in SIZES:
    P, (g1s, g2s, a, b) = generic_matrices(n, ["g1", "g2", "a", "b"])
    I = body_identity(P, n)
    # 第一の鎖（a = g_2^{-1}, b = g_1^{-1}）
    assert body_product(body_product(g1s, g2s), body_product(a, b)) == \
        body_product(body_product(body_product(g1s, g2s), a), b)                     # 第二行
    assert body_product(body_product(body_product(g1s, g2s), a), b) == \
        body_product(body_product(g1s, body_product(g2s, a)), b)                     # 第三行
    assert body_product(body_product(g1s, I), b) == body_product(g1s, b)             # 第五行
    # 第二の鎖（a = g_2^{-1}, b = g_1^{-1}）
    assert body_product(body_product(a, b), body_product(g1s, g2s)) == \
        body_product(body_product(body_product(a, b), g1s), g2s)                     # 第二行
    assert body_product(body_product(body_product(a, b), g1s), g2s) == \
        body_product(body_product(a, body_product(b, g1s)), g2s)                     # 第三行
    assert body_product(body_product(a, I), g2s) == body_product(a, g2s)             # 第五行

    IK = body_identity(K, n)
    for seed in SEEDS:
        g1 = concrete_invertible(n, seed)
        g2 = concrete_invertible(n, seed + 1000)
        g1i, g2i = g1.inverse(), g2.inverse()
        g12 = body_product(g1, g2)
        h = body_product(g2i, g1i)
        first = [
            body_product(g12, h),
            body_product(g12, body_product(g2i, g1i)),
            body_product(body_product(g12, g2i), g1i),
            body_product(body_product(g1, body_product(g2, g2i)), g1i),
            body_product(body_product(g1, IK), g1i),
            body_product(g1, g1i),
            IK,
        ]
        second = [
            body_product(h, g12),
            body_product(body_product(g2i, g1i), g12),
            body_product(body_product(body_product(g2i, g1i), g1), g2),
            body_product(body_product(g2i, body_product(g1i, g1)), g2),
            body_product(body_product(g2i, IK), g2),
            body_product(g2i, g2),
            IK,
        ]
        for chain in (first, second):
            for t in range(len(chain) - 1):
                assert chain[t] == chain[t + 1], (n, seed, t)
        # 主張: Sage が g_1 g_2 から直接求めた逆行列が g_2^{-1} g_1^{-1} に等しい
        assert g12.inverse() == h
    print(f"n = {n}: 二つの鎖の一般の行を不定元で、鎖の全体と主張を {len(SEEDS)} 組の具体の g_1, g_2 で確かめた")

print("RESULT: PASS")
