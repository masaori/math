# SageMath: 二段 Fisher 零点重複度対写像の定義
# 対象ラベル: def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map
# 帰属: ZZ[x] と QQbar[x] だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(check_directory, "_prelude.sage"))

assert fine_partition_polynomial == 2 + 12 * x^2 + 2 * x^4
assert coarse_partition_polynomial == 2 + 2 * x^2

assert len(fine_root_multiplicities) == 4
assert len(coarse_root_multiplicities) == 2
assert set(fine_root_multiplicities).isdisjoint(set(coarse_root_multiplicities))
assert len(two_stage_zero_support) == 6

assert all(multiplicity == 1 for multiplicity in fine_root_multiplicities.values())
assert all(multiplicity == 1 for multiplicity in coarse_root_multiplicities.values())
assert all(
    multiplicity_pair(alpha) == (1, 0)
    for alpha in fine_root_multiplicities
)
assert all(
    multiplicity_pair(alpha) == (0, 1)
    for alpha in coarse_root_multiplicities
)

print(
    "RESULT: PASS — the exact QQbar zero-support union has six elements; "
    "the four fine-only roots have pair (1, 0), and the two coarse-only "
    "roots have pair (0, 1)"
)
