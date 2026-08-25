# 対象ラベル: claim_composite_map_support_bounded_by_composed_support
# 併せて検証するラベル: claim_support_is_minimum_representing_set、
#   claim_global_map_composition_representable_on_composed_neighborhood、
#   claim_representable_implies_support_subset
# 本文の証明の三段を分けて検査する。
#   (1) 各セルの値写像 G_u は D_G(u) 上の局所規則で表せる。
#   (2) 合成 F∘G の各セルの値写像は、合成近傍 (D_F * D_G)(v) 上の局所規則で表せる。
#       表現は合成局所規則族 h_v を明示的に構成して (F∘G)_v と表として突き合わせる。
#   (3) 表せることから supp が含まれる。
# 最終式だけの一致で済ませず、段ごとに別々の assert を置く。
# 帰属: 有限集合と 0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

checked = {}
for cell_count in range(1, 3):
    cells = tuple(range(cell_count))
    states = configurations(cells)
    maps = tuple(all_maps(cells))
    assignments = tuple(dependency_assignment(cells, F) for F in maps)

    # (1) supp は表現集合である
    for index, F in enumerate(maps):
        for v in cells:
            assert depends_only_on(cells, cell_map(cells, F, v), assignments[index][v])

    count = 0
    for i, F in enumerate(maps):
        for j, G in enumerate(maps):
            D_F, D_G = assignments[i], assignments[j]
            bound = composed_neighborhood(cells, D_F, D_G)
            composite_map = compose_maps(cells, F, G)
            for v in cells:
                composite_cell = cell_map(cells, composite_map, v)

                # (2) 合成局所規則族 h_v を合成近傍上に明示構成する。
                #     h_v(z) := F_v(u |-> G_u(z の D_G(u) への制限))。
                #     z は (D_F * D_G)(v) 上の値の組で、D_G(u) ⊆ (D_F * D_G)(v) を使う。
                bound_index = tuple(sorted(bound[v]))
                h = {}
                for z in product((0, 1), repeat=len(bound_index)):
                    fill = dict(zip(bound_index, z))
                    # D_G(u) の外の座標は h_v の値に影響しないので 0 で埋める。
                    witness = tuple(fill.get(w, 0) for w in cells)
                    middle = G[witness]
                    h[z] = F[middle][v]
                for x in states:
                    key = tuple(x[w] for w in bound_index)
                    assert h[key] == composite_cell[x], (cell_count, i, j, v, x)

                # (3) 表せる ⇒ supp ⊆ 合成近傍
                assert depends_only_on(cells, composite_cell, bound[v])
                assert support(cells, composite_cell) <= bound[v]
            count += 1
    checked[cell_count] = count

assert checked[1] == 16
assert checked[2] == 65536

print(f"PASS representation_steps_pairs={checked}")
