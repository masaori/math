# 対象ラベル: claim_leading_distance_positive
# 帰属: ZZ[x] / QQbar / AA の厳密計算。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def main():
    checked_roots = 0
    checked_lattices = 0

    for L in [2]:
        Z = partition_polynomial(L)
        roots = Z.roots(QQbar, multiplicities=False)
        assert len(roots) >= 1

        for s in [QQbar(2).sqrt(), -QQbar(2).sqrt()]:
            xc = AA(-1 + s)
            distances = []

            for xi in roots:
                a = AA(xi.real())
                b = AA(xi.imag())

                dsq = (a - xc) * (a - xc) + b * b
                assert dsq in AA
                assert dsq != 0
                assert dsq > 0

                distances.append(dsq)
                checked_roots += 1

            d1 = min(distances)
            assert d1 != 0
            assert d1 > 0
            checked_lattices += 1

    # 「二つの平方の和は平方」の段を単純な AA の元で厳密確認する。
    u = AA(2) / 3
    v = AA(1) / 3
    dsq_sample = u * u + v * v
    w = dsq_sample.sqrt()
    assert w in AA
    assert w != 0
    assert dsq_sample == w * w

    assert checked_lattices == 2
    print("OK: claim_leading_distance_positive (%d 個の零点、%d 個の先頭距離)" %
          (checked_roots, checked_lattices))


main()
