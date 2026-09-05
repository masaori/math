# 対象ラベル: claim_cyclic_elementary_encoding_bijection
# 式ペア・判定: 初等規則番号との全単射、左・自身・右の評価式、短周期での潰れを検査する。
# 帰属: 有限集合・有限写像表・NN。状態値には演算を入れず、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

tables = tuple(elementary_table(rule) for rule in range(256))
assert len(set(tables)) == 256
assert set(tables) == set(truth_tables(1))

evaluations = 0
for length in range(1, 7):
    groups = {}
    for rule, table in enumerate(tables):
        global_table = global_map_table(table, length, 1)
        direct_table = []
        for configuration in bit_assignments(cells(length)):
            output = []
            for vertex in cells(length):
                left = configuration[(vertex - 1) % length]
                center = configuration[vertex]
                right = configuration[(vertex + 1) % length]
                index = 4 * left + 2 * center + right
                output.append((rule >> index) & 1)
                evaluations += 1
            direct_table.append(tuple(output))
        assert global_table == tuple(direct_table)
        groups.setdefault(global_table, 0)
        groups[global_table] += 1
    expected_maps = 4 if length == 1 else 16 if length == 2 else 256
    expected_fiber = 64 if length == 1 else 16 if length == 2 else 1
    assert len(groups) == expected_maps
    assert set(groups.values()) == {expected_fiber}

assert set(admissible_inputs(1, 1)) == {(0, 0, 0), (1, 1, 1)}
assert set(admissible_inputs(2, 1)) == {
    (left, center, left) for left in (0, 1) for center in (0, 1)
}
assert len(admissible_inputs(3, 1)) == 8

print('radius-one cell evaluations:', evaluations)
print('RESULT: PASS')

