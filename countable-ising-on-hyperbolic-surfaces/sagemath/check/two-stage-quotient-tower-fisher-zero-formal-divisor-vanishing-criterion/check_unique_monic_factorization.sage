# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_vanishing_criterion
# 式ペア: 二段零点重複度の一致 = モニック一次因子積の一致
# 帰属: QQbar[x]、QQbar、ZZ

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

for values in (ordinary_values, shared_values, associate_values):
    assert values["multiplicities_agree"] == values["monic_products_agree"]

print("RESULT: PASS — exact QQbar root multiplicities determine the monic polynomial")
