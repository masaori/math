# 対象ラベル: claim_leading_distance_lt_iff_close_zero
# 帰属: ZZ[x] / QQbar / AA の厳密計算。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def main():
    checked_thresholds = 0
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
                distances.append(dsq)

            d1 = min(distances)
            dmax = max(distances)

            # 上界 t の標本: d1 より小さいもの・d1 と dmax の間・全零点より大きいもの。
            # 幅 (dmax - d1) は L=2 では正である（零点は等距離でない）ことも厳密に確認する。
            assert d1 < dmax
            thresholds = [
                d1 / 2,                # 第一条件も第二条件も偽になるはず
                d1,                    # 狭義なのでどちらも偽になるはず
                (d1 + dmax) / 2,       # どちらも真になるはず
                dmax + 1,              # どちらも真になるはず
            ]

            for t in thresholds:
                # 第一条件: d_1(L) <_R t（AA の厳密比較）。
                first = bool(d1 < t)
                # 第二条件: ある零点の距離の二乗が t 未満。
                second = any(bool(dsq < t) for dsq in distances)
                # 同値であることを確認する。
                assert first == second
                checked_thresholds += 1

            checked_lattices += 1

    assert checked_lattices == 2
    print("OK: claim_leading_distance_lt_iff_close_zero (%d 個の上界で同値を確認)" %
          checked_thresholds)


main()
