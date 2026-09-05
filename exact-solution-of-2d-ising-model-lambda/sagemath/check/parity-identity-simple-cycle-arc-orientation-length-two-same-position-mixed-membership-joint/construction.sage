"""語長二の同所属積に、同じ署名位置の単一辺・二重辺所属の混合積だけを加える。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")


def same_membership_position(first_name, second_name):
    first = first_name.split("_")
    second = second_name.split("_")
    return (first[0], first[2]) == (second[0], second[2])


def length_two_same_position_mixed_membership_joint_system(entries, rhs, all_types, column_index):
    combined = dict(entries)
    values = list(rhs)
    next_row, next_column = len(rhs), len(all_types)
    blocks = {}
    for length in (1, 2, 3):
        types = tuple(t for t in all_types if t[0] == "arc" and len(t[1]) == length)
        names = arc_feature_names(length)
        pairs = tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names))
                      if length == 1 or "wrap" in names[i] or "wrap" in names[j]
                      or (length == 2 and
                          ((names[i].split("_")[1], names[j].split("_")[1])
                           in (("e", "e"), ("d", "d"))
                           or ({names[i].split("_")[1], names[j].split("_")[1]} == {"e", "d"}
                               and same_membership_position(names[i], names[j])))))
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
