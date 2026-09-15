"""語長四候補を反証する五鍵の特徴比較。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式の語長四候補を反証した左核の五鍵について、鍵そのものと
奇数回現れる語長四弧型を有限集合と F_2 の厳密演算だけで比較する。
"""

print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-wrap-position-formula/check.sage")

# `check.sage` が構成した obstruction と assigned_values をそのまま用いる。
obstruction_indices = tuple(obstruction.nonzero_positions())
assert obstruction_indices == (634, 654, 670, 696, 698)


def edge_name(edge):
    kind, row, column = edge
    return "%s%d%d" % (kind, row, column)


def key_name(key):
    side, doubled, single, term = key
    return {
        "side": ZZ(side),
        "doubled": tuple(edge_name(edge) for edge in sorted(doubled)),
        "single": tuple(edge_name(edge) for edge in sorted(single)),
        "target": ZZ(term),
    }


selected_keys = tuple(joint_keys[index] for index in obstruction_indices)
key_descriptions = tuple(key_name(key) for key in selected_keys)
print("KEYS:")
for index, description in zip(obstruction_indices, key_descriptions):
    print("  %d: %s" % (index, description))

# 五行を足したときに奇数回残る弧型を、自由型と固定した語長四型へ分ける。
aggregate = vector(GF(2), len(all_types))
for row_index in obstruction_indices:
    for (entry_row, column), value in entries.items():
        if entry_row == row_index:
            aggregate[column] += value
aggregate_columns = tuple(aggregate.nonzero_positions())
aggregate_free = tuple(column for column in aggregate_columns if column in free_position)
aggregate_length_four = tuple(
    all_types[column] for column in aggregate_columns if column in assigned_values)
assert aggregate_free == ()
print("AGGREGATE: length_four_types=%d candidate_sum=%d target_sum=%d" % (
    len(aggregate_length_four),
    ZZ(sum(candidate_value(arc_type) for arc_type in aggregate_length_four)),
    ZZ(sum(key[3] for key in selected_keys)),
))
for arc_type in aggregate_length_four:
    names = arc_feature_names(4)
    bits = arc_feature_bits(arc_type)
    active = tuple(name for name, bit in zip(names, bits) if bit)
    print("  ARC candidate=%d active=%s" % (ZZ(candidate_value(arc_type)), active))

assert GF(2)(sum(candidate_value(arc_type) for arc_type in aggregate_length_four)) == 0
assert GF(2)(sum(key[3] for key in selected_keys)) == 1


def feature_column(feature):
    """各鍵に現れる語長四弧型の feature 値の和を列にする。"""
    values = [GF(2)(0)] * len(rhs)
    for (row_index, column), coefficient in entries.items():
        if column in assigned_values:
            values[row_index] += coefficient * feature(all_types[column])
    return vector(GF(2), values)


def named_product(first_name, second_name):
    names = arc_feature_names(4)
    first = names.index(first_name)
    second = names.index(second_name)

    def feature(arc_type):
        bits = arc_feature_bits(arc_type)
        return GF(2)(bits[first] * bits[second])

    return feature


# 二つの残余弧型は端点署名が同じで、先頭内部頂点の横向き単辺に対する
# 縦向き二重辺が上か下かだけでも区別できる。その最小の交差所属積を一列
# だけ候補へ加え、この五鍵の障害を除けるかと 7,085 鍵全体との両立性を分けて判定する。
distinguishing_feature_name = "step0_e_left*step0_d_up"
distinguishing_feature = named_product("step0_e_left", "step0_d_up")
distinguishing_column = feature_column(distinguishing_feature)
assert tuple(distinguishing_feature(arc_type) for arc_type in aggregate_length_four) == (1, 0)
assert obstruction * distinguishing_column == 1
extended = restricted.augment(distinguishing_column.column())
extended_rank = extended.rank()
extended_augmented_rank = extended.augment(restricted_rhs.column()).rank()
extended_solvable = extended_rank == extended_augmented_rank
print("FEATURE: %s rank=%d augmented_rank=%d solvable=%s" % (
    distinguishing_feature_name, extended_rank, extended_augmented_rank, extended_solvable))
assert (extended_rank, extended_augmented_rank, extended_solvable) == (6303, 6304, False)
print("OBSTRUCTION: the feature removes the recorded five-key certificate, but another independent obstruction remains")
print("PASS: five-key obstruction features compared")
