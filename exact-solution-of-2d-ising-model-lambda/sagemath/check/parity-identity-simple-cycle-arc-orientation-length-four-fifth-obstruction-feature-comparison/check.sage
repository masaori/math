"""四特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する四つの障害を除く特徴を加えた有限合同系から、
第五の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing four-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-fourth-obstruction-feature-comparison/check.sage")

fifth_obstruction = next(
    row for row in four_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (fifth_obstruction * four_times_extended).is_zero()
assert fifth_obstruction * restricted_rhs == 1
fifth_indices = tuple(fifth_obstruction.nonzero_positions())
assert fifth_indices == (
    632, 1162, 1220, 1361, 1401, 1413, 1438, 1448, 4322, 4372, 6589,
    6616, 6685, 6772, 6840, 6924, 6940, 6950)
print("FIFTH OBSTRUCTION: support=%d indices=%s" %
      (len(fifth_indices), fifth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in fifth_indices:
    for (entry_row, column), value in entries.items():
        if entry_row == row_index:
            aggregate[column] += value
aggregate_columns = tuple(aggregate.nonzero_positions())
aggregate_free = tuple(column for column in aggregate_columns if column in free_position)
aggregate_length_four = tuple(
    all_types[column] for column in aggregate_columns if column in assigned_values)
assert aggregate_free == ()
assert GF(2)(sum(candidate_value(arc_type) for arc_type in aggregate_length_four)) == 0
assert GF(2)(sum(joint_keys[index][3] for index in fifth_indices)) == 1
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
assert len(noncancelling) == 975
assert noncancelling_linear == [
    "step0_e_down", "step0_e_right", "step0_wrap_rowlast", "step0_d_left",
    "step1_e_left", "step1_e_right", "step1_wrap_col0", "step1_wrap_collast",
    "step2_e_up", "step2_e_down", "step2_wrap_rowlast", "step2_wrap_col0",
    "step2_d_up", "step2_d_right", "step3_e_up", "step3_e_left",
    "step3_wrap_col0", "step3_d_up", "end0_e_up", "end0_e_down",
    "end0_d_left", "end0_e_left", "end0_c_left", "end0_d_right",
    "end0_e_right", "end0_c_right", "end0_wrap_col0", "end0_wrap_collast",
    "end1_e_up", "end1_e_down", "end1_d_left", "end1_e_left",
    "end1_c_left", "end1_d_right", "end1_e_right", "end1_c_right",
    "end1_wrap_col0", "end1_wrap_collast"]

# 先行する四特徴は第五の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を第五候補にする。
assert fifth_obstruction * distinguishing_column == 0
assert fifth_obstruction * second_column == 0
assert fifth_obstruction * third_column == 0
assert fifth_obstruction * fourth_column == 0
if noncancelling_linear:
    fifth_feature_name = noncancelling_linear[0]
    fifth_feature = named_product(fifth_feature_name, fifth_feature_name)
else:
    fifth_feature_name, first, second = noncancelling[0]
    fifth_feature = named_product(names[first], names[second])
fifth_column = feature_column(fifth_feature)
assert fifth_obstruction * fifth_column == 1
five_times_extended = four_times_extended.augment(fifth_column.column())
five_times_extended_rank = five_times_extended.rank()
five_times_extended_augmented_rank = five_times_extended.augment(
    restricted_rhs.column()).rank()
five_times_extended_solvable = (
    five_times_extended_rank == five_times_extended_augmented_rank)
print("FIFTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    fifth_feature_name, five_times_extended_rank,
    five_times_extended_augmented_rank, five_times_extended_solvable), flush=True)
assert (fifth_feature_name, five_times_extended_rank,
        five_times_extended_augmented_rank, five_times_extended_solvable) == (
            "step0_e_down", 6307, 6308, False)

print("PASS: fifth obstruction features compared")
