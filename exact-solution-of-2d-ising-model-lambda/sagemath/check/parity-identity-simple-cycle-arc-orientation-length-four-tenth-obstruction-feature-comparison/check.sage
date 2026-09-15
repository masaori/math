"""九特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する九つの障害を除く特徴を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing nine-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-ninth-obstruction-feature-comparison/check.sage")

tenth_obstruction = next(
    row for row in nine_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (tenth_obstruction * nine_times_extended).is_zero()
assert tenth_obstruction * restricted_rhs == 1
tenth_indices = tuple(tenth_obstruction.nonzero_positions())
assert tenth_indices == (649, 924, 6759, 7045)
print("TENTH OBSTRUCTION: support=%d indices=%s" %
      (len(tenth_indices), tenth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in tenth_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in tenth_indices))
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
assert len(noncancelling) == 338
assert noncancelling_linear == [
    "step1_wrap_col0", "step1_wrap_collast", "step1_d_up", "step1_d_right"]

# 先行する九特徴は今回の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を次の候補にする。
assert tenth_obstruction * distinguishing_column == 0
assert tenth_obstruction * second_column == 0
assert tenth_obstruction * third_column == 0
assert tenth_obstruction * fourth_column == 0
assert tenth_obstruction * fifth_column == 0
assert tenth_obstruction * sixth_column == 0
assert tenth_obstruction * seventh_column == 0
assert tenth_obstruction * eighth_column == 0
assert tenth_obstruction * ninth_column == 0
if noncancelling_linear:
    tenth_feature_name = noncancelling_linear[0]
    tenth_feature = named_product(tenth_feature_name, tenth_feature_name)
else:
    tenth_feature_name, first, second = noncancelling[0]
    tenth_feature = named_product(names[first], names[second])
tenth_column = feature_column(tenth_feature)
assert tenth_obstruction * tenth_column == 1
ten_times_extended = nine_times_extended.augment(tenth_column.column())
ten_times_extended_rank = ten_times_extended.rank()
ten_times_extended_augmented_rank = ten_times_extended.augment(
    restricted_rhs.column()).rank()
ten_times_extended_solvable = (
    ten_times_extended_rank == ten_times_extended_augmented_rank)
print("TENTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    tenth_feature_name, ten_times_extended_rank,
    ten_times_extended_augmented_rank, ten_times_extended_solvable), flush=True)
assert (tenth_feature_name, ten_times_extended_rank,
        ten_times_extended_augmented_rank, ten_times_extended_solvable) == (
            "step1_wrap_col0", 6312, 6313, False)

print("PASS: tenth obstruction features compared")
