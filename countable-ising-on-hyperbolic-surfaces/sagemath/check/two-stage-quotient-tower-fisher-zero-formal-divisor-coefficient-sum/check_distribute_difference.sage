# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_coefficient_sum
# 式ペア: 重複度差の有限和 = 細段重複度和 - 粗段重複度和
# 帰属: ZZ

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

assert ordinary_values["union_sum"] == ordinary_values["distributed_sum"]
assert shared_values["union_sum"] == shared_values["distributed_sum"]

print("RESULT: PASS — distributivity splits the exact ZZ difference sum")
