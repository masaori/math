"""語長三の固定項を保ち、語長一・二に純二次式を許す。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")


def short_pure_quadratic_fixed_third_system(entries, rhs, all_types, column_index):
    combined = dict(entries)
    values = list(rhs)
    next_row, next_column = len(rhs), len(all_types)
    blocks = {}
    for length in (1, 2, 3):
        types = tuple(t for t in all_types if t[0] == "arc" and len(t[1]) == length)
        names = arc_feature_names(length)
        pairs = (tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names)))
                 if length in (1, 2) else wrap_quadratic_pairs(names))
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
