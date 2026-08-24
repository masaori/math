# claim_reversible_cycle_type_conjugacy_invariance の検算。
# 元数 1,2,4 の配位集合上の全ての単射な自己写像 F と全ての有限置換 h について、
# h F h^{-1} も単射であること、h が周期軌道を周期軌道へ全単射に移すこと、
# したがって巡回型が保存されることを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked_pairs = 0
checked_orbit_images = 0
for size in (1, 2, 4):
    for table in injective_maps(size):
        source_orbits = orbits_of(table)
        for permutation in itertools.permutations(range(size)):
            conjugated = conjugate_table(table, permutation)
            assert len(set(conjugated)) == size
            target_orbits = orbits_of(conjugated)
            images = set()
            for orbit_part in source_orbits:
                image = frozenset(permutation[y] for y in orbit_part)
                # h は軌道を軌道へ移し、元数を保つ。
                assert image in target_orbits
                assert len(image) == len(orbit_part)
                images.add(image)
                checked_orbit_images += 1
            # h による軌道の対応は軌道全体の全単射である。
            assert images == set(target_orbits)
            assert cycle_type(conjugated) == cycle_type(table)
            checked_pairs += 1

print(f"PASS conjugation_pairs={checked_pairs} orbit_images={checked_orbit_images}")
