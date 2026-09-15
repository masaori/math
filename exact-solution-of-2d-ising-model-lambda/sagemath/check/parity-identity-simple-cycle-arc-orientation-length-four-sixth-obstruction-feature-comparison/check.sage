"""五特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する五つの障害を除く特徴を加えた有限合同系から、
第六の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing five-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-fifth-obstruction-feature-comparison/check.sage")

sixth_obstruction = next(
    row for row in five_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (sixth_obstruction * five_times_extended).is_zero()
assert sixth_obstruction * restricted_rhs == 1
sixth_indices = tuple(sixth_obstruction.nonzero_positions())
assert sixth_indices == (
    60, 61, 2212, 2269, 3372, 3379, 3411, 3413, 4015, 4129, 4132,
    4138, 4157, 4175, 4226, 4707, 5372, 5429, 5884, 6504, 6530,
    6544, 6549, 6639, 6685, 6772, 6840, 6881, 7058)
print("SIXTH OBSTRUCTION: support=%d indices=%s" %
      (len(sixth_indices), sixth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in sixth_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in sixth_indices))
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
assert len(noncancelling) == 817
assert noncancelling_linear == [
    "step0_e_left", "step0_e_right", "step0_d_left", "step1_wrap_collast",
    "step2_e_up", "step2_e_down", "step2_wrap_rowlast",
    "step2_wrap_collast", "step2_d_up", "step2_d_right",
    "step3_wrap_collast", "step3_d_up"]

# 先行する五特徴は第六の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を第六候補にする。
assert sixth_obstruction * distinguishing_column == 0
assert sixth_obstruction * second_column == 0
assert sixth_obstruction * third_column == 0
assert sixth_obstruction * fourth_column == 0
assert sixth_obstruction * fifth_column == 0
if noncancelling_linear:
    sixth_feature_name = noncancelling_linear[0]
    sixth_feature = named_product(sixth_feature_name, sixth_feature_name)
else:
    sixth_feature_name, first, second = noncancelling[0]
    sixth_feature = named_product(names[first], names[second])
sixth_column = feature_column(sixth_feature)
assert sixth_obstruction * sixth_column == 1
six_times_extended = five_times_extended.augment(sixth_column.column())
six_times_extended_rank = six_times_extended.rank()
six_times_extended_augmented_rank = six_times_extended.augment(
    restricted_rhs.column()).rank()
six_times_extended_solvable = (
    six_times_extended_rank == six_times_extended_augmented_rank)
print("SIXTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    sixth_feature_name, six_times_extended_rank,
    six_times_extended_augmented_rank, six_times_extended_solvable), flush=True)
assert (sixth_feature_name, six_times_extended_rank,
        six_times_extended_augmented_rank, six_times_extended_solvable) == (
            "step0_e_left", 6308, 6309, False)

print("PASS: sixth obstruction features compared")
