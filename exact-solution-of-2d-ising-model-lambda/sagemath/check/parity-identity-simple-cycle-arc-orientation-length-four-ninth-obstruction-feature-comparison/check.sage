"""八特徴を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行する八つの障害を除く特徴を加えた有限合同系から、
第九の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing eight-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-eighth-obstruction-feature-comparison/check.sage")

ninth_obstruction = next(
    row for row in eight_times_extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (ninth_obstruction * eight_times_extended).is_zero()
assert ninth_obstruction * restricted_rhs == 1
ninth_indices = tuple(ninth_obstruction.nonzero_positions())
assert ninth_indices == (
    634, 654, 670, 696, 698, 6903, 6924, 6940, 6950)
print("NINTH OBSTRUCTION: support=%d indices=%s" %
      (len(ninth_indices), ninth_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in ninth_indices:
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
target_sum = GF(2)(sum(joint_keys[index][3] for index in ninth_indices))
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
assert len(noncancelling) == 554
assert noncancelling_linear == [
    "step0_wrap_row0", "step1_e_up", "step1_e_down", "step1_e_left",
    "step1_e_right", "step1_wrap_row0", "step1_wrap_col0",
    "step1_wrap_collast", "step1_d_up", "step1_d_right",
    "step2_wrap_col0", "step2_wrap_collast", "step3_e_up",
    "step3_e_down", "step3_e_left", "step3_e_right",
    "step3_wrap_row0", "step3_wrap_col0", "step3_wrap_collast",
    "step3_d_down", "step3_d_left"]

# 先行する八特徴は第九の証拠では相殺する。相殺しない特徴のうち、
# 一次特徴があればその最初を、無ければ二特徴積の最初を第九候補にする。
assert ninth_obstruction * distinguishing_column == 0
assert ninth_obstruction * second_column == 0
assert ninth_obstruction * third_column == 0
assert ninth_obstruction * fourth_column == 0
assert ninth_obstruction * fifth_column == 0
assert ninth_obstruction * sixth_column == 0
assert ninth_obstruction * seventh_column == 0
assert ninth_obstruction * eighth_column == 0
if noncancelling_linear:
    ninth_feature_name = noncancelling_linear[0]
    ninth_feature = named_product(ninth_feature_name, ninth_feature_name)
else:
    ninth_feature_name, first, second = noncancelling[0]
    ninth_feature = named_product(names[first], names[second])
ninth_column = feature_column(ninth_feature)
assert ninth_obstruction * ninth_column == 1
nine_times_extended = eight_times_extended.augment(ninth_column.column())
nine_times_extended_rank = nine_times_extended.rank()
nine_times_extended_augmented_rank = nine_times_extended.augment(
    restricted_rhs.column()).rank()
nine_times_extended_solvable = (
    nine_times_extended_rank == nine_times_extended_augmented_rank)
print("NINTH FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    ninth_feature_name, nine_times_extended_rank,
    nine_times_extended_augmented_rank, nine_times_extended_solvable), flush=True)
assert (ninth_feature_name, nine_times_extended_rank,
        nine_times_extended_augmented_rank, nine_times_extended_solvable) == (
            "step0_wrap_row0", 6311, 6312, False)

print("PASS: ninth obstruction features compared")
