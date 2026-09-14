"""可解だった縦軸八項を、先頭語位置の上・下スロットで二分する。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-step0-end0-membership-side-axis-pairs/construction.sage")


def step0_end0_vertical_slot_pair(first_name, second_name, step0_slot):
    if step0_slot not in {"up", "down"}:
        raise ValueError("not a vertical step0 slot: %s" % step0_slot)
    if not step0_end0_transverse_slot_mixed_membership(first_name, second_name):
        return False
    by_block = {name.split("_")[0]: name for name in (first_name, second_name)}
    return by_block["step0"].split("_")[-1] == step0_slot


def length_two_step0_end0_vertical_slot_system(
        entries, rhs, all_types, column_index, step0_slot):
    assert step0_slot in {"up", "down"}
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
                                        or step0_end0_vertical_slot_pair(
                                            names[i], names[j], step0_slot))))))
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
