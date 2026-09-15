"""十四特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する十四の障害を除く特徴を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing fourteen-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-fourteenth-obstruction-feature-comparison/check.sage")

fifteenth_obstruction = next(
    row for row in fourteen_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (fifteenth_obstruction * fourteen_times_extended).is_zero()
assert fifteenth_obstruction * restricted_rhs == 1
fifteenth_indices = tuple(fifteenth_obstruction.nonzero_positions())
assert fifteenth_indices == (
    675, 6437, 6467, 6539, 6574, 6704, 6720, 6729, 6881, 6894,
    6904, 6924, 6940, 6950, 7058)
print("FIFTEENTH OBSTRUCTION: support=%d indices=%s" %
      (len(fifteenth_indices), fifteenth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in fifteenth_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in fifteenth_indices))
assert candidate_sum != target_sum
print("AGGREGATE: length_four_types=%d candidate_sum=%s target_sum=%s" %
      (len(aggregate_length_four), candidate_sum, target_sum), flush=True)
assert (len(aggregate_length_four), candidate_sum, target_sum) == (18, 1, 0)

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
assert len(noncancelling) == 845
assert noncancelling_linear == [
    "step1_d_up", "step1_d_left", "step2_e_up", "step2_e_right",
    "step2_wrap_row0", "step2_wrap_rowlast", "step2_wrap_collast",
    "step3_e_up", "step3_e_right", "step3_wrap_row0",
    "step3_wrap_rowlast", "step3_wrap_collast", "step3_d_down",
    "step3_d_right"]

# 先行する十四特徴は今回の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を次の候補にする。
assert fifteenth_obstruction * distinguishing_column == 0
assert fifteenth_obstruction * second_column == 0
assert fifteenth_obstruction * third_column == 0
assert fifteenth_obstruction * fourth_column == 0
assert fifteenth_obstruction * fifth_column == 0
assert fifteenth_obstruction * sixth_column == 0
assert fifteenth_obstruction * seventh_column == 0
assert fifteenth_obstruction * eighth_column == 0
assert fifteenth_obstruction * ninth_column == 0
assert fifteenth_obstruction * tenth_column == 0
assert fifteenth_obstruction * eleventh_column == 0
assert fifteenth_obstruction * twelfth_column == 0
assert fifteenth_obstruction * thirteenth_column == 0
assert fifteenth_obstruction * fourteenth_column == 0
if noncancelling_linear:
    fifteenth_feature_name = noncancelling_linear[0]
    fifteenth_feature = named_product(fifteenth_feature_name, fifteenth_feature_name)
else:
    fifteenth_feature_name, first, second = noncancelling[0]
    fifteenth_feature = named_product(names[first], names[second])
fifteenth_column = feature_column(fifteenth_feature)
assert fifteenth_obstruction * fifteenth_column == 1
fifteen_times_extended = fourteen_times_extended.augment(fifteenth_column.column())
fifteen_times_extended_rank = fifteen_times_extended.rank()
fifteen_times_extended_augmented_rank = fifteen_times_extended.augment(
    restricted_rhs.column()).rank()
fifteen_times_extended_solvable = (
    fifteen_times_extended_rank == fifteen_times_extended_augmented_rank)
print("FIFTEENTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    fifteenth_feature_name, fifteen_times_extended_rank,
    fifteen_times_extended_augmented_rank, fifteen_times_extended_solvable), flush=True)
assert (fifteenth_feature_name, fifteen_times_extended_rank,
        fifteen_times_extended_augmented_rank, fifteen_times_extended_solvable) == (
            "step1_d_up", 6317, 6318, False)

print("PASS: fifteenth obstruction features compared")
