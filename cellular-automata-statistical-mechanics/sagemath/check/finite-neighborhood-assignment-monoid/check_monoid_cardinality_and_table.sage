# 対象ラベル: claim_finite_neighborhood_assignment_monoid_cardinality_decidable
# 併せて検証するラベル: claim_finite_neighborhood_assignments_form_monoid
# 近傍割り当て全体が合成で閉じること、元数が (2^|V|)^|V| = 2^(|V|^2) であること、
# 合成表・単位元を有限回の所属判定で決定できることを、|V| <= 3（元数は |V| <= 4）で検査する。
# 合成表の全数構成は |V| <= 2 に限る（|V|=3 では 512^2 = 262144 組）。
# 帰属: 有限集合、有限写像、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

# 元数 |N(V)| = (2^|V|)^|V| = 2^(|V|^2)
for cell_count in range(0, 5):
    cells = tuple(range(cell_count))
    enumerated = neighborhood_assignments(cells)
    assert len(set(enumerated)) == len(enumerated)
    assert len(enumerated) == (2 ** cell_count) ** cell_count
    assert len(enumerated) == 2 ** (cell_count ** 2)

# 閉性と単位元（|V| <= 3 の全ての組）
closure_checks = 0
for cell_count in range(1, 4):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    universe = set(assignments)
    identity = identity_assignment(cells)
    assert identity in universe
    for outer in assignments:
        for inner in assignments:
            product_assignment = compose(cells, outer, inner)
            assert product_assignment in universe
            closure_checks += 1

# 合成表の有限決定（|V| <= 2）
table_entries = 0
for cell_count in range(0, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    place = {assignment: index for index, assignment in enumerate(assignments)}
    table = [[place[compose(cells, outer, inner)] for inner in assignments]
             for outer in assignments]
    size = len(assignments)
    assert len(table) == size
    assert all(len(row) == size for row in table)
    identity_index = place[identity_assignment(cells)]
    for index in range(size):
        assert table[identity_index][index] == index
        assert table[index][identity_index] == index
    table_entries += size * size

print(f"PASS closure_checks={closure_checks} table_entries={table_entries}")
