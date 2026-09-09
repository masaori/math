# 対象ラベル: claim_cyclic_stage_uniform_marginal_formula
# 併せて検証: claim_cyclic_stage_uniform_distribution_normalized
# 式ペア・判定: 一様有限舞台分布を直接有限和し、正規化と ν_(m,s)(a)=1/2^(2s+1) を検査する。
# 帰属: 有限集合、ZZ、QQ。有理数内の正の分母による除算だけを使い、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stage_distributions_checked = ZZ(0)
marginals_checked = ZZ(0)
for stage in range(7):
    stage_configurations = configurations(stage_cells(stage))
    weight = uniform_weight(stage)
    assert ZZ(2) ** ZZ(stage_length(stage)) > 0
    assert sum((weight for _configuration in stage_configurations), QQ(0)) == QQ(1)
    stage_distributions_checked += 1

    for radius in range(stage + 1):
        expected = QQ(1) / (ZZ(2) ** ZZ(2 * radius + 1))
        assert expected > QQ(0)
        values = marginal_table(stage, radius)
        for observation, actual in values.items():
            assert actual == expected
            marginals_checked += 1
        assert sum(values.values(), QQ(0)) == QQ(1)

assert stage_distributions_checked == ZZ(7)
assert marginals_checked == ZZ(14558)
print('normalized stage distributions checked:', stage_distributions_checked)
print('finite-window marginal values checked:', marginals_checked)
print('RESULT: PASS')
