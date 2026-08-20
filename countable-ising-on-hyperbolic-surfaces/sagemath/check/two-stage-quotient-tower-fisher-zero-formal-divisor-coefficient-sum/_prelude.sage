# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_coefficient_sum
# 帰属: QQbar、ZZ、有限台写像だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../two-stage-quotient-tower-fisher-zero-multiplicity-difference-formal-divisor/_prelude.sage",
    )
)


def coefficient_sum(divisor):
    return sum((ZZ(coefficient) for coefficient in divisor.values()), ZZ(0))


def verify_for_example(zero_support, multiplicity_pair_function, fine_polynomial, coarse_polynomial):
    difference_function = lambda alpha: multiplicity_difference(alpha, multiplicity_pair_function)
    difference_divisor = formal_divisor(zero_support, difference_function)
    support_sum = coefficient_sum(difference_divisor)
    union_sum = sum((ZZ(difference_function(alpha)) for alpha in zero_support), ZZ(0))
    fine_union_sum = sum((ZZ(multiplicity_pair_function(alpha)[0]) for alpha in zero_support), ZZ(0))
    coarse_union_sum = sum((ZZ(multiplicity_pair_function(alpha)[1]) for alpha in zero_support), ZZ(0))
    fine_root_sum = sum((ZZ(root[1]) for root in fine_polynomial.roots(QQbar)), ZZ(0))
    coarse_root_sum = sum((ZZ(root[1]) for root in coarse_polynomial.roots(QQbar)), ZZ(0))
    return {
        "support_sum": support_sum,
        "union_sum": union_sum,
        "distributed_sum": fine_union_sum - coarse_union_sum,
        "root_sum_difference": fine_root_sum - coarse_root_sum,
        "degree_difference": ZZ(fine_polynomial.degree()) - ZZ(coarse_polynomial.degree()),
    }


ordinary_values = verify_for_example(
    two_stage_zero_support,
    multiplicity_pair,
    fine_partition_polynomial,
    coarse_partition_polynomial,
)
shared_values = verify_for_example(
    shared_two_stage_zero_support,
    shared_multiplicity_pair,
    shared_fine_partition_polynomial,
    shared_coarse_partition_polynomial,
)
