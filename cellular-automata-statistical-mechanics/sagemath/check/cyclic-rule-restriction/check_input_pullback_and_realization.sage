# 対象ラベル: claim_cyclic_input_pullback_bijection
# 式ペア・判定: 引き戻しの相互逆と、全配位から得る入力集合の等号を検査する。
# 帰属: 有限集合と有限写像表。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

pullbacks = 0
realizations = 0
for length in range(1, 9):
    for radius in range(0, 5):
        expected = set(admissible_inputs(length, radius))
        assert len(expected) == 2 ** min(length, 2 * radius + 1)
        for vertex in cells(length):
            neighborhood = projected_neighborhood(length, radius, vertex)
            actual_pullbacks = {pullback(length, radius, vertex, y) for y in bit_assignments(neighborhood)}
            assert actual_pullbacks == expected
            assert len(actual_pullbacks) == 2 ** len(neighborhood)
            pullbacks += len(actual_pullbacks)
            if length <= 6:
                actual_inputs = {
                    configuration_input(configuration, length, radius, vertex)
                    for configuration in bit_assignments(cells(length))
                }
                assert actual_inputs == expected
                realizations += len(actual_inputs)

print('pullback values:', pullbacks, 'realized inputs:', realizations)
print('RESULT: PASS')

