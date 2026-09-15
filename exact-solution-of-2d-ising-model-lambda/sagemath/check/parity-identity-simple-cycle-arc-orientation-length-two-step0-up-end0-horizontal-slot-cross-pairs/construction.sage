"""先頭端点の左右から所属向きの異なる項を一つずつ選ぶ。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-step0-up-end0-horizontal-slot-split/construction.sage")


def step0_up_end0_slot_membership_pair(
        first_name, second_name, single_at, end0_slot):
    if single_at not in {"step0", "end0"}:
        raise ValueError("not a membership side: %s" % single_at)
    if end0_slot not in {"left", "right"}:
        raise ValueError("not a horizontal end0 slot: %s" % end0_slot)
    if not step0_end0_membership_direction(first_name, second_name, single_at):
        return False
    by_block = {name.split("_")[0]: name for name in (first_name, second_name)}
    return (by_block["step0"].split("_")[-1] == "up"
            and by_block["end0"].split("_")[-1] == end0_slot)


def length_two_step0_up_end0_horizontal_slot_cross_system(
        entries, rhs, all_types, column_index,
        step0_single_end0_slot, end0_single_end0_slot):
    assert step0_single_end0_slot in {"left", "right"}
    assert end0_single_end0_slot in {"left", "right"}
    assert step0_single_end0_slot != end0_single_end0_slot
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
                                        or step0_up_end0_slot_membership_pair(
                                            names[i], names[j], "step0",
                                            step0_single_end0_slot)
                                        or step0_up_end0_slot_membership_pair(
                                            names[i], names[j], "end0",
                                            end0_single_end0_slot))))))
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
