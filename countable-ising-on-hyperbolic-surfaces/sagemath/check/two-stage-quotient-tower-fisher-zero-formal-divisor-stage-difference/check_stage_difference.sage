# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_stage_difference
# 帰属: QQbar、ZZ、有限台写像だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../two-stage-quotient-tower-fisher-zero-multiplicity-difference-formal-divisor/_prelude.sage",
    )
)


def stage_divisor(zero_support, multiplicity_function):
    return {
        alpha: ZZ(multiplicity_function(alpha))
        for alpha in zero_support
        if multiplicity_function(alpha) != 0
    }


def subtract_divisors(fine_divisor, coarse_divisor):
    combined_support = set(fine_divisor).union(set(coarse_divisor))
    return {
        alpha: fine_divisor.get(alpha, ZZ(0)) - coarse_divisor.get(alpha, ZZ(0))
        for alpha in combined_support
        if fine_divisor.get(alpha, ZZ(0)) - coarse_divisor.get(alpha, ZZ(0)) != 0
    }


def verify_stage_difference(zero_support, multiplicity_pair_function):
    for alpha in zero_support:
        fine_multiplicity, coarse_multiplicity = multiplicity_pair_function(alpha)
        assert multiplicity_difference(alpha, multiplicity_pair_function) == (
            ZZ(fine_multiplicity) - ZZ(coarse_multiplicity)
        )

    fine_divisor = stage_divisor(
        zero_support,
        lambda alpha: multiplicity_pair_function(alpha)[0],
    )
    coarse_divisor = stage_divisor(
        zero_support,
        lambda alpha: multiplicity_pair_function(alpha)[1],
    )
    difference_divisor = formal_divisor(
        zero_support,
        lambda alpha: multiplicity_difference(alpha, multiplicity_pair_function),
    )
    assert difference_divisor == subtract_divisors(fine_divisor, coarse_divisor)
    return difference_divisor


ordinary_difference_divisor = verify_stage_difference(
    two_stage_zero_support,
    multiplicity_pair,
)
shared_difference_divisor = verify_stage_difference(
    shared_two_stage_zero_support,
    shared_multiplicity_pair,
)

assert len(ordinary_difference_divisor) == 6
assert shared_difference_divisor == ordinary_difference_divisor
assert QQbar(-1) not in shared_difference_divisor

print(
    "RESULT: PASS — the exact QQbar formal multiplicity-difference divisor "
    "equals the fine-stage zero divisor minus the coarse-stage zero divisor "
    "in both the disjoint-support and shared-root examples"
)
