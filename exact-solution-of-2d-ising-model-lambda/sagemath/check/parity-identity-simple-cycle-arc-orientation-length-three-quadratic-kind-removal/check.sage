"""一辺二・三の 7,085 鍵で、二次項の六種類を一種類ずつ零固定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
定数項・一次項は常に零。語長三以外と閉路型の値は自由未知数。
各判定は独立であり、複数種類の同時除去を判定するものではない。
"""

from collections import Counter
from itertools import combinations_with_replacement

print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-quadratic-kind-removal/construction.sage")

compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
types = tuple(t for t in all_types if t[0] == "arc" and len(t[1]) == 3)
names = arc_feature_names(3)
pairs = tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names)))
start = len(all_types)
assert (len(joint_keys), len(types), len(names), len(pairs), start) == (7085, 2044, 68, 2278, 10098)
assert Counter(map(membership_kind, names)) == {"d": 20, "e": 20, "c": 8, "wrap": 20}
kinds = tuple(combinations_with_replacement(("c", "d", "e"), 2))
pair_kinds = tuple(pair_membership_kind(names, pair) for pair in pairs)
assert Counter(pair_kinds) == {None: 1150, ("c", "c"): 28, ("c", "d"): 160,
                              ("c", "e"): 160, ("d", "d"): 190,
                              ("d", "e"): 400, ("e", "e"): 190}
full_matrix, full_rhs = pure_quadratic_system(entries, rhs, all_types, column_index, types, pairs)
assert full_matrix.dimensions() == (9129, 12376)
assert full_matrix[:len(rhs), :start] == matrix(GF(2), len(rhs), start, entries)
assert full_matrix[:len(rhs), start:].is_zero()
assert full_rhs == vector(GF(2), list(rhs) + [0] * len(types))
for offset, arc_type in enumerate(types):
    bits = arc_feature_bits(arc_type)
    row = full_matrix.row(len(rhs) + offset)
    assert row[:start].nonzero_positions() == [column_index[arc_type]]
    assert row[start:] == vector(GF(2), degree_two_features(bits)[len(names):])

expected = {kind: (8828, 8828, True) for kind in kinds}
expected[("e", "e")] = (8826, 8827, False)
results = {}
for removed_kind in kinds:
    kept_indices = tuple(index for index, kind in enumerate(pair_kinds) if kind != removed_kind)
    kept_pairs = tuple(pairs[index] for index in kept_indices)
    columns = list(range(start)) + [start + index for index in kept_indices]
    system = full_matrix.matrix_from_columns(columns)
    removed_count = len(pairs) - len(kept_pairs)
    assert system.ncols() == full_matrix.ncols() - Counter(pair_kinds)[removed_kind]
    assert all(pair_membership_kind(names, pair) != removed_kind for pair in kept_pairs)
    # 切断旗を含む全ての積を残し、対象種類の係数だけを零に固定する。
    assert sum(pair_membership_kind(names, pair) is None for pair in kept_pairs) == 1150
    print("SYSTEM: remove=%s rows=%d columns=%d removed=%d" %
          (removed_kind, system.nrows(), system.ncols(), removed_count), flush=True)
    rank = system.rank()
    augmented_rank = system.augment(full_rhs.column()).rank()
    solvable = rank == augmented_rank
    results[removed_kind] = (rank, augmented_rank, solvable)
    assert results[removed_kind] == expected[removed_kind]
    print("RESULT: remove=%s rank=%d augmented_rank=%d solvable=%s" %
          (removed_kind, rank, augmented_rank, solvable), flush=True)
    if solvable:
        solution = system.solve_right(full_rhs)
        assert system * solution == full_rhs
        active_pairs = tuple(pair for index, pair in enumerate(kept_pairs) if solution[start + index])
        values = {}
        for arc_type in types:
            bits = arc_feature_bits(arc_type)
            value = GF(2)(sum(bits[i] * bits[j] for i, j in active_pairs))
            assert value == solution[column_index[arc_type]]
            values[arc_type] = value
        for side, doubled, single, target in joint_keys:
            value = GF(2)(0)
            for arc_type in compressed_arc_types(side, doubled, single, compressor):
                if arc_type[0] == "arc" and len(arc_type[1]) == 3:
                    value += values[arc_type]
                else:
                    value += solution[column_index[arc_type]]
            assert value == target
        print("WITNESS: remove=%s all 7085 keys reconstructed; terms=%d" %
              (removed_kind, len(active_pairs)), flush=True)
    else:
        obstruction = next(row for row in system.left_kernel_matrix().rows() if row * full_rhs == 1)
        assert (obstruction * system).is_zero()
        assert obstruction * full_rhs == 1
        assert len(obstruction[:len(rhs)].nonzero_positions()) == 40
        assert len(obstruction[len(rhs):].nonzero_positions()) == 28
        print("OBSTRUCTION: remove=%s key_indices=%s arc_indices=%s" %
              (removed_kind, obstruction[:len(rhs)].nonzero_positions(),
               obstruction[len(rhs):].nonzero_positions()), flush=True)

print("SUMMARY: %s" % results, flush=True)
print("PASS: six independent membership-kind removal tests", flush=True)
