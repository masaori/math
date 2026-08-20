# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_coefficient_sum
# 式ペア: 段別零点重複度総和の差 = 二段多項式の次数差
# 帰属: QQbar、ZZ

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

assert ordinary_values["root_sum_difference"] == ordinary_values["degree_difference"]
assert shared_values["root_sum_difference"] == shared_values["degree_difference"]

print("RESULT: PASS — exact QQbar root multiplicities sum to both polynomial degrees")
