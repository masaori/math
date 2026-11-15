# 対象ラベル: claim_signed_even_subgraph_rational_sign
# 本文の式鎖 0 <_R (q^2+2q-1)^2 <=_R Δ(q;ϖ,ς) = Δ_O(q) を、各軌道の全ての元について厳密に確かめる。
# QQbar の値の実部・虚部の比較は代数的数の厳密な比較であり、浮動小数点は使わない。
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

for length in range(1, 4):
    for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
        points, orbits = orbit_data(length, a, b)
        for q in (QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(3)/4, QQ(9)/10):
            p = q^2 + 2*q - 1
            # 一行目: 0 < (q^2+2q-1)^2
            assert p^2 > 0
            for group in orbits:
                representative = next(iter(group))
                for point in group:
                    assert point in points
                    value = delta(*point)(q)
                    # 二行目: (q^2+2q-1)^2 <= Δ(q;ϖ,ς)（実閉部分体の元として）
                    assert value.imag() == 0 and value.real() - p^2 >= 0
                    # 三行目: Δ(q;ϖ,ς) = Δ_O(q)（元の選択に依らない）
                    assert value == delta(*representative)(q)
