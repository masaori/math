# 対象ラベル: claim_composite_map_support_bounded_by_composed_support
# 併せて検証するラベル: claim_support_finite_decidability、def_composed_neighborhood
# 包含 D_{F∘G}(v) ⊆ (D_F * D_G)(v) の成否が有限手続きで決まることを検査する。
#   (1) 本質的依存台の決定に要する走査の組数が |V| * 2^{|V|} であること。
#   (2) 走査で得た依存台が、定義（存在量化）から直接得た依存台と一致すること。
#   (3) 合成近傍が有限合併で得られ、包含判定が有限個の所属判定で済むこと。
# 帰属: 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scan_counts = {}
membership_tests = {}
for cell_count in range(1, 3):
    cells = tuple(range(cell_count))
    states = configurations(cells)

    # (1) 走査する組 (u, x) の総数
    scan_pairs = [(u, x) for u in cells for x in states]
    assert len(scan_pairs) == cell_count * 2 ** cell_count
    scan_counts[cell_count] = len(scan_pairs)

    maps = tuple(all_maps(cells))
    assignments = tuple(dependency_assignment(cells, F) for F in maps)

    # (2) 走査で得た依存台と、定義からの依存台の一致
    for index, F in enumerate(maps):
        for v in cells:
            g = cell_map(cells, F, v)
            scanned = frozenset(u for (u, x) in scan_pairs if g[x] != g[flip(x, u)])
            defined = frozenset(
                u for u in cells
                if any(g[x] != g[y] for x in states for y in states
                       if all(x[w] == y[w] for w in cells if w != u))
            )
            assert scanned == defined == assignments[index][v]

    # (3) 包含判定を、合成近傍の元への所属判定の有限個の連言として実行する
    tests = 0
    for i, F in enumerate(maps):
        for j, G in enumerate(maps):
            bound = composed_neighborhood(cells, assignments[i], assignments[j])
            composite = dependency_assignment(cells, compose_maps(cells, F, G))
            for v in cells:
                decided = all(u in bound[v] for u in composite[v])
                tests += len(composite[v])
                assert decided == (composite[v] <= bound[v])
                assert decided
    membership_tests[cell_count] = tests

assert scan_counts == {1: 2, 2: 8}

print(f"PASS scan_pairs={scan_counts} membership_tests={membership_tests}")
