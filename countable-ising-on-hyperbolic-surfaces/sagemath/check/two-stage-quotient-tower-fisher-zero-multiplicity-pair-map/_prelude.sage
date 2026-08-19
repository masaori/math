# 対象ラベル: def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map
# 帰属: ZZ[x] と QQbar[x] だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../two-stage-quotient-tower-ising-coefficient-pair-map/_prelude.sage",
    )
)


def exact_root_multiplicities(polynomial):
    return dict(polynomial.roots(ring=QQbar, multiplicities=True))


fine_root_multiplicities = exact_root_multiplicities(fine_partition_polynomial)
coarse_root_multiplicities = exact_root_multiplicities(coarse_partition_polynomial)
two_stage_zero_support = set(fine_root_multiplicities) | set(coarse_root_multiplicities)


def multiplicity_pair(alpha):
    return (
        ZZ(fine_root_multiplicities.get(alpha, 0)),
        ZZ(coarse_root_multiplicities.get(alpha, 0)),
    )
