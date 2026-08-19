# SageMath: 二段 Fisher 零点重複度差写像の定義
# 対象ラベル: def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map
# 帰属: ZZ[x]、QQbar[x]、ZZ だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(check_directory, "_prelude.sage"))

assert all(
    multiplicity_difference(alpha) == 1
    for alpha in fine_root_multiplicities
)
assert all(
    multiplicity_difference(alpha) == -1
    for alpha in coarse_root_multiplicities
)

shared_root = QQbar(-1)
assert shared_root in shared_fine_root_multiplicities
assert shared_root in shared_coarse_root_multiplicities
assert shared_multiplicity_pair(shared_root) == (1, 1)
assert multiplicity_difference(shared_root, shared_multiplicity_pair) == 0

fine_only_roots = (
    set(shared_fine_root_multiplicities) - set(shared_coarse_root_multiplicities)
)
coarse_only_roots = (
    set(shared_coarse_root_multiplicities) - set(shared_fine_root_multiplicities)
)
assert len(fine_only_roots) == 4
assert len(coarse_only_roots) == 2
assert all(
    multiplicity_difference(alpha, shared_multiplicity_pair) == 1
    for alpha in fine_only_roots
)
assert all(
    multiplicity_difference(alpha, shared_multiplicity_pair) == -1
    for alpha in coarse_only_roots
)

print(
    "RESULT: PASS — the shared root -1 has difference 0; "
    "the four fine-only roots have difference 1, and the two coarse-only "
    "roots have difference -1"
)
