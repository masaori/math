"""語長一・二・三の非切断項を上辺所属と左辺所属の積の和へ固定する。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")


def short_word_fixed_interior_system(entries, rhs, all_types, column_index):
    result, zero_rhs, blocks = joint_localized_system(
        entries, rhs, all_types, column_index, (1, 2, 3))
    values = list(rhs)
    for length, (types, names, pairs, start) in blocks.items():
        values.extend(GF(2)(sum(step[0][0] * step[0][2] for step in arc_type[1]))
                      for arc_type in types)
    return result, vector(GF(2), values), blocks
