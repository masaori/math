# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_coefficient_sum
# 式ペア: 有限台上の係数総和 = 二段零点台上の零延長された重複度差の総和
# 帰属: ZZ

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

assert ordinary_values["support_sum"] == ordinary_values["union_sum"]
assert shared_values["support_sum"] == shared_values["union_sum"]

print("RESULT: PASS — extending by zero preserves the exact ZZ coefficient sum")
