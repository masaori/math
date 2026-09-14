# 対象ラベル: claim_deterministic_rules_are_zero_one_probabilistic_rules
# 零一局所重みから決定論的規則を一意回復し、大域遷移重みが決定論的更新の指示関数になることを検査する。
# 帰属: 二元有限集合、QQ、ZZ。有理数体上の除算だけを使い、未定義の対数・除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_common.sage'))

allowed_weights = (QQ(0), QQ(1) / QQ(2), QQ(1))
family_count = ZZ(0)
deterministic_family_count = ZZ(0)
transition_count = ZZ(0)

for cell_count in (1, 2):
    states = configurations(cell_count)
    for family in rule_families(cell_count, allowed_weights):
        recoverable = is_zero_one_family(family)
        assert recoverable == all(
            table[local_input] in (QQ(0), QQ(1))
            for table in family.values()
            for local_input in states
        )
        if recoverable:
            deterministic_family = recover_deterministic_family(family)
            for source in states:
                updated = deterministic_global_update(deterministic_family, source)
                for target in states:
                    expected = QQ(1) if target == updated else QQ(0)
                    assert global_transition_weight(family, source, target) == expected
                    transition_count += 1
            deterministic_family_count += 1
        family_count += 1

half_family = {0: {(ZZ(0),): QQ(1) / QQ(2), (ZZ(1),): QQ(1) / QQ(2)}}
for source in configurations(1):
    assert sum((global_transition_weight(half_family, source, target) for target in configurations(1)), QQ(0)) == QQ(1)
assert not is_zero_one_family(half_family)

assert family_count == ZZ(6570)
assert deterministic_family_count == ZZ(260)
assert transition_count == ZZ(4112)
print('probabilistic rule families checked:', family_count)
print('zero-one deterministic families recovered:', deterministic_family_count)
print('deterministic transition indicators checked:', transition_count)
print('non-deterministic half-weight witness checked: 1')
print('RESULT: PASS')
