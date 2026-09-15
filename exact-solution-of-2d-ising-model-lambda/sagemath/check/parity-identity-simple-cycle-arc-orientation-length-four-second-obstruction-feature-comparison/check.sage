"""一項を加えた後に残る語長四障害の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ最初の障害を除く交差所属積を加えた有限合同系から、
次の左核矛盾証拠を取り出し、相殺せず残る語長四弧型を比較する。
"""

print("LOAD: constructing first extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-obstruction-feature-comparison/check.sage")

second_obstruction = next(
    row for row in extended.left_kernel_matrix().rows()
    if row * restricted_rhs == 1)
assert (second_obstruction * extended).is_zero()
assert second_obstruction * restricted_rhs == 1
second_indices = tuple(second_obstruction.nonzero_positions())
assert second_indices == (
    60, 61, 2212, 2269, 3372, 3379, 3411, 3413, 4015, 4129, 4132,
    4138, 4157, 4175, 4226, 4707, 5372, 5429, 5884, 6504, 6530,
    6544, 6549, 6639, 6924, 6940, 6950)
print("SECOND OBSTRUCTION: support=%d indices=%s" %
      (len(second_indices), second_indices), flush=True)

# 左核証拠の各行に現れる固定済み語長四弧型を足し、奇数回残るものを得る。
aggregate = vector(GF(2), len(all_types))
for row_index in second_indices:
    for (entry_row, column), value in entries.items():
        if entry_row == row_index:
            aggregate[column] += value
aggregate_columns = tuple(aggregate.nonzero_positions())
aggregate_free = tuple(column for column in aggregate_columns if column in free_position)
aggregate_length_four = tuple(
    all_types[column] for column in aggregate_columns if column in assigned_values)
assert aggregate_free == ()
assert GF(2)(sum(candidate_value(arc_type) for arc_type in aggregate_length_four)) == 0
assert GF(2)(sum(joint_keys[index][3] for index in second_indices)) == 1
print("AGGREGATE: length_four_types=%d candidate_sum=0 target_sum=1" %
      len(aggregate_length_four), flush=True)

names = arc_feature_names(4)
# 一次特徴と二特徴積を全数比較し、証拠上で相殺しない候補を列挙する。
noncancelling = []
noncancelling_linear = []
for first in range(len(names)):
    for second in range(first, len(names)):
        value = GF(2)(sum(
            arc_feature_bits(arc_type)[first] * arc_feature_bits(arc_type)[second]
            for arc_type in aggregate_length_four))
        if value:
            label = names[first] if first == second else names[first] + "*" + names[second]
            noncancelling.append(label)
            if first == second:
                noncancelling_linear.append(label)
print("NONCANCELLING FEATURES: count=%d" % len(noncancelling), flush=True)
print("NONCANCELLING LINEAR FEATURES: %s" %
      (tuple(noncancelling_linear),), flush=True)
assert len(noncancelling) == 652
assert "step0_e_up" in noncancelling_linear

# 最初の証拠で必要だった交差所属積は第二の証拠では相殺する。一方、最も
# 早い位置の一次特徴 step0_e_up は相殺しないので、二つの障害は独立である。
assert second_obstruction * distinguishing_column == 0
second_feature_name = "step0_e_up"
second_feature = named_product(second_feature_name, second_feature_name)
second_column = feature_column(second_feature)
assert second_obstruction * second_column == 1
twice_extended = extended.augment(second_column.column())
twice_extended_rank = twice_extended.rank()
twice_extended_augmented_rank = twice_extended.augment(
    restricted_rhs.column()).rank()
twice_extended_solvable = twice_extended_rank == twice_extended_augmented_rank
print("SECOND FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    second_feature_name, twice_extended_rank, twice_extended_augmented_rank,
    twice_extended_solvable), flush=True)

print("PASS: second obstruction features compared")
