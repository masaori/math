# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_vanishing_criterion
# 式ペア: モニック一次因子積の一致 = 最高次係数を交差乗算した二段多項式の一致
# 帰属: QQbar[x]、QQbar

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

for values in (ordinary_values, shared_values, associate_values):
    assert values["monic_products_agree"] == values["cross_products_agree"]

print("RESULT: PASS — leading-coefficient cross multiplication detects associates exactly")
