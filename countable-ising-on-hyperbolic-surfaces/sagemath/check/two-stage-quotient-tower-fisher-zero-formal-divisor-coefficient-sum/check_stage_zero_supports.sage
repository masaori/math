# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_coefficient_sum
# 式ペア: 二段零点台上の段別重複度和 = 各段の零点台上の重複度和
# 帰属: QQbar、ZZ

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

assert ordinary_values["distributed_sum"] == ordinary_values["root_sum_difference"]
assert shared_values["distributed_sum"] == shared_values["root_sum_difference"]

print("RESULT: PASS — stagewise zero extension preserves exact root-multiplicity sums")
