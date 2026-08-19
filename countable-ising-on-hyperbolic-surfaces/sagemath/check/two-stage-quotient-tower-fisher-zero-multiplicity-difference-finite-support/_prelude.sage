# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_multiplicity_difference_finite_support
# 帰属: ZZ[x]、QQbar[x]、ZZ、有限集合だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../two-stage-quotient-tower-fisher-zero-multiplicity-difference-map/_prelude.sage",
    )
)


def multiplicity_difference_support(zero_support, difference_function):
    return {
        alpha
        for alpha in zero_support
        if difference_function(alpha) != 0
    }
