"""先頭語位置・先頭端点間の異軸混合積を、単一辺所属がある側で二分する。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-step0-end0-transverse-slot-mixed-membership-joint/construction.sage")


def step0_end0_membership_direction(first_name, second_name, single_at):
    first = first_name.split("_")
    second = second_name.split("_")
    if not step0_end0_transverse_slot_mixed_membership(first_name, second_name):
        return False
    membership_by_block = {first[0]: first[1], second[0]: second[1]}
    other_block = "end0" if single_at == "step0" else "step0"
    return (membership_by_block[single_at] == "e"
            and membership_by_block[other_block] == "d")


def length_two_step0_end0_membership_direction_system(
        entries, rhs, all_types, column_index, single_at):
    assert single_at in {"step0", "end0"}
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
                                        or cross_block_same_slot_mixed_membership(names[i], names[j])
                                        or cross_block_opposite_collinear_slot_mixed_membership(
                                            names[i], names[j])
                                        or step0_end0_membership_direction(
                                            names[i], names[j], single_at))))))
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
