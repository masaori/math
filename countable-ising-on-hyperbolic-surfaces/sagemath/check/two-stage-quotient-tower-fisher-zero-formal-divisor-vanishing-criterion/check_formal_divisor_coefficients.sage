# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_vanishing_criterion
# 式ペア: 形式的因子が零 = 二段零点重複度が全零点で一致
# 帰属: QQbar、ZZ、有限台写像

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

for values in (ordinary_values, shared_values, associate_values):
    assert values["divisor_is_zero"] == values["multiplicities_agree"]

assert not ordinary_values["divisor_is_zero"]
assert not shared_values["divisor_is_zero"]
assert associate_values["divisor_is_zero"]

print("RESULT: PASS — the exact formal divisor vanishes exactly when all multiplicities agree")
