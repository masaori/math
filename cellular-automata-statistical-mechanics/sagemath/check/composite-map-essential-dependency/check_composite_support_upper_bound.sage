# 対象ラベル: claim_composite_map_support_bounded_by_composed_support
# 併せて検証するラベル: def_finite_configuration_map_cell_map、
#   def_global_map_essential_dependency_assignment、def_composed_neighborhood
# 合成写像の本質的依存台が合成近傍に含まれること D_{F∘G}(v) ⊆ (D_F * D_G)(v) を、
# 全ての配位写像の組（|V| <= 2）と、|V| = 3 の決められた部分族について検査する。
# 帰属: 有限集合と 0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

# |V| <= 2 の全数検査
exhaustive_pairs = {}
for cell_count in range(1, 3):
    cells = tuple(range(cell_count))
    maps = tuple(all_maps(cells))
    assignments = tuple(dependency_assignment(cells, F) for F in maps)
    count = 0
    for i, F in enumerate(maps):
        for j, G in enumerate(maps):
            composite = dependency_assignment(cells, compose_maps(cells, F, G))
            bound = composed_neighborhood(cells, assignments[i], assignments[j])
            for v in cells:
                assert composite[v] <= bound[v], (cell_count, i, j, v)
            count += 1
    exhaustive_pairs[cell_count] = count

assert exhaustive_pairs[1] == 4 ** 2
assert exhaustive_pairs[2] == 256 ** 2

# |V| = 3 は写像が 8^8 個あり全数走査しないので、決められた 8 個の値写像から作る部分族に限る。
cells3 = (0, 1, 2)
value_maps = (
    lambda x: 0,
    lambda x: 1,
    lambda x: x[0],
    lambda x: x[1],
    lambda x: x[2],
    lambda x: (x[0] + x[1] + x[2]) % 2,
    lambda x: x[0] * x[1] * x[2],
    lambda x: 1 if x[0] + x[1] + x[2] >= 2 else 0,
)
states3 = configurations(cells3)
family3 = tuple(
    {x: (h0(x), h1(x), h2(x)) for x in states3}
    for h0 in value_maps for h1 in value_maps for h2 in value_maps
)
assert len(family3) == len(value_maps) ** 3

assignments3 = tuple(dependency_assignment(cells3, F) for F in family3)
subfamily_pairs = 0
for i, F in enumerate(family3):
    for j, G in enumerate(family3):
        composite = dependency_assignment(cells3, compose_maps(cells3, F, G))
        bound = composed_neighborhood(cells3, assignments3[i], assignments3[j])
        for v in cells3:
            assert composite[v] <= bound[v], (i, j, v)
        subfamily_pairs += 1

assert subfamily_pairs == len(family3) ** 2

print(f"PASS exhaustive_pairs={exhaustive_pairs} subfamily_pairs_V3={subfamily_pairs}")
