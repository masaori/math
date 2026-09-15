"""十一特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する十一の障害を除く特徴を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing eleven-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-eleventh-obstruction-feature-comparison/check.sage")

twelfth_obstruction = next(
    row for row in eleven_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (twelfth_obstruction * eleven_times_extended).is_zero()
assert twelfth_obstruction * restricted_rhs == 1
twelfth_indices = tuple(twelfth_obstruction.nonzero_positions())
assert twelfth_indices == (
    60, 61, 2212, 2269, 3372, 3379, 3411, 3413, 4015, 4129, 4132,
    4138, 4157, 4175, 4226, 4707, 5372, 5429, 5884, 6504, 6530,
    6544, 6549, 6639, 6685, 6704, 6720, 6729, 6759, 6772, 6840,
    6894, 6900, 6903, 7045)
print("TWELFTH OBSTRUCTION: support=%d indices=%s" %
      (len(twelfth_indices), twelfth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in twelfth_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in twelfth_indices))
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
assert len(noncancelling) == 1067
assert noncancelling_linear == [
    "step0_d_down", "step1_wrap_collast", "step1_d_up", "step1_d_right",
    "step2_e_up", "step2_e_down", "step2_e_left", "step2_e_right",
    "step2_wrap_rowlast", "step2_wrap_col0", "step2_d_up", "step2_d_down",
    "step3_wrap_col0", "step3_d_up", "step3_d_down", "step3_d_right"]

# 先行する十一特徴は今回の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を次の候補にする。
assert twelfth_obstruction * distinguishing_column == 0
assert twelfth_obstruction * second_column == 0
assert twelfth_obstruction * third_column == 0
assert twelfth_obstruction * fourth_column == 0
assert twelfth_obstruction * fifth_column == 0
assert twelfth_obstruction * sixth_column == 0
assert twelfth_obstruction * seventh_column == 0
assert twelfth_obstruction * eighth_column == 0
assert twelfth_obstruction * ninth_column == 0
assert twelfth_obstruction * tenth_column == 0
assert twelfth_obstruction * eleventh_column == 0
if noncancelling_linear:
    twelfth_feature_name = noncancelling_linear[0]
    twelfth_feature = named_product(twelfth_feature_name, twelfth_feature_name)
else:
    twelfth_feature_name, first, second = noncancelling[0]
    twelfth_feature = named_product(names[first], names[second])
twelfth_column = feature_column(twelfth_feature)
assert twelfth_obstruction * twelfth_column == 1
twelve_times_extended = eleven_times_extended.augment(twelfth_column.column())
twelve_times_extended_rank = twelve_times_extended.rank()
twelve_times_extended_augmented_rank = twelve_times_extended.augment(
    restricted_rhs.column()).rank()
twelve_times_extended_solvable = (
    twelve_times_extended_rank == twelve_times_extended_augmented_rank)
print("TWELFTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    twelfth_feature_name, twelve_times_extended_rank,
    twelve_times_extended_augmented_rank, twelve_times_extended_solvable), flush=True)
assert (twelfth_feature_name, twelve_times_extended_rank,
        twelve_times_extended_augmented_rank, twelve_times_extended_solvable) == (
            "step0_d_down", 6314, 6315, False)

print("PASS: twelfth obstruction features compared")
