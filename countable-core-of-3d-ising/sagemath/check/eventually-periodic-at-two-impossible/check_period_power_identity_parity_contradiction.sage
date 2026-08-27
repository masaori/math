# 式ペア: (2u)^{(L+p)^3} = (2v)^{L^3} を仮定すると
#         2^{(L+p)^3-L^3} u^{(L+p)^3} = v^{L^3} となり、左辺は偶数・右辺は奇数で矛盾する。
# 帰属: ZZ。有限な冪と偶奇だけを使う。
load("_prelude.sage")
for L in [ZZ(2), ZZ(3), ZZ(4)]:
    for p in [ZZ(1), ZZ(2), ZZ(3)]:
        gap = site_count(L + p) - site_count(L)
        assert gap > 0
        for u in [ZZ(1), ZZ(3), ZZ(5), ZZ(7)]:
            for v in [ZZ(1), ZZ(3), ZZ(5), ZZ(9)]:
                left = (ZZ(2) * u) ** site_count(L + p)
                right = (ZZ(2) * v) ** site_count(L)
                # 両辺から 2^{L^3} を除く段が恒等式であること。
                assert left == ZZ(2) ** site_count(L + p) * u ** site_count(L + p)
                assert right == ZZ(2) ** site_count(L) * v ** site_count(L)
                reduced_left = ZZ(2) ** gap * u ** site_count(L + p)
                reduced_right = v ** site_count(L)
                assert left // ZZ(2) ** site_count(L) == reduced_left
                assert right // ZZ(2) ** site_count(L) == reduced_right
                # 左辺は偶数、右辺は奇数。ゆえに等号は起こりえない。
                assert reduced_left % 2 == 0
                assert reduced_right % 2 == 1
                assert reduced_left != reduced_right
                assert left != right
print("RESULT: PASS")
