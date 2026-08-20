# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_vanishing_criterion
# 帰属: QQbar[x]、QQbar、ZZ、有限台写像だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../two-stage-quotient-tower-fisher-zero-multiplicity-difference-formal-divisor/_prelude.sage",
    )
)


def vanishing_data(fine_polynomial, coarse_polynomial):
    fine_roots = exact_root_multiplicities(fine_polynomial)
    coarse_roots = exact_root_multiplicities(coarse_polynomial)
    zero_support = set(fine_roots) | set(coarse_roots)

    def pair(alpha):
        return (ZZ(fine_roots.get(alpha, 0)), ZZ(coarse_roots.get(alpha, 0)))

    divisor = formal_divisor(
        zero_support,
        lambda alpha: multiplicity_difference(alpha, pair),
    )
    integer_differences_are_zero = all(
        ZZ(pair(alpha)[0]) - ZZ(pair(alpha)[1]) == 0 for alpha in zero_support
    )
    embedded_multiplicities_agree = all(
        ZZ(pair(alpha)[0]) == ZZ(pair(alpha)[1]) for alpha in zero_support
    )
    multiplicities_agree = all(pair(alpha)[0] == pair(alpha)[1] for alpha in zero_support)
    monic_products_agree = (
        fine_polynomial / fine_polynomial.leading_coefficient()
        == coarse_polynomial / coarse_polynomial.leading_coefficient()
    )
    cross_products_agree = (
        coarse_polynomial.leading_coefficient() * fine_polynomial
        == fine_polynomial.leading_coefficient() * coarse_polynomial
    )
    return {
        "divisor_is_zero": divisor == {},
        "integer_differences_are_zero": integer_differences_are_zero,
        "embedded_multiplicities_agree": embedded_multiplicities_agree,
        "multiplicities_agree": multiplicities_agree,
        "monic_products_agree": monic_products_agree,
        "cross_products_agree": cross_products_agree,
    }


ordinary_values = vanishing_data(
    fine_partition_polynomial,
    coarse_partition_polynomial,
)
shared_values = vanishing_data(
    shared_fine_partition_polynomial,
    shared_coarse_partition_polynomial,
)

associate_base = (x + 1) ** 2 * (x**2 + x + 1)
associate_values = vanishing_data(
    6 * associate_base,
    10 * associate_base,
)
