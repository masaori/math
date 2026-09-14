# 対象ラベル: claim_cyclic_stage_uniform_conditional_kernel_normalized
# 併せて検証: claim_cyclic_stage_window_image_cardinality
# 式ペア・判定: |W_(m,s)|=2s+1 と、窓外一致類の元数が 2^(2s+1) であることを全数検査する。
# 帰属: 有限集合と ZZ・NN。除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stage_radius_cases = ZZ(0)
agreement_classes_checked = ZZ(0)
configurations_partitioned = ZZ(0)
for stage in range(7):
    stage_configurations = configurations(stage_cells(stage))
    for radius in range(stage + 1):
        image = window_image(stage, radius)
        assert len(image) == ZZ(2 * radius + 1)
        classes = {}
        for configuration in stage_configurations:
            signature = outside_signature(configuration, stage, radius)
            classes.setdefault(signature, []).append(configuration)
            configurations_partitioned += 1
        expected_class_cardinality = ZZ(2) ** ZZ(2 * radius + 1)
        expected_class_count = ZZ(2) ** ZZ(2 * (stage - radius))
        assert len(classes) == expected_class_count
        assert all(len(members) == expected_class_cardinality for members in classes.values())
        assert sum((len(members) for members in classes.values()), ZZ(0)) == len(stage_configurations)
        stage_radius_cases += 1
        agreement_classes_checked += len(classes)

assert stage_radius_cases == ZZ(28)
assert agreement_classes_checked == ZZ(7279)
assert configurations_partitioned == ZZ(72818)
print('stage-radius pairs checked:', stage_radius_cases)
print('outside-agreement classes checked:', agreement_classes_checked)
print('configurations partitioned:', configurations_partitioned)
print('RESULT: PASS')
