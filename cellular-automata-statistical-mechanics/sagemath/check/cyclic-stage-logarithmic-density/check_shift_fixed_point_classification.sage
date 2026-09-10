# 対象ラベル: claim_cyclic_stage_shift_logarithmic_density_obstruction
# 併せて検証: def_cyclic_stage_shift_rule_family
# 式ペア・判定: F(x)=x と、x が二つの定値配位のいずれかであることが同値で、Z=2 となる。
# 帰属: 有限集合と NN。浮動小数点、対数、除算、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stages_checked = 0
configurations_checked = 0
for length in range(1, 17):
    domain = configurations(length)
    fixed = tuple(configuration for configuration in domain
                  if shift_image(configuration) == configuration)
    constants = tuple(tuple(state for _ in range(length)) for state in STATES)

    assert set(fixed) == set(constants)
    assert ZZ(len(fixed)) == ZZ(2)
    for configuration in domain:
        is_fixed = shift_image(configuration) == configuration
        is_constant = all(configuration[vertex] == configuration[0]
                          for vertex in range(length))
        assert is_fixed == is_constant
        configurations_checked += 1
    stages_checked += 1

assert stages_checked > 0
assert configurations_checked > 0
print('cyclic stages checked:', stages_checked)
print('configurations classified:', configurations_checked)
print('RESULT: PASS')

