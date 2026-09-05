"""一辺二・三の既存鍵で、同じ署名位置の単一辺所属の積の十分性を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
他の語長と閉路型の値は自由未知数。一般の辺長の証明ではない。
"""

from collections import Counter

print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-same-position-sufficiency/construction.sage")

compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
types = tuple(t for t in all_types if t[0] == "arc" and len(t[1]) == 3)
names = arc_feature_names(3)
pairs = same_position_quadratic_pairs(names)
start = len(all_types)
assert (len(joint_keys), len(types), len(names), len(pairs), start) == (7085, 2044, 68, 1180, 10098)
assert Counter(pair_membership_kind(names, pair) for pair in pairs) == {None: 1150, ("e", "e"): 30}
# 特徴名の分類だけで済ませず、ビット配置から選んだ列とも照合する。
wrap_indices = {12 * step + i for step in range(3) for i in range(4, 8)}
wrap_indices.update(36 + 16 * end + i for end in range(2) for i in range(12, 16))
single_indices = {12 * step + i for step in range(3) for i in range(4)}
single_indices.update(36 + 16 * end + 3 * slot + 1 for end in range(2) for slot in range(4))
assert len(wrap_indices) == len(single_indices) == 20
position_groups = [set(range(12 * step, 12 * step + 4)) for step in range(3)]
position_groups += [{36 + 16 * end + 3 * slot + 1 for slot in range(4)} for end in range(2)]
assert set.union(*position_groups) == single_indices
assert pairs == tuple((i, j) for i in range(68) for j in range(i + 1, 68)
                      if i in wrap_indices or j in wrap_indices
                      or any(i in group and j in group for group in position_groups))
system, system_rhs = pure_quadratic_system(entries, rhs, all_types, column_index, types, pairs)
assert system.dimensions() == (9129, 11278)
assert system[:len(rhs), :start] == matrix(GF(2), len(rhs), start, entries)
assert system[:len(rhs), start:].is_zero()
assert system_rhs == vector(GF(2), list(rhs) + [0] * len(types))
for offset, arc_type in enumerate(types):
    bits = arc_feature_bits(arc_type)
    row = system.row(len(rhs) + offset)
    assert row[:start].nonzero_positions() == [column_index[arc_type]]
    assert row[start:] == vector(GF(2), [bits[i] * bits[j] for i, j in pairs])

print("SYSTEM: rows=%d columns=%d pairs=%d" % (system.nrows(), system.ncols(), len(pairs)), flush=True)
rank = system.rank()
augmented_rank = system.augment(system_rhs.column()).rank()
solvable = rank == augmented_rank
assert (rank, augmented_rank, solvable) == (8819, 8819, True)
print("RESULT: rank=%d augmented_rank=%d solvable=%s" % (rank, augmented_rank, solvable), flush=True)
if solvable:
    solution = system.solve_right(system_rhs)
    assert system * solution == system_rhs
    active_pairs = tuple(pair for index, pair in enumerate(pairs) if solution[start + index])
    active_kinds = Counter(pair_membership_kind(names, pair) for pair in active_pairs)
    assert active_kinds == {("e", "e"): 5, None: 104}
    assert all(not names[i].startswith("end")
               for i, j in active_pairs if pair_membership_kind(names, (i, j)) == ("e", "e"))
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
    print("WITNESS: all 7085 keys reconstructed; terms=%d kinds=%s" %
          (len(active_pairs), dict(active_kinds)), flush=True)
    print("COEFFICIENTS: %s" % [(names[i], names[j]) for i, j in active_pairs], flush=True)
else:
    obstruction = next(row for row in system.left_kernel_matrix().rows() if row * system_rhs == 1)
    assert (obstruction * system).is_zero()
    assert obstruction * system_rhs == 1
    print("OBSTRUCTION: key_indices=%s arc_indices=%s" %
          (obstruction[:len(rhs)].nonzero_positions(), obstruction[len(rhs):].nonzero_positions()), flush=True)
print("PASS: same-position sufficiency decision and witness", flush=True)
