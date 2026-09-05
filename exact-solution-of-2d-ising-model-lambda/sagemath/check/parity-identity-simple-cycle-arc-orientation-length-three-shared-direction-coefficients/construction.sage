"""語長三の非切断項の方向対係数を、三つの語位置で共通にする。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-same-position-sufficiency/construction.sage")


def shared_direction_groups(names):
    """切断旗の積は個別係数、語位置内の同じ方向対三項は一つの係数。"""
    wrap_groups = tuple((pair,) for pair in wrap_quadratic_pairs(names))
    directions = ("up", "down", "left", "right")
    shared = tuple(tuple((names.index("step%d_e_%s" % (step, directions[i])),
                          names.index("step%d_e_%s" % (step, directions[j])))
                         for step in range(3))
                   for i in range(4) for j in range(i + 1, 4))
    return wrap_groups + shared


def shared_direction_system(entries, rhs, all_types, column_index, types, groups):
    """三位置の単項式の和を一列にし、端点内の非切断項は含めない。"""
    combined = dict(entries)
    start = len(all_types)
    for offset, arc_type in enumerate(types):
        bits = arc_feature_bits(arc_type)
        row = len(rhs) + offset
        combined[(row, column_index[arc_type])] = GF(2)(1)
        for index, group in enumerate(groups):
            value = GF(2)(sum(bits[i] * bits[j] for i, j in group))
            if value:
                combined[(row, start + index)] = value
    return (matrix(GF(2), len(rhs) + len(types), start + len(groups), combined),
            vector(GF(2), list(rhs) + [0] * len(types)))
