# SageMath: 固定剰余類格子の Fisher 零点の有理矩形根分離証明書
# 対象ラベル: theorem_fixed_quotient_fisher_zero_rational_rectangle_isolation
# 帰属: QQ、QQ^rc、QQbar と有理端点の認証付き複素区間だけを用いる

import os

from sage.rings.polynomial.complex_roots import complex_roots

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

upper_rectangle_endpoints = [
    (QQ(-105)/32, QQ(-209)/64, QQ(61)/16, QQ(245)/64),
    (QQ(-191)/256, QQ(-95)/128, QQ(31)/32, QQ(249)/256),
    (QQ(-241)/512, QQ(-15)/32, QQ(37)/64, QQ(149)/256),
    (QQ(-227)/512, QQ(-113)/256, QQ(93)/128, QQ(187)/256),
    (QQ(-113)/256, QQ(-225)/512, QQ(59)/128, QQ(237)/512),
    (QQ(-195)/512, QQ(-97)/256, QQ(167)/256, QQ(21)/32),
    (QQ(-137)/512, QQ(-17)/64, QQ(191)/256, QQ(3)/4),
    (QQ(-239)/2048, QQ(-119)/1024, QQ(191)/256, QQ(3)/4),
    (QQ(129)/2048, QQ(65)/1024, QQ(93)/128, QQ(187)/256),
    (QQ(5)/32, QQ(161)/1024, QQ(79)/128, QQ(159)/256),
    (QQ(197)/1024, QQ(99)/512, QQ(181)/256, QQ(91)/128),
    (QQ(23)/64, QQ(185)/512, QQ(25)/32, QQ(201)/256),
    (QQ(247)/512, QQ(31)/64, QQ(39)/16, QQ(157)/64),
    (QQ(125)/256, QQ(251)/512, QQ(175)/256, QQ(11)/16),
    (QQ(143)/256, QQ(9)/16, QQ(67)/128, QQ(135)/256),
    (QQ(151)/256, QQ(19)/32, QQ(101)/256, QQ(203)/512),
    (QQ(39)/64, QQ(157)/256, QQ(65)/64, QQ(131)/128),
    (QQ(39)/64, QQ(157)/256, QQ(37)/128, QQ(149)/512),
    (QQ(81)/128, QQ(163)/256, QQ(51)/256, QQ(205)/1024),
    (QQ(85)/128, QQ(171)/256, QQ(227)/2048, QQ(57)/512),
    (QQ(171)/256, QQ(43)/64, QQ(103)/128, QQ(207)/256),
    (QQ(181)/256, QQ(91)/128, QQ(249)/512, QQ(125)/256),
]

assert len(upper_rectangle_endpoints) == 22
assert all(a < b and 0 < c < d for a, b, c, d in upper_rectangle_endpoints)

complex_interval_field = ComplexIntervalField(8)
real_interval_field = RealIntervalField(8)


def rational_rectangle(a, b, c, d):
    return complex_interval_field(
        real_interval_field(a, b),
        real_interval_field(c, d),
    )


upper_rectangles = [
    rational_rectangle(a, b, c, d)
    for a, b, c, d in upper_rectangle_endpoints
]
lower_rectangles = [
    rational_rectangle(a, b, -d, -c)
    for a, b, c, d in upper_rectangle_endpoints
]
all_rectangles = upper_rectangles + lower_rectangles

assert len(all_rectangles) == 44
assert all(
    not all_rectangles[left].overlaps(all_rectangles[right])
    for left in range(44)
    for right in range(left)
)


def exact_endpoints(real_interval):
    return tuple(QQ(endpoint.exact_rational()) for endpoint in real_interval.endpoints())


def rectangle_contains(outer, inner):
    outer_real_lower, outer_real_upper = exact_endpoints(outer.real())
    outer_imag_lower, outer_imag_upper = exact_endpoints(outer.imag())
    inner_real_lower, inner_real_upper = exact_endpoints(inner.real())
    inner_imag_lower, inner_imag_upper = exact_endpoints(inner.imag())
    return (
        outer_real_lower <= inner_real_lower
        and inner_real_upper <= outer_real_upper
        and outer_imag_lower <= inner_imag_lower
        and inner_imag_upper <= outer_imag_upper
    )


certified_interval_roots = complex_roots(
    irreducible_factor,
    skip_squarefree=True,
    retval="interval",
)
assert len(certified_interval_roots) == 44
assert all(multiplicity == 1 for _, multiplicity in certified_interval_roots)

containment_matrix = [
    [rectangle_contains(rectangle, root_interval) for root_interval, _ in certified_interval_roots]
    for rectangle in all_rectangles
]
assert all(sum(row) == 1 for row in containment_matrix)
assert all(
    sum(containment_matrix[rectangle_index][root_index] for rectangle_index in range(44)) == 1
    for root_index in range(44)
)

common_polynomial = QQbar.common_polynomial(irreducible_factor)
isolated_roots = [
    QQbar.polynomial_root(common_polynomial, rectangle)
    for rectangle in all_rectangles
]
assert len(set(isolated_roots)) == 44
assert all(irreducible_factor(root) == 0 for root in isolated_roots)
assert set(isolated_roots) == set(
    irreducible_factor.roots(ring=QQbar, multiplicities=False)
)
assert all(
    lower_root == upper_root.conjugate()
    for upper_root, lower_root in zip(isolated_roots[:22], isolated_roots[22:])
)

print(
    "RESULT: PASS — 22 rational upper-half-plane rectangles and their "
    "conjugates are pairwise disjoint, each contains exactly one root of "
    "Q_Q, and together they isolate all 44 algebraic roots"
)
