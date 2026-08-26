# 式ペア: E = 3L^2(L-1) であり、L>=2 なら E>=2、ゆえに 4 | 2^E c^{L^3}。
# 帰属: ZZ。辺の個数の数え上げと 2 の冪の可除性だけを使う。
load("_prelude.sage")
for L in [ZZ(2), ZZ(3), ZZ(4), ZZ(5)]:
    edge_count = ZZ(len(free_box_edges(L)))
    assert edge_count == 3 * L**2 * (L - 1)
    assert edge_count >= 2
    for c in [ZZ(1), ZZ(2), ZZ(3), ZZ(5), ZZ(7), ZZ(12)]:
        assert (ZZ(2)**edge_count * c**(L**3)) % 4 == 0
print("RESULT: PASS")
