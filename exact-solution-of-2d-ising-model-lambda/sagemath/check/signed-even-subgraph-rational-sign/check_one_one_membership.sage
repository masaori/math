# 対象ラベル: claim_signed_even_subgraph_rational_sign
# 本文の (1,1) の所属の三行と、{(1,1)} の形の一元軌道の個数を辺長一から四で厳密に確かめる。
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

one = QQbar(1)
# (-1)^1 = -1 ≠ 1（ℚ の四則）
assert (-1)^0 == 1 and (-1)^1 == -1 and -1 != 1
# O(1,1) = {(1,1)}（1^{-1} = 1）
assert orbit((one, one)) == frozenset({(one, one)})

for length in range(1, 5):
    for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
        points, orbits = orbit_data(length, a, b)
        membership = (one, one) in points
        # 一行目: (1,1) ∈ U_a × W_b ⟺ 1^L = (-1)^a かつ 1^L = (-1)^b
        assert membership == (one^length == (-1)^a and one^length == (-1)^b)
        # 二行目: ⟺ 1 = (-1)^a かつ 1 = (-1)^b（1^L = 1）
        assert one^length == 1
        assert membership == (1 == (-1)^a and 1 == (-1)^b)
        # 三行目: ⟺ (a,b) = (0,0)
        assert membership == ((a, b) == (0, 0))
        # (1,1) を含む軌道は O(1,1) だけ
        for group in orbits:
            if (one, one) in group:
                assert group == frozenset({(one, one)})
        # {(1,1)} の形の一元軌道は (a,b) = (0,0) のときただ一つ、それ以外は無い
        count = sum(1 for group in orbits if group == frozenset({(one, one)}))
        assert count == int((a, b) == (0, 0))
