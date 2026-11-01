# 対象ラベル: monoid_of_polar_representation
# 主張そのもの: (極座標表現) は · について結合律を満たし、e = [(1,0)] が単位元である。
# 具体の代表元の有限集合の上で、三つ組の積を左右の結合で作って類の等号で比べ、単位元の左右を確かめる。
load("../../_shared/polar_representation.sage")

cnt = 0
for p in SAMPLE:
    for q in SAMPLE:
        for s in SAMPLE:
            assert polar_equiv(mul_rep(mul_rep(p, q), s), mul_rep(p, mul_rep(q, s)))
            cnt += 1
    assert polar_equiv(mul_rep(p, E), p) and polar_equiv(mul_rep(E, p), p)
print(f"associativity on {cnt} triples and unit on {len(SAMPLE)} elements, compared as classes")
print("RESULT: PASS")
