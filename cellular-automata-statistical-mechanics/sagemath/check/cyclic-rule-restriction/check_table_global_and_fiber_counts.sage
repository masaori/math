# 対象ラベル: claim_cyclic_uniform_global_count
# 式ペア・判定: 表、両立入力、大域写像、実現繊維の四つの個数を分離して検査する。
# 帰属: 有限集合・NN。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

rows = []
for radius in (0, 1):
    arguments = bit_assignments(offsets(radius))
    tables = truth_tables(radius)
    assert len(arguments) == 2 ** (2 * radius + 1)
    assert len(tables) == 2 ** (2 ** (2 * radius + 1))
    for length in range(1, 7):
        admissible = admissible_inputs(length, radius)
        m = min(length, 2 * radius + 1)
        assert len(admissible) == 2 ** m
        groups = {}
        for table in tables:
            image = global_map_table(table, length, radius)
            groups.setdefault(image, 0)
            groups[image] += 1
        expected_global_count = 2 ** (2 ** m)
        expected_fiber_count = 2 ** (2 ** (2 * radius + 1) - 2 ** m)
        assert len(groups) == expected_global_count
        assert set(groups.values()) == {expected_fiber_count}
        assert len(groups) * expected_fiber_count == len(tables)
        rows.append((length, radius, len(arguments), len(admissible), len(groups), expected_fiber_count))

print('count rows:', rows)
print('RESULT: PASS')

