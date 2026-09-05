"""既存 7,085 鍵で語長三の方向対係数の位置非依存性を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
他の語長・閉路型の値は自由。一般の辺長についての証明ではない。
"""

print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-shared-direction-coefficients/construction.sage")

compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
types = tuple(t for t in all_types if t[0] == "arc" and len(t[1]) == 3)
names = arc_feature_names(3)
groups = shared_direction_groups(names)
start = len(all_types)
assert (len(joint_keys), len(types), len(names), len(groups), start) == (7085, 2044, 68, 1156, 10098)
# 名前による構成を、定義のビット位置から独立に選んだ列と照合する。
wrap_indices = {12 * step + i for step in range(3) for i in range(4, 8)}
wrap_indices.update(36 + 16 * end + i for end in range(2) for i in range(12, 16))
wrap_pairs = tuple((i, j) for i in range(68) for j in range(i + 1, 68)
                   if i in wrap_indices or j in wrap_indices)
direction_pairs = tuple((i, j) for i in range(4) for j in range(i + 1, 4))
assert groups[:1150] == tuple((pair,) for pair in wrap_pairs)
assert groups[1150:] == tuple(tuple((12 * step + i, 12 * step + j) for step in range(3))
                             for i, j in direction_pairs)
assert len(set(pair for group in groups for pair in group)) == 1168
system, system_rhs = shared_direction_system(entries, rhs, all_types, column_index, types, groups)
assert system.dimensions() == (9129, 11254)
assert system[:len(rhs), :start] == matrix(GF(2), len(rhs), start, entries)
assert system[:len(rhs), start:].is_zero()
assert system_rhs == vector(GF(2), list(rhs) + [0] * len(types))
for offset, arc_type in enumerate(types):
    bits = arc_feature_bits(arc_type)
    row = system.row(len(rhs) + offset)
    assert row[:start].nonzero_positions() == [column_index[arc_type]]
    expected = [bits[i] * bits[j] for i, j in wrap_pairs]
    expected += [sum(step[0][i] * step[0][j] for step in arc_type[1]) for i, j in direction_pairs]
    assert row[start:] == vector(GF(2), expected)

print("SYSTEM: rows=%d columns=%d coefficient_groups=%d" %
      (system.nrows(), system.ncols(), len(groups)), flush=True)
rank = system.rank()
augmented_rank = system.augment(system_rhs.column()).rank()
solvable = rank == augmented_rank
assert (rank, augmented_rank, solvable) == (8817, 8817, True)
print("RESULT: rank=%d augmented_rank=%d solvable=%s" % (rank, augmented_rank, solvable), flush=True)
if solvable:
    solution = system.solve_right(system_rhs)
    assert system * solution == system_rhs
    active_groups = tuple(group for index, group in enumerate(groups) if solution[start + index])
    assert sum(len(group) == 1 for group in active_groups) == 101
    assert tuple(group for group in active_groups if len(group) == 3) == (
        tuple((12 * step, 12 * step + 2) for step in range(3)),)
    values = {}
    for arc_type in types:
        bits = arc_feature_bits(arc_type)
        value = GF(2)(sum(bits[i] * bits[j] for group in active_groups for i, j in group))
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
    print("WITNESS: all 7085 keys reconstructed; wrap_groups=%d shared_groups=%d" %
          (sum(len(group) == 1 for group in active_groups),
           sum(len(group) == 3 for group in active_groups)), flush=True)
    print("COEFFICIENTS: %s" % [tuple((names[i], names[j]) for i, j in group)
                                for group in active_groups], flush=True)
else:
    obstruction = next(row for row in system.left_kernel_matrix().rows() if row * system_rhs == 1)
    assert (obstruction * system).is_zero()
    assert obstruction * system_rhs == 1
    print("OBSTRUCTION: key_indices=%s arc_indices=%s" %
          (obstruction[:len(rhs)].nonzero_positions(), obstruction[len(rhs):].nonzero_positions()), flush=True)
print("PASS: shared-direction coefficient decision and witness", flush=True)
