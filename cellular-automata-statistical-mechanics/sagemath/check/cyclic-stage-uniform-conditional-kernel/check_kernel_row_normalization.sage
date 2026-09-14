# 対象ラベル: claim_cyclic_stage_uniform_conditional_kernel_normalized
# 式ペア・判定: 各 x について sum_y K_(m,s)(x,y)=1 を、窓外署名ごとの有限和へ分けて検査する。
# 帰属: 有限集合、ZZ、QQ。正の二冪を分母とする除算だけを使い、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

rows_checked = ZZ(0)
kernel_entries_checked = ZZ(0)
for stage in range(6):
    stage_configurations = configurations(stage_cells(stage))
    for radius in range(stage + 1):
        denominator = ZZ(2) ** ZZ(2 * radius + 1)
        assert denominator > ZZ(0)
        signature_counts = {}
        signatures = {}
        for configuration in stage_configurations:
            signature = outside_signature(configuration, stage, radius)
            signatures[configuration] = signature
            signature_counts[signature] = signature_counts.get(signature, ZZ(0)) + 1
        for source in stage_configurations:
            nonzero_entries = signature_counts[signatures[source]]
            assert nonzero_entries == denominator
            row_sum = QQ(nonzero_entries) * (QQ(1) / denominator)
            assert row_sum == QQ(1)
            rows_checked += 1
            kernel_entries_checked += len(stage_configurations)

assert rows_checked == ZZ(15474)
assert kernel_entries_checked == ZZ(26545284)
print('kernel rows checked:', rows_checked)
print('kernel entries covered by the partitioned sums:', kernel_entries_checked)
print('RESULT: PASS')
