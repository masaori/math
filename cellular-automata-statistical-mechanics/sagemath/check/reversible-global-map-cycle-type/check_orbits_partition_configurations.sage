# claim_reversible_orbits_partition_configurations の検算。
# 元数 1,2,4,8 の配位集合上の全ての単射な自己写像について、周期軌道の集合 𝒪_F が
# A^V の分割であること、すなわち合併が A^V であることと、相異なる二軌道が交わらないことを
# それぞれ分けて検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked_maps = 0
checked_pairs = 0
for size in (1, 2, 4, 8):
    for table in injective_maps(size):
        checked_maps += 1
        collection = sorted(orbits_of(table), key=sorted)
        # 合併が A^V である。
        union = frozenset().union(*collection)
        assert union == frozenset(range(size))
        # 相異なる二軌道は交わらない。
        for first in range(len(collection)):
            for second in range(first + 1, len(collection)):
                assert collection[first] != collection[second]
                assert not (collection[first] & collection[second])
                checked_pairs += 1
        # 分割であることから元数の和が全体の元数に等しい。
        assert sum(len(orbit_part) for orbit_part in collection) == size

print(f"PASS maps={checked_maps} disjoint_pairs={checked_pairs}")
