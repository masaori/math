# 対象ラベル: claim_subset_union_map_image_is_union_preserving_maps
# 合併保存性と近傍割り当ての合併作用としての表現可能性の両方向を検査する。
# 帰属: 有限集合、有限部分集合、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

all_maps_scanned = 0
representable_maps = 0
for n in (0, 1, 2):
    cells = tuple(range(n))
    assignment_tables = {union_map_table(cells, N) for N in neighborhood_assignments(cells)}
    for table in all_subset_maps(cells):
        all_maps_scanned += 1
        preserving = is_union_preserving(cells, table)
        representable = table in assignment_tables
        assert preserving == representable
        if preserving:
            representable_maps += 1
            N = reconstruct_assignment(cells, table)
            assert union_map_table(cells, N) == table

# 三元舞台では全写像 8^8 個を走らず、全 512 近傍割り当ての像を尽くす。
cells = tuple(range(3))
for N in neighborhood_assignments(cells):
    table = union_map_table(cells, N)
    assert is_union_preserving(cells, table)
    assert union_map_table(cells, reconstruct_assignment(cells, table)) == table

print("all subset maps scanned for n <= 2:", all_maps_scanned)
print("representable maps among them:", representable_maps)
print("three-cell assignment images scanned:", len(neighborhood_assignments(cells)))
print("PASS check_image_characterization")
