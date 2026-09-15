"""三特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する三つの障害を除く特徴を加えた有限合同系から、
第四の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing thrice-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-third-obstruction-feature-comparison/check.sage")

fourth_obstruction = next(
    row for row in thrice_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (fourth_obstruction * thrice_extended).is_zero()
assert fourth_obstruction * restricted_rhs == 1
fourth_indices = tuple(fourth_obstruction.nonzero_positions())
assert fourth_indices == (
    60, 61, 2212, 2269, 3372, 3379, 3411, 3413, 4015, 4129, 4132,
    4138, 4157, 4175, 4226, 4707, 5372, 5429, 5884, 6504, 6530,
    6544, 6549, 6639, 6685, 6924, 6940, 6950)
print("FOURTH OBSTRUCTION: support=%d indices=%s" %
      (len(fourth_indices), fourth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in fourth_indices:
    for (entry_row, column), value in entries.items():
        if entry_row == row_index:
            aggregate[column] += value
aggregate_columns = tuple(aggregate.nonzero_positions())
aggregate_free = tuple(column for column in aggregate_columns if column in free_position)
aggregate_length_four = tuple(
    all_types[column] for column in aggregate_columns if column in assigned_values)
assert aggregate_free == ()
assert GF(2)(sum(candidate_value(arc_type) for arc_type in aggregate_length_four)) == 0
assert GF(2)(sum(joint_keys[index][3] for index in fourth_indices)) == 1
print("AGGREGATE: length_four_types=%d candidate_sum=0 target_sum=1" %
      len(aggregate_length_four), flush=True)

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
assert len(noncancelling) == 828
assert noncancelling_linear == [
    "step0_wrap_collast", "step0_d_down", "step0_d_left", "step1_e_up",
    "step1_e_right", "step1_wrap_rowlast", "step1_wrap_col0",
    "step2_e_down", "step2_e_right", "step2_wrap_rowlast", "step2_d_up",
    "step2_d_right", "step3_e_left", "step3_e_right", "step3_wrap_col0"]

# 先行する三特徴は第四の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を第四候補にする。
assert fourth_obstruction * distinguishing_column == 0
assert fourth_obstruction * second_column == 0
assert fourth_obstruction * third_column == 0
if noncancelling_linear:
    fourth_feature_name = noncancelling_linear[0]
    fourth_feature = named_product(fourth_feature_name, fourth_feature_name)
else:
    fourth_feature_name, first, second = noncancelling[0]
    fourth_feature = named_product(names[first], names[second])
fourth_column = feature_column(fourth_feature)
assert fourth_obstruction * fourth_column == 1
four_times_extended = thrice_extended.augment(fourth_column.column())
four_times_extended_rank = four_times_extended.rank()
four_times_extended_augmented_rank = four_times_extended.augment(
    restricted_rhs.column()).rank()
four_times_extended_solvable = (
    four_times_extended_rank == four_times_extended_augmented_rank)
print("FOURTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    fourth_feature_name, four_times_extended_rank,
    four_times_extended_augmented_rank, four_times_extended_solvable), flush=True)
assert (fourth_feature_name, four_times_extended_rank,
        four_times_extended_augmented_rank, four_times_extended_solvable) == (
            "step0_wrap_collast", 6306, 6307, False)

print("PASS: fourth obstruction features compared")
