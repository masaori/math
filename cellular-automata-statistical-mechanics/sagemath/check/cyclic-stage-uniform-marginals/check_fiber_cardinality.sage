# 対象ラベル: claim_cyclic_stage_uniform_marginal_formula
# 式ペア・判定: r_(m,s) の各繊維を全列挙し、その元数が 2^(2(m-s)) であることを検査する。
# 帰属: 有限集合と ZZ・NN。除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

fiber_cases = ZZ(0)
configurations_scanned = ZZ(0)
for stage in range(7):
    stage_configurations = configurations(stage_cells(stage))
    for radius in range(stage + 1):
        expected = ZZ(2) ** ZZ(2 * (stage - radius))
        fibers = {observation: ZZ(0) for observation in configurations(window(radius))}
        for configuration in stage_configurations:
            fibers[restrict_to_window(configuration, stage, radius)] += 1
            configurations_scanned += 1
        assert all(cardinality == expected for cardinality in fibers.values())
        assert sum(fibers.values(), ZZ(0)) == ZZ(2) ** ZZ(stage_length(stage))
        fiber_cases += len(fibers)

assert fiber_cases == ZZ(14558)
assert configurations_scanned == ZZ(72818)
print('fibers checked:', fiber_cases)
print('stage configurations scanned:', configurations_scanned)
print('RESULT: PASS')
