# 対象ラベル: claim_probabilistic_finite_step_rational_closure
# 併せて検証: theorem_probabilistic_global_transition_normalized
# 零回の恒等遷移と再帰的な有限和・有限積を段別に検査し、有限回の有理閉性と正規化を確認する。
# 帰属: 有限集合、QQ、ZZ、有限回数 n in NN。有理数体上の除算だけを使い、極限、未定義の対数・除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_common.sage'))

allowed_weights = (QQ(0), QQ(1) / QQ(2), QQ(1))
families_by_size = {
    0: rule_families(0, allowed_weights),
    1: rule_families(1, allowed_weights),
    2: (
        {0: {state: QQ(1) / QQ(2) for state in configurations(2)}, 1: {state: QQ(1) / QQ(2) for state in configurations(2)}},
        {0: {state: QQ(state[0]) for state in configurations(2)}, 1: {state: QQ(state[1]) for state in configurations(2)}},
        {0: {state: QQ(state[1]) for state in configurations(2)}, 1: {state: QQ(1 - state[0]) for state in configurations(2)}},
    ),
}

family_count = ZZ(0)
step_count = ZZ(0)
entry_count = ZZ(0)

for cell_count, families in families_by_size.items():
    states = configurations(cell_count)
    for family in families:
        one_step = transition_matrix(family, cell_count)
        current = identity_transition(cell_count)
        for source in states:
            for target in states:
                assert current[source][target] == (QQ(1) if source == target else QQ(0))
        for finite_step in range(5):
            for source in states:
                row_sum = sum((current[source][target] for target in states), QQ(0))
                assert row_sum == QQ(1)
                for target in states:
                    assert current[source][target] in QQ
                    assert current[source][target] >= QQ(0)
                    assert current[source][target] <= QQ(1)
                    entry_count += 1
            step_count += 1
            if finite_step < 4:
                next_transition = compose_transitions(current, one_step)
                for source in states:
                    for target in states:
                        defining_sum = sum(
                            (current[source][middle] * one_step[middle][target] for middle in states),
                            QQ(0),
                        )
                        assert next_transition[source][target] == defining_sum
                current = next_transition
        family_count += 1

assert family_count == ZZ(13)
assert step_count == ZZ(65)
assert entry_count == ZZ(425)
print('finite rational rule families checked:', family_count)
print('finite transition powers checked:', step_count)
print('rational transition entries checked:', entry_count)
print('RESULT: PASS')
