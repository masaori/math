"""十三特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する十三の障害を除く特徴を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing thirteen-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-thirteenth-obstruction-feature-comparison/check.sage")

fourteenth_obstruction = next(
    row for row in thirteen_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (fourteenth_obstruction * thirteen_times_extended).is_zero()
assert fourteenth_obstruction * restricted_rhs == 1
fourteenth_indices = tuple(fourteenth_obstruction.nonzero_positions())
assert fourteenth_indices == (
    60, 61, 2212, 2269, 3372, 3379, 3411, 3413, 4015, 4129, 4132,
    4138, 4157, 4175, 4226, 4707, 5372, 5429, 5884, 6504, 6530,
    6544, 6549, 6574, 6639, 6685, 6704, 6720, 6729, 6894, 6900,
    6903, 6904, 6924, 6940, 6950)
print("FOURTEENTH OBSTRUCTION: support=%d indices=%s" %
      (len(fourteenth_indices), fourteenth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in fourteenth_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in fourteenth_indices))
assert candidate_sum != target_sum
print("AGGREGATE: length_four_types=%d candidate_sum=%s target_sum=%s" %
      (len(aggregate_length_four), candidate_sum, target_sum), flush=True)
assert (len(aggregate_length_four), candidate_sum, target_sum) == (28, 0, 1)

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
assert len(noncancelling) == 1051
assert noncancelling_linear == [
    "step1_e_up", "step1_e_right", "step1_wrap_rowlast",
    "step1_wrap_collast", "step1_d_up", "step1_d_right", "step2_e_down",
    "step2_e_right", "step2_wrap_rowlast", "step2_wrap_col0", "step2_d_up",
    "step2_d_down", "step3_e_left", "step3_e_right", "step3_d_down",
    "step3_d_right"]

# 先行する十三特徴は今回の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を次の候補にする。
assert fourteenth_obstruction * distinguishing_column == 0
assert fourteenth_obstruction * second_column == 0
assert fourteenth_obstruction * third_column == 0
assert fourteenth_obstruction * fourth_column == 0
assert fourteenth_obstruction * fifth_column == 0
assert fourteenth_obstruction * sixth_column == 0
assert fourteenth_obstruction * seventh_column == 0
assert fourteenth_obstruction * eighth_column == 0
assert fourteenth_obstruction * ninth_column == 0
assert fourteenth_obstruction * tenth_column == 0
assert fourteenth_obstruction * eleventh_column == 0
assert fourteenth_obstruction * twelfth_column == 0
assert fourteenth_obstruction * thirteenth_column == 0
if noncancelling_linear:
    fourteenth_feature_name = noncancelling_linear[0]
    fourteenth_feature = named_product(fourteenth_feature_name, fourteenth_feature_name)
else:
    fourteenth_feature_name, first, second = noncancelling[0]
    fourteenth_feature = named_product(names[first], names[second])
fourteenth_column = feature_column(fourteenth_feature)
assert fourteenth_obstruction * fourteenth_column == 1
fourteen_times_extended = thirteen_times_extended.augment(fourteenth_column.column())
fourteen_times_extended_rank = fourteen_times_extended.rank()
fourteen_times_extended_augmented_rank = fourteen_times_extended.augment(
    restricted_rhs.column()).rank()
fourteen_times_extended_solvable = (
    fourteen_times_extended_rank == fourteen_times_extended_augmented_rank)
print("FOURTEENTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    fourteenth_feature_name, fourteen_times_extended_rank,
    fourteen_times_extended_augmented_rank, fourteen_times_extended_solvable), flush=True)
assert (fourteenth_feature_name, fourteen_times_extended_rank,
        fourteen_times_extended_augmented_rank, fourteen_times_extended_solvable) == (
            "step1_e_up", 6316, 6317, False)

print("PASS: fourteenth obstruction features compared")
