"""十六特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する十六の障害を除く特徴を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing sixteen-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-sixteenth-obstruction-feature-comparison/check.sage")

seventeenth_obstruction = next(
    row for row in sixteen_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (seventeenth_obstruction * sixteen_times_extended).is_zero()
assert seventeenth_obstruction * restricted_rhs == 1
seventeenth_indices = tuple(seventeenth_obstruction.nonzero_positions())
assert seventeenth_indices == (
    632, 1162, 1220, 1361, 1401, 1413, 1438, 1448, 4322, 4372, 6417,
    6574, 6589, 6616, 6685, 6704, 6720, 6729, 6900, 6904)
print("SEVENTEENTH OBSTRUCTION: support=%d indices=%s" %
      (len(seventeenth_indices), seventeenth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in seventeenth_indices:
    for (entry_row, column), value in entries.items():
        if entry_row == row_index:
            aggregate[column] += value
aggregate_columns = tuple(aggregate.nonzero_positions())
aggregate_free = tuple(column for column in aggregate_columns if column in free_position)
aggregate_length_four = tuple(
    all_types[column] for column in aggregate_columns if column in assigned_values)
assert aggregate_free == ()
candidate_sum = GF(2)(sum(
    candidate_value(arc_type) for arc_type in aggregate_length_four))
target_sum = GF(2)(sum(joint_keys[index][3] for index in seventeenth_indices))
assert candidate_sum != target_sum
print("AGGREGATE: length_four_types=%d candidate_sum=%s target_sum=%s" %
      (len(aggregate_length_four), candidate_sum, target_sum), flush=True)
assert (len(aggregate_length_four), candidate_sum, target_sum) == (20, 1, 0)

names = arc_feature_names(4)
noncancelling = []
noncancelling_linear = []
for first in range(len(names)):
    for second in range(first, len(names)):
        value = GF(2)(sum(
            arc_feature_bits(arc_type)[first] * arc_feature_bits(arc_type)[second]
            for arc_type in aggregate_length_four))
        if value:
            label = names[first] if first == second else names[first] + "*" + names[second]
            noncancelling.append((label, first, second))
            if first == second:
                noncancelling_linear.append(label)
print("NONCANCELLING FEATURES: count=%d" % len(noncancelling), flush=True)
print("NONCANCELLING LINEAR FEATURES: %s" %
      (tuple(noncancelling_linear),), flush=True)
assert len(noncancelling) == 1089
assert noncancelling_linear == [
    "step1_e_left", "step1_e_right", "step1_wrap_rowlast", "step2_e_left",
    "step2_e_right", "step2_wrap_row0", "step2_wrap_rowlast", "step2_d_up",
    "step2_d_down", "step3_wrap_rowlast", "step3_wrap_collast",
    "step3_d_left", "step3_d_right", "end0_e_up", "end0_e_down",
    "end0_d_left", "end0_e_left", "end0_c_left", "end0_d_right",
    "end0_e_right", "end0_c_right", "end0_wrap_col0", "end0_wrap_collast",
    "end1_e_up", "end1_e_down", "end1_d_left", "end1_e_left",
    "end1_c_left", "end1_d_right", "end1_e_right", "end1_c_right",
    "end1_wrap_col0", "end1_wrap_collast"]

# 先行する十六特徴は今回の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を次の候補にする。
for column in (
        distinguishing_column, second_column, third_column, fourth_column,
        fifth_column, sixth_column, seventh_column, eighth_column, ninth_column,
        tenth_column, eleventh_column, twelfth_column, thirteenth_column,
        fourteenth_column, fifteenth_column, sixteenth_column):
    assert seventeenth_obstruction * column == 0
if noncancelling_linear:
    seventeenth_feature_name = noncancelling_linear[0]
    seventeenth_feature = named_product(
        seventeenth_feature_name, seventeenth_feature_name)
else:
    seventeenth_feature_name, first, second = noncancelling[0]
    seventeenth_feature = named_product(names[first], names[second])
seventeenth_column = feature_column(seventeenth_feature)
assert seventeenth_obstruction * seventeenth_column == 1
seventeen_times_extended = sixteen_times_extended.augment(
    seventeenth_column.column())
seventeen_times_extended_rank = seventeen_times_extended.rank()
seventeen_times_extended_augmented_rank = seventeen_times_extended.augment(
    restricted_rhs.column()).rank()
seventeen_times_extended_solvable = (
    seventeen_times_extended_rank == seventeen_times_extended_augmented_rank)
print("SEVENTEENTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    seventeenth_feature_name, seventeen_times_extended_rank,
    seventeen_times_extended_augmented_rank,
    seventeen_times_extended_solvable), flush=True)
assert (seventeenth_feature_name, seventeen_times_extended_rank,
        seventeen_times_extended_augmented_rank,
        seventeen_times_extended_solvable) == (
            "step1_e_left", 6319, 6320, False)

print("PASS: seventeenth obstruction features compared")
