# 対象ラベル: claim_integer_stage_finite_observation_catalogue_countable
# 併せて検証: def_integer_stage_finite_observation_catalogue
# 式ペア・判定: |D_s|=2s+1 かつ |A|=2 から、|A^{D_s}|=2^(2s+1) となる。
# 帰属: 有限集合と NN。浮動小数点、除算、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stages_checked = 0
observations_checked = 0
for radius in range(0, 9):
    window = offsets(radius)
    observations = configurations(len(window))
    expected_count = ZZ(2) ** ZZ(2 * radius + 1)

    assert len(window) == 2 * radius + 1
    assert ZZ(len(observations)) == expected_count
    assert len(set(observations)) == len(observations)
    assert all(len(observation) == len(window) for observation in observations)
    assert all(value in STATES for observation in observations for value in observation)

    stages_checked += 1
    observations_checked += len(observations)

assert stages_checked > 0
assert observations_checked > 0
print('finite observation stages checked:', stages_checked)
print('finite observations checked:', observations_checked)
print('RESULT: PASS')
