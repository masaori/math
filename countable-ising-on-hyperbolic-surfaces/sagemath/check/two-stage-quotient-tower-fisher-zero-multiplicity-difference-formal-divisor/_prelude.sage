# 対象ラベル: def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor
# 帰属: QQbar、ZZ、有限台写像だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../two-stage-quotient-tower-fisher-zero-multiplicity-difference-finite-support/_prelude.sage",
    )
)


def formal_divisor(zero_support, difference_function):
    return {
        alpha: ZZ(difference_function(alpha))
        for alpha in zero_support
        if difference_function(alpha) != 0
    }
