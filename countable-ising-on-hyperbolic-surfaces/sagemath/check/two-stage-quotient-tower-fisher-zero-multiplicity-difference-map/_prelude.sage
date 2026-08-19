# 対象ラベル: def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map
# 帰属: ZZ[x]、QQbar[x]、ZZ だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../two-stage-quotient-tower-fisher-zero-multiplicity-pair-map/_prelude.sage",
    )
)


def multiplicity_difference(alpha, pair_function=multiplicity_pair):
    fine_multiplicity, coarse_multiplicity = pair_function(alpha)
    return ZZ(fine_multiplicity) - ZZ(coarse_multiplicity)


common_edge_factor = 2 * (1 + x)
shared_fine_partition_polynomial = fine_partition_polynomial * common_edge_factor
shared_coarse_partition_polynomial = coarse_partition_polynomial * common_edge_factor
shared_fine_root_multiplicities = exact_root_multiplicities(
    shared_fine_partition_polynomial
)
shared_coarse_root_multiplicities = exact_root_multiplicities(
    shared_coarse_partition_polynomial
)
shared_two_stage_zero_support = (
    set(shared_fine_root_multiplicities) | set(shared_coarse_root_multiplicities)
)


def shared_multiplicity_pair(alpha):
    return (
        ZZ(shared_fine_root_multiplicities.get(alpha, 0)),
        ZZ(shared_coarse_root_multiplicities.get(alpha, 0)),
    )
