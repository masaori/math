# 対象ラベル: def_finite_size_scaling_reading
# 帰属: ZZ[x] / QQ[d,c,u] / QQbar / AA の厳密計算。
# L=3 の先頭距離 d_1(3) を根に持つ多項式を、AA の minpoly を使わず
# 終結式で構成し、既存の 256 bit 包含区間で正しい既約因子を選ぶ。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def leading_distance_interval(L, critical_point):
    polynomial = partition_polynomial(L)
    roots = polynomial.roots(QQbar, multiplicities=False)
    interval_field = RealIntervalField(256)
    pairs = []
    for root in roots:
        distance_squared = ((AA(root.real()) - critical_point) ** 2
                            + AA(root.imag()) ** 2)
        pairs.append((interval_field(distance_squared), root))

    candidate_interval, candidate_root = min(
        pairs, key=lambda item: item[0].center())
    conjugate_root = candidate_root.conjugate()
    for interval, root in pairs:
        if root != candidate_root and root != conjugate_root:
            assert candidate_interval.upper() < interval.lower()
    return polynomial, candidate_interval


def main():
    L = 3
    critical_point = AA(QQbar(2).sqrt() - 1)
    partition, candidate_interval = leading_distance_interval(
        L, critical_point)

    # Z_3 の定数因子 2 は零点を変えないので、原始既約因子 p を使う。
    partition_factors = list(partition.factor())
    assert len(partition_factors) == 2
    p_univariate = max(
        (factor for factor, _multiplicity in partition_factors),
        key=lambda factor: factor.degree())
    assert p_univariate.degree() == 12

    # u,v を p の二つの根、c を臨界点、d=(u-c)(v-c) とする。
    # v=c+d/(u-c) を p(v)=0 へ代入し、分母 (u-c)^12 を払った q を作る。
    # Res_u(p,q) は、p の根二つから生じる全距離候補を含む。
    ring = PolynomialRing(QQ, names=('d', 'c', 'u'), order='lex')
    d, c, u = ring.gens()
    coefficients = p_univariate.list()
    p = sum(QQ(coefficient) * u ** exponent
            for exponent, coefficient in enumerate(coefficients))
    substituted_numerator = sum(
        QQ(coefficient)
        * (c * (u - c) + d) ** exponent
        * (u - c) ** (p_univariate.degree() - exponent)
        for exponent, coefficient in enumerate(coefficients))
    pair_eliminant = p.resultant(substituted_numerator, u)
    assert pair_eliminant.degree(d) == 144

    # c^2+2c-1=0 を消去する。もう一方の根 -sqrt(2)-1 に由来する候補も
    # 入るが、最後に d_1(3) の包含区間で正しい既約因子だけを選ぶ。
    critical_eliminant = pair_eliminant.resultant(c ** 2 + 2 * c - 1, c)
    eliminant_univariate = critical_eliminant.univariate_polynomial()
    assert eliminant_univariate.degree() == 288
    factors = list(eliminant_univariate.factor())
    assert sorted((factor.degree(), multiplicity)
                  for factor, multiplicity in factors) == [
                      (12, 2), (24, 1), (24, 2), (96, 2)]

    interval_field = candidate_interval.parent()
    candidates = []
    excluded = []
    for factor, multiplicity in factors:
        value_interval = interval_field(factor(candidate_interval))
        if value_interval.contains_zero():
            candidates.append((factor, multiplicity, value_interval))
        else:
            excluded.append((factor, multiplicity, value_interval))
    assert len(candidates) == 1
    selected_factor, selected_multiplicity, selected_value = candidates[0]
    assert selected_factor.degree() == 96
    assert selected_multiplicity == 2
    assert selected_factor.is_irreducible()
    assert len(excluded) == 3
    common_denominator = lcm(
        coefficient.denominator() for coefficient in selected_factor)
    integer_ring = PolynomialRing(ZZ, names=('d',))
    integer_factor = integer_ring(common_denominator * selected_factor)
    assert integer_factor.degree() == 96
    assert integer_factor.content() == 1

    # a_rho(3) の表示だけ実対数による実数体への脱出である。
    real_field = RealBallField(128)
    scaling_reading = (-real_field(candidate_interval.center()).log()
                       / (2 * real_field(L).log()))

    print('L = 3')
    print('  Z_3 primitive factor degree = %d' % p_univariate.degree())
    print('  distance eliminant degree = %d' % eliminant_univariate.degree())
    print('  irreducible factors (degree, multiplicity) = %s' %
          sorted((factor.degree(), multiplicity)
                 for factor, multiplicity in factors))
    print('  d_1(3) interval = %s' % candidate_interval)
    print('  selected factor degree = %d' % selected_factor.degree())
    print('  primitive ZZ factor leading coefficient = %s' %
          integer_factor.leading_coefficient())
    print('  primitive ZZ factor constant coefficient = %s' %
          integer_factor[0])
    print('  selected factor interval value = %s' % selected_value)
    print('  excluded factor degrees = %s' %
          sorted(factor.degree() for factor, _multiplicity, _value in excluded))
    print('  a_rho(3) in RealBallField(128) = %s' % scaling_reading)
    print('OK: resultant definition polynomial for d_1(3)')


main()
