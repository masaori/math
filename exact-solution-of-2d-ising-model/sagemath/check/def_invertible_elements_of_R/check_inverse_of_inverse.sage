# 対象ラベル: def_invertible_elements_of_R
# (iii) g g^{-1} = g^{-1} g = I は、g^{-1} に対して g が逆元の条件を満たすことを述べ、
# 逆元の一意性から (g^{-1})^{-1} = g。具体の可逆行列（成分は QQ(i)）で、g^{-1} を Sage の inverse で求め、
# 逆元の条件と、g^{-1} から Sage が求めた逆行列が g に戻ることを確かめる。
load("_prelude.sage")

for n in SIZES:
    IK = body_identity(K, n)
    for seed in SEEDS:
        g = concrete_invertible(n, seed)
        gi = g.inverse()
        assert body_product(g, gi) == IK and body_product(gi, g) == IK
        assert gi.inverse() == g
    print(f"n = {n}: {len(SEEDS)} 個の具体の g で確かめた")

print("RESULT: PASS")
