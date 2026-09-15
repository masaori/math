"""位置ビット閉式の一般語長候補を語長四へ課す有限合同判定。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

一辺二・三から得た 7,085 鍵の有限合同系で、語長四の弧型の値を
各語位置の同スロット E/D 積と、二つの内部語位置に反復した切断旗の
八項規則の和へ固定する。他の語長と閉路型の値は自由未知数に保つ。
有限集合と F_2 の厳密演算だけを使い、浮動小数点は使わない。
"""

print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")

print("LOAD: finite key data ready", flush=True)
compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
assert len(joint_keys) == len(rhs) == 7085


def position_coefficient(axis, step_side, endpoint, endpoint_side):
    """a=axis, s=step_side, e=endpoint, t=endpoint_side の八項規則。"""
    a, s, e, t = map(GF(2), (axis, step_side, endpoint, endpoint_side))
    return 1 + s + a * s + e + a * s * e + a * t + s * e * t


def candidate_value(arc_type):
    assert arc_type[0] == "arc" and len(arc_type[1]) == 4
    bits = arc_feature_bits(arc_type)
    names = arc_feature_names(4)
    by_name = {name: bits[index] for index, name in enumerate(names)}
    value = GF(2)(sum(
        step[0][slot] * step[2][0][slot]
        for step in arc_type[1]
        for slot in range(4)))
    for step in (1, 2):
        for axis in (0, 1):
            for step_side in (0, 1):
                for endpoint in (0, 1):
                    for endpoint_side in (0, 1):
                        if position_coefficient(
                                axis, step_side, endpoint, endpoint_side) == 0:
                            continue
                        step_flag = (("col" if axis else "row") +
                                     ("last" if step_side else "0"))
                        endpoint_flag = (("row" if axis else "col") +
                                         ("last" if endpoint_side else "0"))
                        value += (by_name["step%d_wrap_%s" % (step, step_flag)] *
                                  by_name["end%d_wrap_%s" %
                                          (endpoint, endpoint_flag)])
    return value


length_four_types = tuple(
    arc_type for arc_type in all_types
    if arc_type[0] == "arc" and len(arc_type[1]) == 4)
assigned_values = {
    column_index[arc_type]: candidate_value(arc_type)
    for arc_type in length_four_types
}
assert len(assigned_values) == len(length_four_types)
assert (len(all_types), len(length_four_types)) == (10098, 2130)

free_columns = tuple(
    column for column in range(len(all_types))
    if column not in assigned_values)
free_position = {column: position for position, column in enumerate(free_columns)}
restricted_entries = {}
adjusted_rhs = list(rhs)
for (row_index, column), value in entries.items():
    if column in assigned_values:
        adjusted_rhs[row_index] += value * assigned_values[column]
    else:
        restricted_entries[(row_index, free_position[column])] = value

restricted = matrix(
    GF(2), len(rhs), len(free_columns), restricted_entries)
restricted_rhs = vector(GF(2), adjusted_rhs)
rank = restricted.rank()
augmented_rank = restricted.augment(restricted_rhs.column()).rank()
solvable = rank == augmented_rank
print("SYSTEM: keys=%d all_types=%d length_four_types=%d free_types=%d" %
      (len(rhs), len(all_types), len(length_four_types), len(free_columns)),
      flush=True)
print("RESULT: rank=%d augmented_rank=%d solvable=%s" %
      (rank, augmented_rank, solvable), flush=True)
assert (rank, augmented_rank, solvable) == (6302, 6303, False)

if solvable:
    solution = restricted.solve_right(restricted_rhs)
    full_values = dict(assigned_values)
    full_values.update({column: solution[position]
                        for position, column in enumerate(free_columns)})
    original = matrix(GF(2), len(rhs), len(all_types), entries)
    full_vector = vector(
        GF(2), [full_values[column] for column in range(len(all_types))])
    assert original * full_vector == rhs
    print("WITNESS: all 7085 keys reconstructed", flush=True)
else:
    obstruction = next(
        row for row in restricted.left_kernel_matrix().rows()
        if row * restricted_rhs == 1)
    assert (obstruction * restricted).is_zero()
    assert obstruction * restricted_rhs == 1
    print("OBSTRUCTION: left-kernel certificate verified; support=%d" %
          obstruction.hamming_weight(), flush=True)
    print("OBSTRUCTION INDICES: %s" %
          list(obstruction.nonzero_positions()), flush=True)

print("PASS: length-four candidate decision", flush=True)
