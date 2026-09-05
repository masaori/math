"""語長一・二の切断旗局在を保ち、語長三にも同じ形を課す厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-two-joint-localization/construction.sage")


def arc_feature_bits(arc_type):
    """反転正準化された語と両切断端点を、従来と同じ順序で平坦化する。"""
    assert arc_type[0] == "arc"
    bits = []
    for orientation, wraps, extras in arc_type[1]:
        assert len(orientation) == len(wraps) == len(extras[0]) == 4
        assert len(extras) == 1
        bits.extend(orientation + wraps + extras[0])
    for memberships, wraps in arc_type[2]:
        for _, in_doubled, in_single, in_chosen in memberships:
            bits.extend((in_doubled, in_single, in_chosen))
        bits.extend(wraps)
    assert len(bits) == 12 * len(arc_type[1]) + 32
    assert all(bit in (0, 1) for bit in bits)
    return tuple(bits)


def arc_feature_names(length):
    slots = ("up", "down", "left", "right")
    wraps = ("row0", "rowlast", "col0", "collast")
    names = []
    for step in range(length):
        names += ["step%d_e_%s" % (step, slot) for slot in slots]
        names += ["step%d_wrap_%s" % (step, flag) for flag in wraps]
        names += ["step%d_d_%s" % (step, slot) for slot in slots]
    for endpoint in ("end0", "end1"):
        for slot in slots:
            for kind in ("d", "e", "c"):
                names.append("%s_%s_%s" % (endpoint, kind, slot))
        names += ["%s_wrap_%s" % (endpoint, flag) for flag in wraps]
    return tuple(names)


def wrap_quadratic_pairs(names):
    """切断旗を少なくとも一方に含む相異なる二成分の積だけを残す。"""
    return tuple((first, second)
                 for first in range(len(names))
                 for second in range(first + 1, len(names))
                 if "wrap" in names[first] or "wrap" in names[second])


def joint_localized_system(entries, rhs, all_types, column_index, lengths):
    """零に固定する係数を未知数から除いた、従来の拘束系と同値な系。

    弧型の値は全語長・閉路型について自由未知数として残す。指定語長の弧型に
    だけ、値と切断旗を含む二次単項式の和が等しいという行を追加する。
    定数項・一次項・切断旗を含まない二次項の係数は最初から零である。
    """
    combined = dict(entries)
    next_row, next_column = len(rhs), len(all_types)
    blocks = {}
    for length in lengths:
        types = tuple(t for t in all_types
                      if t[0] == "arc" and len(t[1]) == length)
        names = arc_feature_names(length)
        pairs = wrap_quadratic_pairs(names)
        start = next_column
        for arc_type in types:
            bits = arc_feature_bits(arc_type)
            assert len(bits) == len(names)
            combined[(next_row, column_index[arc_type])] = GF(2)(1)
            for offset, (first, second) in enumerate(pairs):
                if bits[first] * bits[second] == 1:
                    combined[(next_row, start + offset)] = GF(2)(1)
            next_row += 1
        next_column += len(pairs)
        blocks[length] = (types, names, pairs, start)
    result = matrix(GF(2), next_row, next_column, combined)
    result_rhs = vector(GF(2), list(rhs) + [0] * (next_row - len(rhs)))
    return result, result_rhs, blocks
