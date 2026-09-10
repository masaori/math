# 対象ラベル: theorem_cyclic_stage_uniform_conditional_kernel_invariance
# 式ペア・判定: 各 y について sum_x nu_m(x)K_(m,s)(x,y)=nu_m(y) を窓外署名ごとの有限有理和へ分けて検査する。
# 帰属: 有限集合、ZZ、QQ。正の二冪を分母とする除算だけを使い、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

fixed_point_equations_checked = ZZ(0)
kernel_entries_checked = ZZ(0)
for stage in range(6):
    stage_configurations = configurations(stage_cells(stage))
    weight = uniform_weight(stage)
    assert ZZ(2) ** ZZ(stage_length(stage)) > ZZ(0)
    for radius in range(stage + 1):
        denominator = ZZ(2) ** ZZ(2 * radius + 1)
        signature_counts = {}
        signatures = {}
        for configuration in stage_configurations:
            signature = outside_signature(configuration, stage, radius)
            signatures[configuration] = signature
            signature_counts[signature] = signature_counts.get(signature, ZZ(0)) + 1
        for target in stage_configurations:
            contributing_sources = signature_counts[signatures[target]]
            assert contributing_sources == denominator
            acted_weight = QQ(contributing_sources) * weight * (QQ(1) / denominator)
            assert acted_weight == weight
            fixed_point_equations_checked += 1
            kernel_entries_checked += len(stage_configurations)

assert fixed_point_equations_checked == ZZ(15474)
assert kernel_entries_checked == ZZ(26545284)
print('finite fixed-point equations checked:', fixed_point_equations_checked)
print('kernel entries covered by the partitioned sums:', kernel_entries_checked)
print('RESULT: PASS')
