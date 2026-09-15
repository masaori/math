"""十特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する十の障害を除く特徴を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing ten-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-tenth-obstruction-feature-comparison/check.sage")

eleventh_obstruction = next(
    row for row in ten_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (eleventh_obstruction * ten_times_extended).is_zero()
assert eleventh_obstruction * restricted_rhs == 1
eleventh_indices = tuple(eleventh_obstruction.nonzero_positions())
assert eleventh_indices == (
    60, 61, 2212, 2269, 3372, 3379, 3411, 3413, 4015, 4129, 4132,
    4138, 4157, 4175, 4226, 4707, 5372, 5429, 5884, 6504, 6530,
    6544, 6549, 6639, 6685, 6704, 6720, 6729, 6759, 6772, 6840,
    6900, 6903, 6904, 7045)
print("ELEVENTH OBSTRUCTION: support=%d indices=%s" %
      (len(eleventh_indices), eleventh_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in eleventh_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in eleventh_indices))
assert candidate_sum != target_sum
print("AGGREGATE: length_four_types=%d candidate_sum=%s target_sum=%s" %
      (len(aggregate_length_four), candidate_sum, target_sum), flush=True)

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
assert len(noncancelling) == 1049
assert noncancelling_linear == [
    "step0_d_right", "step1_wrap_collast", "step1_d_up", "step1_d_right",
    "step2_e_up", "step2_e_down", "step2_e_left", "step2_e_right",
    "step2_wrap_rowlast", "step2_wrap_col0", "step2_d_down", "step2_d_left",
    "step3_wrap_col0", "step3_d_up", "step3_d_down", "step3_d_left"]

# 先行する十特徴は今回の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を次の候補にする。
assert eleventh_obstruction * distinguishing_column == 0
assert eleventh_obstruction * second_column == 0
assert eleventh_obstruction * third_column == 0
assert eleventh_obstruction * fourth_column == 0
assert eleventh_obstruction * fifth_column == 0
assert eleventh_obstruction * sixth_column == 0
assert eleventh_obstruction * seventh_column == 0
assert eleventh_obstruction * eighth_column == 0
assert eleventh_obstruction * ninth_column == 0
assert eleventh_obstruction * tenth_column == 0
if noncancelling_linear:
    eleventh_feature_name = noncancelling_linear[0]
    eleventh_feature = named_product(eleventh_feature_name, eleventh_feature_name)
else:
    eleventh_feature_name, first, second = noncancelling[0]
    eleventh_feature = named_product(names[first], names[second])
eleventh_column = feature_column(eleventh_feature)
assert eleventh_obstruction * eleventh_column == 1
eleven_times_extended = ten_times_extended.augment(eleventh_column.column())
eleven_times_extended_rank = eleven_times_extended.rank()
eleven_times_extended_augmented_rank = eleven_times_extended.augment(
    restricted_rhs.column()).rank()
eleven_times_extended_solvable = (
    eleven_times_extended_rank == eleven_times_extended_augmented_rank)
print("ELEVENTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    eleventh_feature_name, eleven_times_extended_rank,
    eleven_times_extended_augmented_rank, eleven_times_extended_solvable), flush=True)
assert (eleventh_feature_name, eleven_times_extended_rank,
        eleven_times_extended_augmented_rank, eleven_times_extended_solvable) == (
            "step0_d_right", 6313, 6314, False)

print("PASS: eleventh obstruction features compared")
