"""十九特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する十九の障害を除く特徴を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing nineteen-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-nineteenth-obstruction-feature-comparison/check.sage")

twentieth_obstruction = next(
    row for row in nineteen_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (twentieth_obstruction * nineteen_times_extended).is_zero()
assert twentieth_obstruction * restricted_rhs == 1
twentieth_indices = tuple(twentieth_obstruction.nonzero_positions())
assert twentieth_indices == (
    60, 61, 2212, 2269, 3372, 3379, 3411, 3413, 4015, 4129, 4132,
    4138, 4157, 4175, 4226, 4707, 5372, 5429, 5884, 6395, 6417,
    6437, 6467, 6504, 6530, 6539, 6544, 6549, 6574, 6639, 6683,
    6704, 6720, 6729, 6901, 6903)
print("TWENTIETH OBSTRUCTION: support=%d indices=%s" %
      (len(twentieth_indices), twentieth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in twentieth_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in twentieth_indices))
assert candidate_sum != target_sum
print("AGGREGATE: length_four_types=%d candidate_sum=%s target_sum=%s" %
      (len(aggregate_length_four), candidate_sum, target_sum), flush=True)
assert (len(aggregate_length_four), candidate_sum, target_sum) == (30, 1, 0)

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
assert len(noncancelling) == 1140
assert noncancelling_linear == [
    "step1_wrap_collast", "step1_d_down", "step1_d_right", "step2_e_left",
    "step2_e_right", "step2_wrap_row0", "step2_wrap_rowlast",
    "step2_wrap_collast", "step2_d_up", "step2_d_down", "step3_e_up",
    "step3_e_down", "step3_wrap_row0", "step3_wrap_collast", "step3_d_up",
    "step3_d_right"]

# 先行する十九特徴は今回の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を次の候補にする。
for column in (
        distinguishing_column, second_column, third_column, fourth_column,
        fifth_column, sixth_column, seventh_column, eighth_column, ninth_column,
        tenth_column, eleventh_column, twelfth_column, thirteenth_column,
        fourteenth_column, fifteenth_column, sixteenth_column,
        seventeenth_column, eighteenth_column, nineteenth_column):
    assert twentieth_obstruction * column == 0
if noncancelling_linear:
    twentieth_feature_name = noncancelling_linear[0]
    twentieth_feature = named_product(
        twentieth_feature_name, twentieth_feature_name)
else:
    twentieth_feature_name, first, second = noncancelling[0]
    twentieth_feature = named_product(names[first], names[second])
twentieth_column = feature_column(twentieth_feature)
assert twentieth_obstruction * twentieth_column == 1
twenty_times_extended = nineteen_times_extended.augment(
    twentieth_column.column())
twenty_times_extended_rank = twenty_times_extended.rank()
twenty_times_extended_augmented_rank = twenty_times_extended.augment(
    restricted_rhs.column()).rank()
twenty_times_extended_solvable = (
    twenty_times_extended_rank == twenty_times_extended_augmented_rank)
print("TWENTIETH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    twentieth_feature_name, twenty_times_extended_rank,
    twenty_times_extended_augmented_rank,
    twenty_times_extended_solvable), flush=True)
assert (twentieth_feature_name, twenty_times_extended_rank,
        twenty_times_extended_augmented_rank,
        twenty_times_extended_solvable) == (
            "step1_wrap_collast", 6322, 6323, False)

print("PASS: twentieth obstruction features compared")
