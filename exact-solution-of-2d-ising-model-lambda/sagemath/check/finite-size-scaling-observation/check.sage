# 対象ラベル: def_finite_size_scaling_reading
# 帰属: ZZ[x] / QQbar / AA の厳密計算。
# 読みの列 a_rho(L) の表示だけ RealBallField を使い、実数体への脱出を明示する。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def leading_data(L, critical_point):
    polynomial = partition_polynomial(L)
    roots = polynomial.roots(QQbar, multiplicities=False)
    assert roots

    interval_field = RealIntervalField(256)
    pairs = []
    for root in roots:
        real_part = AA(root.real())
        imaginary_part = AA(root.imag())
        distance_squared = ((real_part - critical_point) ** 2
                            + imaginary_part ** 2)
        assert distance_squared > 0
        pairs.append((distance_squared, interval_field(distance_squared), root))

    # AA の全距離を一つの数体へ統合して比較すると L=3 で PARI の 1 GiB
    # スタック上限に達する。代わりに包含区間で候補を選び、その候補と複素共役を
    # 除く全距離の下端が候補の上端より大きいことを検査する。
    candidate_distance, candidate_interval, candidate_root = min(
        pairs, key=lambda item: item[1].center())
    conjugate_root = candidate_root.conjugate()
    for _distance, interval, root in pairs:
        if root != candidate_root and root != conjugate_root:
            assert candidate_interval.upper() < interval.lower()

    return (polynomial, roots, candidate_distance,
            [candidate_root, conjugate_root])


def main():
    critical_point = AA(QQbar(2).sqrt() - 1)
    real_field = RealBallField(128)

    for L in [2]:
        polynomial, roots, leading_distance, leading_roots = leading_data(
            L, critical_point)
        distance_minpoly = leading_distance.minpoly()
        root_minpolys = sorted(
            {root.minpoly() for root in leading_roots},
            key=lambda p: (p.degree(), tuple(p.list())))

        # a_rho(L) = -log(d_1(L)) / (2 log L)。ここだけ実数体へ出る。
        scaling_reading = (-real_field(leading_distance).log()
                           / (2 * real_field(L).log()))

        print('L = %d' % L)
        print('  Z_L degree = %d, distinct roots = %d' %
              (polynomial.degree(), len(roots)))
        print('  factorization over ZZ = %s' % polynomial.factor())
        print('  leading roots = %d' % len(leading_roots))
        for root_minpoly in root_minpolys:
            print('  leading-root minpoly degree = %d' % root_minpoly.degree())
            print('  leading-root minpoly discriminant = %s' %
                  root_minpoly.discriminant())
            print('  leading-root minpoly = %s' % root_minpoly)
        print('  d_1(L) minpoly degree = %d' % distance_minpoly.degree())
        print('  d_1(L) minpoly discriminant = %s' %
              distance_minpoly.discriminant())
        print('  d_1(L) minpoly = %s' % distance_minpoly)
        print('  a_rho(L) in RealBallField(128) = %s' % scaling_reading)

    print('OK: finite-size-scaling observation for L = 2')


main()
