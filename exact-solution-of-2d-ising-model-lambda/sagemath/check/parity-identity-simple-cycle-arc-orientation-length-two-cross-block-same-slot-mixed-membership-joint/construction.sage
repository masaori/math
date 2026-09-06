"""位置内の両所属混合積に、異なる位置ブロックの同名辺スロットを結ぶ積を加える。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-position-block-mixed-membership-joint/construction.sage")


def cross_block_same_slot_mixed_membership(first_name, second_name):
    first = first_name.split("_")
    second = second_name.split("_")
    return (first[0] != second[0]
            and first[2] == second[2]
            and {first[1], second[1]} == {"e", "d"})


def length_two_cross_block_same_slot_mixed_membership_joint_system(
        entries, rhs, all_types, column_index):
    combined = dict(entries)
    values = list(rhs)
    next_row, next_column = len(rhs), len(all_types)
    blocks = {}
    for length in (1, 2, 3):
        types = tuple(t for t in all_types if t[0] == "arc" and len(t[1]) == length)
        names = arc_feature_names(length)
        pairs = tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names))
                      if length == 1 or "wrap" in names[i] or "wrap" in names[j]
                      or (length == 2
                          and ((names[i].split("_")[1], names[j].split("_")[1])
                               in (("e", "e"), ("d", "d"))
                               or ({names[i].split("_")[1], names[j].split("_")[1]} == {"e", "d"}
                                   and (same_membership_position_block(names[i], names[j])
                                        or cross_block_same_slot_mixed_membership(names[i], names[j]))))))
        start = next_column
        for arc_type in types:
            bits = arc_feature_bits(arc_type)
            assert len(bits) == len(names)
            combined[(next_row, column_index[arc_type])] = GF(2)(1)
            for offset, (i, j) in enumerate(pairs):
                if bits[i] * bits[j]:
                    combined[(next_row, start + offset)] = GF(2)(1)
            values.append(GF(2)(sum(step[0][0] * step[0][2] for step in arc_type[1])
                                if length == 3 else 0))
            next_row += 1
        next_column += len(pairs)
        blocks[length] = (types, names, pairs, start)
    return matrix(GF(2), next_row, next_column, combined), vector(GF(2), values), blocks
