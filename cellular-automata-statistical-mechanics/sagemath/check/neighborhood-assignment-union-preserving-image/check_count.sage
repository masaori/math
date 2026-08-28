# 対象ラベル: claim_union_preserving_map_count
# |UP(V)| = 2^{|V|^2} の各段を自然数の厳密等号として検査する。
# 帰属: 自然数、有限集合、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

counts = []
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    assignments = neighborhood_assignments(cells)
    image_tables = {union_map_table(cells, N) for N in assignments}
    assert len(image_tables) == len(assignments)
    assert len(assignments) == (2 ** n) ** n
    assert (2 ** n) ** n == 2 ** (n * n)
    assert 2 ** (n * n) == 2 ** (n ** 2)
    counts.append(len(image_tables))

assert counts == [1, 2, 16, 512]
print("union-preserving map counts for n = 0,1,2,3:", counts)
print("PASS check_count")
